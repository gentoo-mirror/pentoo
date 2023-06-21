#!/bin/bash

if [ -n "$(command -v id 2> /dev/null)" ]; then
	USERID="$(id -u 2> /dev/null)"
fi

if [ -z "${USERID}" ] && [ -n "$(id -ru)" ]; then
	USERID="$(id -ru)"
fi

if [ -n "${USERID}" ] && [ "${USERID}" != "0" ]; then
	printf "Run it as root\n"
  exit 1;
elif [ -z "${USERID}" ]; then
	printf "Unable to determine user id, permission errors may occur.\n"
fi

#this is bash specific
exec   > >(tee -i /tmp/pentoo-updater.log)
exec  2> >(tee -i /tmp/pentoo-updater.log >&2)
#end bash specific

export WE_FAILED=0
. /etc/profile
env-update

kernel_symlink_fixer() {
  ##adjust /usr/src/linux link if we are pretty sure we won't screw up the system
  KV=$(uname -r)
  if [ -d "/usr/src/linux-${KV}" ] && [ "$(readlink -e /usr/src/linux)" != "/usr/src/linux-${KV}" ]; then
    if /usr/bin/qfile "/usr/src/linux-${KV}" > /dev/null 2>&1; then
      if [ -L /usr/src/linux ]; then
        unlink /usr/src/linux
      fi
      ln -s "/usr/src/linux-${KV}" /usr/src/linux
      if [ -L "/lib/modules/${KV}/build" ]; then
        unlink "/lib/modules/${KV}/build"
      fi
      ln -s "/usr/src/linux-${KV}" "/lib/modules/${KV}/build"
      if [ -L "/lib/modules/${KV}/source" ]; then
        unlink "/lib/modules/${KV}/source"
      fi
      ln -s "/usr/src/linux-${KV}" "/lib/modules/${KV}/source"
    else
      printf "Kernel symlink cannot be correctly set, this is likely to cause failures.\n"
      return 1
    fi
  fi
  return 0
}

setup_env() {
  #colorize the updates even if colors end up in the logs
  export EMERGE_DEFAULT_OPTS="$(portageq envvar EMERGE_DEFAULT_OPTS) --color=y"

  if [ -n "${clst_subarch}" ]; then
    if [ "${clst_subarch}" = "amd64" ]; then
      ARCH="amd64"
      ARCHY="x86_64"
      PROFILE_ARCH="amd64_r1"
    elif [ "${clst_subarch}" = "pentium-m" ]; then
      ARCH="x86"
      ARCHY="x86"
      PROFILE_ARCH="x86"
    fi
  else
    arch=$(uname -m)
    if [ "${arch}" = "i686" ]; then
      ARCH="x86"
      ARCHY="x86"
      PROFILE_ARCH="x86"
    elif [ "${arch}" = "x86_64" ]; then
      ARCH="amd64"
      ARCHY="x86_64"
      PROFILE_ARCH="amd64_r1"
    fi
  fi
  if [ -n "${ARCH}" ]; then
    export ARCH ARCHY PROFILE_ARCH
  else
    printf "Failed to detect arch, some things will be broken\n"
  fi
}

set_java() {
  have_java=$(portageq match / 'app-eselect/eselect-java')
  if [ -z "${have_java}" ]; then
    printf "System doesn't have java, skipping java config.\n"
    return 1
  fi
  java_system=$(eselect java-vm show system | tail -n 1 | tr -d " ")
  if [ "${java_system/17/}" != "${java_system}" ]; then
    return 0
  fi
  wanted_java=$(eselect java-vm list | grep --color=never 17 | tr -d "[]" | awk '{print $2,$1}' | sort | head -n 1 | awk '{print $2}')
  if [ -n "${wanted_java}" ]; then
    if eselect java-vm set system "${wanted_java}"; then
      printf "Successfully set system java vm\n"
      return 0
    else
      printf "Failed to set system java-vm\n"
      return 1
    fi
  else
    printf "Failed to detect available jdk-17\n"
    return 0
  fi
}

set_ruby() {
  if portageq has_version / dev-lang/ruby:3.1; then
    eselect ruby set ruby31
    return 0
  fi
  if portageq has_version / dev-lang/ruby:3.0; then
    eselect ruby set ruby30
    return 0
  fi
  if portageq has_version / dev-lang/ruby:2.7; then
    eselect ruby set ruby27
    return 0
  fi
  if portageq has_version / dev-lang/ruby:2.6; then
    eselect ruby set ruby26
    return 0
  fi
  return 1
}

check_profile () {
  if [ -L "/etc/portage/make.profile" ]; then
    if [ ! -e "/etc/portage/make.profile" ] || [ -n "${1}" ]; then
      failure="0"
      #profile is broken, read the symlink then try to reset it back to what it should be
      printf "Your profile needs to be reset, attempting repair...\n"
      desired="pentoo:$(readlink /etc/portage/make.profile | cut -d'/' -f 8-)"
      if ! eselect profile set "${desired}"; then
        #profile failed to set, try hard to set the right one
        #check if we are hard
        if gcc -v 2>&1 | grep -q Hardened; then
          hardening="hardened"
        else
          hardening="default"
        fi
        #last check binary
        if echo "${desired}" | grep -q binary; then
          binary="/binary"
        else
          binary=""
        fi
        if [ "${failure}" = "0" ]; then
          if ! eselect profile set "pentoo:pentoo/${hardening}/linux/${PROFILE_ARCH}${binary}"; then
            failure="1"
          fi
        fi
      fi
      if [ "${failure}" = "1" ]; then
        printf "Your profile is invalid, and we failed to automatically fix it.\n"
        printf "Please select a profile that works with \"eselect profile list\" and \"eselect profile set ##\"\n"
        exit 1
      else
        printf "Profile set successfully.\n"
      fi
    fi
  fi

  # profile migration routine for amd64 17.0->17.1
  if [ "${ARCH}" = "amd64" ]; then
    if [ -L "/lib" ] || [ -e "/lib32" ] || [ -e "/usr/lib32" ]; then
      migrate_profile || export WE_FAILED=1
    fi
  fi
}

migrate_profile() {
  if [ -L "/lib" ] && [ "${ARCH}" = "amd64" ]; then
    #gentoo has deprecated the 17.0 symlink lib profile for amd64, so let's migrate too
    if ! portageq has_version / unsymlink-lib; then
      emerge -1 app-portage/unsymlink-lib
    fi
    if ! portageq has_version / unsymlink-lib; then
      emerge -1 app-portage/unsymlink-lib
    fi
    if ! portageq has_version / unsymlink-lib; then
      emerge -1 app-portage/unsymlink-lib
    fi
    if ! portageq has_version / unsymlink-lib; then
      export WE_FAILED=1
      return 1
    fi
    unsymlink-lib --analyze || exit 1
    unsymlink-lib --migrate || exit 1
    unsymlink-lib --finish || exit 1
    if readlink /etc/portage/make.profile | grep -qE 'pentoo/hardened/linux/amd64$|pentoo/hardened/linux/amd64/'; then
      check_profile force
    fi
  fi
  if [ -L "/lib32" ] || [ -L "/usr/lib32" ]; then
    rebuild_lib32
    rebuild_lib32 || export WE_FAILED=1
  fi
  if [ -L "/lib32" ] && ! qfile /lib32 > /dev/null 2>&1; then
    rm -rf "/lib32"
  fi
  if [ -L "/usr/lib32" ] && ! qfile /usr/lib32 > /dev/null 2>&1; then
    rm -rf "/usr/lib32"
  fi
  return 0
}

rebuild_lib32() {
  REBUILD_DIRS=""
  if [ -L "/lib32" ]; then
    REBUILD_DIRS="/lib32"
  fi
  if [ -L "/usr/lib32" ]; then
    REBUILD_DIRS="${REBUILD_DIRS} /usr/lib32"
  fi
  if ls /usr/lib/llvm/*/lib32 > /dev/null 2>&1; then
    REBUILD_DIRS="${REBUILD_DIRS} /usr/lib/llvm/*/lib32"
  fi
  if [ -n "${REBUILD_DIRS}" ]; then
    if [ -n "${clst_target}" ]; then
      emerge -1v --deep --usepkg=n --buildpkg=y ${REBUILD_DIRS}
    else
      emerge -1v --deep ${REBUILD_DIRS}
    fi
    return $?
  else
    return 0
  fi
}

update_kernel() {
  #bigger updates can fail, so make sure at least all this stuff is up to date
  emerge --update virtual/linux-sources sys-kernel/genkernel sys-kernel/linux-firmware sys-firmware/intel-microcode --oneshot || safe_exit
  bestkern="$(qlist $(portageq best_version / pentoo-sources 2> /dev/null) | grep 'distro/Kconfig' | awk -F'/' '{print $4}' | cut -d'-' -f 2-)"
  bestkern_pv="$(portageq best_version / pentoo-sources | cut -d'-' -f 4-)"
  if [ -z "${bestkern}" ]; then
    printf "Failed to find pentoo-sources installed, is this a Pentoo system?\n"
  #  bestkern="$(qlist $(portageq best_version / gentoo-sources 2> /dev/null) | grep 'distro/Kconfig' | awk -F'/' '{print $4}' | cut -d'-' -f 2-)"
  #  bestkern_pv="$(portageq best_version / gentoo-sources | cut -d'-' -f 4-)"
  #  if [ -z "${bestkern}" ]; then
  #    printf "Failed to find gentoo-sources as well, giving up.\n"
      return 1
  #  fi
  fi

  #first we check for a config
  local_config="/usr/share/pentoo-sources/config-${ARCH}-${bestkern_pv}"
  if [ ! -r "${local_config}" ]; then
    printf "Unable to find a viable config for ${bestkern}, skipping update.\n"
    return 1
  else
    #okay, we have a config, now we mangle it for x86 as appropriate
    if [ "${ARCH}" = "x86" ] && grep -q pae /proc/cpuinfo; then
      printf "PAE support found.\n"
      sed -i '/^CONFIG_HIGHMEM4G/s/CONFIG_HIGHMEM4G/# CONFIG_HIGHMEM4G/' "${local_config}"
      sed -i '/^# *CONFIG_HIGHMEM64G/s/^# *//' "${local_config}"
      sed -i '/^CONFIG_HIGHMEM64G/s/ .*/=y/' "${local_config}"
      oldpwd=$(pwd)
      cd "/usr/src/linux-${bestkern}"
      make olddefconfig
      cd "${oldpwd}"
      unset oldpwd
      printf "PAE enabled.\n"
    fi
  fi
  #next we fix the symlink
  if [ "$(readlink /usr/src/linux)" != "linux-${bestkern}" ]; then
    unlink /usr/src/linux
    ln -s "linux-${bestkern}" /usr/src/linux
  fi

  currkern="$(uname -r)"
  if [ "${currkern}" != "${bestkern}" ]; then
    printf "Currently running kernel ${currkern} is out of date.\n"
    if [ -x "/usr/src/linux-${bestkern}/vmlinux" ] && [ -r "/lib/modules/${bestkern}/modules.dep" ]; then
      if [ -r /etc/kernels/kernel-config-${bestkern} ]; then
        printf "Kernel ${bestkern} appears ready to go, please reboot when convenient.\n"
        return 0
      else
        printf "Kernel ${bestkern} doesn't appear ready for use, rebuilding...\n"
      fi
    else
      printf "Updated kernel ${bestkern} available, building...\n"
    fi
  elif [ -r /etc/kernels/kernel-config-${bestkern} ]; then
    printf "No updated kernel or config found. No kernel changes needed.\n"
    return 0
  elif [ -r /etc/kernels/kernel-config-${ARCHY}-${bestkern} ]; then
    printf "No updated kernel or config found. No kernel changes needed.\n"
    return 0
  else
    printf "Kernel ${bestkern} doesn't appear ready for use, rebuilding...\n"
  fi

  #update kernel command line as needed
  #if ! grep -q usbfs_memory_mb /etc/default/grub; then
  #  #usbfs_memory_mb controls how much ram the usb system is allowed to use.  The default limit is 16M which is insanely low.
  #  #we don't really need a limit here, so just remove the limit because why not
  #  sed -i 's#GRUB_CMDLINE_LINUX="#GRUB_CMDLINE_LINUX="usbcore.usbfs_memory_mb=0 #' /etc/default/grub
  #fi
  if grep -q 'root=/dev/ram0' /etc/default/grub; then
    #this is hasn't been required for a long time, so just stop
    sed -i 's#root=/dev/ram0"#root=/dev/ram0#g' /etc/default/grub
  fi

  #then we set genkernel options as needed
  genkernelopts="--kernel-config=/usr/share/pentoo-sources/config-${ARCH}-${bestkern_pv} --compress-initramfs-type=zstd --bootloader=grub2 --save-config --kernel-filename=kernel-genkernel-%%ARCH%%-%%KV%% --initramfs-filename=initramfs-genkernel-%%ARCH%%-%%KV%% --systemmap-filename=System.map-genkernel-%%ARCH%%-%%KV%% --kernel-localversion=UNSET --module-rebuild --save-config --no-microcode-initramfs --check-free-disk-space-bootdir=50"
  if grep -q btrfs /etc/fstab || grep -q btrfs /proc/cmdline; then
    genkernelopts="${genkernelopts} --btrfs"
  fi
  if grep -q zfs /etc/fstab || grep -q zfs /proc/cmdline || grep -q zfs /proc/mounts; then
    genkernelopts="${genkernelopts} --zfs"
  fi
  if grep -q 'ext[234]' /etc/fstab; then
    genkernelopts="${genkernelopts} --e2fsprogs"
  fi
  if grep -q gpg /proc/cmdline; then
    genkernelopts="${genkernelopts} --luks --gpg"
  elif grep -q luks /etc/fstab || grep -E '^swap|^source' /etc/conf.d/dmcrypt; then
    genkernelopts="${genkernelopts} --luks"
  fi
  #then we go nuts
  if genkernel ${genkernelopts} --module-rebuild-cmd="emerge @module-rebuild" all; then
    printf "Kernel ${bestkern} built successfully, please reboot when convenient.\n"
    return 0
  else
    printf "Kernel ${bestkern} failed to build, please see logs above.\n"
    return 1
  fi
}

safe_exit() {
  #I want a shell when I'm in catalyst but just an exit on failure for users
  if [ -n "${clst_target}" ] && [ -n "${debugshell}" ]; then
    /bin/bash
  #elif [ -n "${clst_target}" ] && [ -n "${reckless}" ]; then
    #reckless doesn't really exist anymore
    #we are always reckless
  #  true
  else
    printf "FAILURE FAILURE FAILURE\n" 1>&2
    printf "Continuing despite failure...grumble grumble\n" 1>&2
    printf "FAILURE FAILURE FAILURE\n" 1>&2
    export WE_FAILED=1
  fi
}

pre_sync_fixes() {
  #sometimes binpkgs are size 0, and that's not okay
  find "$(portageq envvar PKGDIR)" -size 0 -delete
  # this bug breaks --sync and EVERYTHING ELSE so it gets fixed first
  #adjust the portage version to check for once the bug is fixed
  bug903917="$(portageq match / '<sys-apps/portage-3.0.46')"
  if [ -n "${bug903917}" ]; then
    #https://bugs.gentoo.org/903917
    removed_bad_pkg=0
    for maybe_bad_pkg in "$(portageq envvar PKGDIR)"/dev-python/jupyter-server/jupyter-server-*.gpkg.tar*; do
      if [ -f "${maybe_bad_pkg}" ]; then
        rm -f "${maybe_bad_pkg}"
        removed_bad_pkg=1
      fi
    done
    if [ "${removed_bad_pkg}" = 1 ]; then
      printf "Potentially broken binary packages found and removed.\n"
    fi
  fi
}

do_sync() {
  if [ -f "/usr/portage/metadata/timestamp.chk" ]; then
    read -r portage_timestamp <  /usr/portage/metadata/timestamp.chk
  elif [ -f "/var/db/repos/gentoo/metadata/timestamp.chk" ]; then
    read -r portage_timestamp <  /var/db/repos/gentoo/metadata/timestamp.chk
  fi
  portage_date=`date --date="$portage_timestamp" '+%Y%m%d%H%M' -u`
  minutesDiff=$(( `date '+%Y%m%d%H%M' -u` - $portage_date ))
  if [ $minutesDiff -lt 60 ]
  then
    echo "The last sync was $minutesDiff minutes ago (<1 hour), skipping"
    return
  fi

  # People seem to break these permissions a lot, so just set them.  it takes <3 seconds on my box
  chown -R portage:portage "$(portageq get_repo_path / gentoo)"
  chown -R portage:portage "$(portageq get_repo_path / pentoo)"
  if ! emerge --sync; then
    if [ -e /etc/portage/repos.conf/pentoo.conf ] && grep -q pentoo.asc /etc/portage/repos.conf/pentoo.conf; then
      printf "Pentoo repo key incorrectly defined, fixing..."
      sed -i 's#pentoo.asc#pentoo-keyring.asc#' /etc/portage/repos.conf/pentoo.conf
      if grep -q pentoo.asc /etc/portage/repos.conf/pentoo.conf; then
        printf "FAILED\n"
        exit 1
      else
        printf "OK\n"
        printf "Please re-run pentoo-updater.\n"
        exit 0
      fi
    else
      printf "emerge --sync failed, aborting update for safety\n"
      exit 1
    fi
  fi
}

main_checks() {
  setup_env
  if [ -z "${clst_target}" ]; then
    if kernel_symlink_fixer; then
      KERNEL_SYMLINK=0
    else
      KERNEL_SYMLINK=1
    fi
  fi
  #check profile, manage repo, ensure valid python selected
  check_profile
  pre_sync_fixes
  if [ -n "${clst_target}" ]; then #we are in catalyst
    mkdir -p /var/log/portage/emerge-info/
    emerge --info > /var/log/portage/emerge-info/emerge-info-$(date "+%Y%m%d").txt
  else #we are on a user system
    [ "${NO_SYNC}" = "true" ] || do_sync
    check_profile
    if [ -d /var/db/repos/pentoo ] && [ -d /var/lib/layman/pentoo ]; then
      printf "Pentoo now manages it's overlay through portage instead of layman.\n"
      if [ -x /usr/bin/layman ]; then
        if /usr/bin/layman -l | grep -q pentoo; then
          printf "Removing Pentoo overlay from layman...\n"
          layman --delete pentoo
          check_profile
        fi
      else
        printf "Cleaning up the mess left behind by layman...\n"
        rm -rf /var/lib/layman/pentoo
        #if layman isn't on the system, it's repos.conf entry should be gone as well
        [ -f /etc/portage/repos.conf/layman.conf ] && mv -f /etc/portage/repos.conf/layman.conf /etc/portage/repos.conf/layman.uninstalled
        grep -q '/var/lib/layman/make.conf' /etc/portage/make.conf && sed -i '/\/var\/lib\/layman\/make.conf/d' /etc/portage/make.conf
        check_profile
      fi
    fi
  fi

  #deep checks for python, including fix
  #first we set the python interpreters to match PYTHON_TARGETS (and ensure the versions we set are actually built)
  PYTHON2=$(emerge --info | grep -oE '^PYTHON_TARGETS=".*(python[23]_[0-9]\s*)+"' | grep -oE 'python2_[0-9]' | cut -d\" -f2 | cut -d" " -f 1 |sed 's#_#.#')
  #PYTHON_SINGLE_TARGET is the *main* python3 implementation
  PYTHON3=$(emerge --info | grep -oE '^PYTHON_SINGLE_TARGET=".*(python3_[0-9]+\s*)+"' | grep -oE 'python3_[0-9]+' | cut -d\" -f2 | sed 's#_#.#')
  if [ -z "${PYTHON2}" ]; then
    printf "Detected Python 2 is disabled\n"
    printf "From PYTHON_TARGETS: $(emerge --info | grep '^PYTHON_TARGETS')\n"
    printf "This is a good thing :-)\n"
  fi
  if [ -z "${PYTHON3}" ]; then
    printf "Failed to autodetect PYTHON_TARGETS\n"
    printf "Detected Python 3: ${PYTHON3:-none}\n"
    printf "From PYTHON_TARGETS: $(emerge --info | grep '^PYTHON_TARGETS')\n"
    printf "From PYTHON_SINGLE_TARGET: $(emerge --info | grep '^PYTHON_SINGLE_TARGET')\n"
    printf "This is fatal, python3 support is required, it is $(date +'%Y')\n"
    exit 1
  fi
  "${PYTHON3}" -c "from _multiprocessing import SemLock" || emerge -1 python:"${PYTHON3#python}"

  #fix python2, if it's even requested
  if [ -n "${PYTHON2}" ]; then
    "${PYTHON2}" -c "from _multiprocessing import SemLock" || emerge -1 python:"${PYTHON2#python}"
  fi

  #always update portage as early as we can (after making sure python works)
  emerge --update --newuse --oneshot --changed-deps --newrepo portage || safe_exit

  removeme14=$(portageq match / '<virtual/libcrypt-2')
  if [ -n "${removeme14}" ]; then
    printf "Removing old libcrypt-1 virtual to ease upgrade to libcrypt-2\n"
    emerge -C "<virtual/libcrypt-2"
  fi

  #upgrade key packages first if we are using binpkgs
  portage_features="$(portageq envvar FEATURES)"
  if [ "${portage_features}" != "${portage_features/getbinpkg//}" ]; then
    #learned something new, if a package updates before glibc and uses the newer glibc, the chance of breakage is
    #*much* higher than if glibc is updated first.  so let's just update glibc first.
    emerge --update --newuse --oneshot --changed-deps --newrepo sys-libs/glibc || safe_exit
    # check if libcrypt is missing
    if [ -z "$(portageq best_version / '>=virtual/libcrypt-2')" ]; then
      emerge --update --newuse --oneshot --changed-deps --newrepo '>=virtual/libcrypt-2'
    fi
    #then we should make sure gcc, binutils, and friends are up to date
    emerge --update --newuse --oneshot --changed-deps --newrepo sys-devel/gcc dev-libs/mpfr dev-libs/mpc dev-libs/gmp sys-devel/binutils sys-libs/binutils-libs
    #then to force the new version to be used, remove the old ones
    emerge --depclean sys-devel/gcc dev-libs/mpfr dev-libs/mpc dev-libs/gmp sys-devel/binutils sys-libs/binutils-libs
  fi

  #modified from news item "Python ABIFLAGS rebuild needed"
  if [ -n "$(find /usr/lib*/python3* -name '*cpython-3[3-5].so')" ]; then
    emerge -1v --usepkg=n --buildpkg=y $(find /usr/lib*/python3* -name '*cpython-3[3-5].so')
  fi
  if [ -n "$(find /usr/include/python3.[3-5] -type f 2> /dev/null)" ]; then
    emerge -1v --usepkg=n --buildpkg=y /usr/include/python3.[3-5]
  fi

  #modified from news item gcc-5-new-c++11-abi
  #gcc_target="x86_64-pc-linux-gnu-5.4.0"
  #if [ "$(gcc-config -c)" != "${gcc_target}" ]; then
  #  if gcc-config -l | grep -q "${gcc_target}"; then
  #    gcc-config "${gcc_target}"
  #    . /etc/profile
  #    revdep-rebuild --library 'libstdc++.so.6' -- --buildpkg=y --usepkg=n --exclude gcc
  #  fi
  #fi

  #migrate what we can from ruby 2.4
  if [ -n "$(portageq match / '<dev-lang/ruby-2.5')" ]; then
    revdep-rebuild --library 'libruby24.so.2.4' -- --buildpkg=y --usepkg=n --exclude ruby
  fi
  #and then ruby 2.5
  if [ -n "$(portageq match / '<dev-lang/ruby-2.6')" ]; then
    revdep-rebuild --library 'libruby25.so.2.5' -- --buildpkg=y --usepkg=n --exclude ruby
  fi

  #before we begin main installs, let's remove what may need removing
  #handle hard blocks here, and like this
  removeme=$(portageq match / '<dev-python/setuptools_scm-3')
  if [ -n "${removeme}" ]; then
    printf "Removing old setuptools_scm...\n"
    emerge -C "=${removeme}"
  fi
  removeme2=$(portageq match / '<sys-devel/binutils-2.32-r1')
  if [ -n "${removeme2}" ] && [ -n "$(portageq match / '>=sys-devel/binutils-2.32-r1')" ]; then
    printf "Removing old/broken binutils...\n"
    emerge -C "=${removeme2}"
  fi
  removeme3=$(portageq match / 'dev-tex/xcolor')
  if [ -n "${removeme3}" ]; then
    printf "Removing hardblocked xcolor...\n"
    emerge -C "=${removeme3}"
  fi
  removeme4=$(portageq match / 'dev-libs/capstone-bindings')
  if [ -n "${removeme4}" ]; then
    printf "Removing collision inducing capstone-bindings...\n"
    emerge -C "=${removeme4}"
  fi
  removeme5=$(portageq match / '<dev-libs/openssl-1.1.1')
  if [ -n "${removeme5}" ]; then
    printf "Force updating old openssl...\n"
    emerge --update --nodeps --oneshot openssl
  fi
  removeme6=$(portageq match / '=virtual/jpeg-62')
  if [ -n "${removeme6}" ]; then
    printf "Removing obsolete jpeg-62 virtual\n"
    emerge -C "=${removeme6}"
  fi
  removeme7=$(portageq match / '<dev-python/numpy-1.17')
  if [ -n "${removeme7}" ]; then
    printf "Removing pre-split numpy\n"
    emerge -C "<dev-python/numpy-1.17"
  fi
  removeme8=$(portageq match / '<dev-ruby/bundler-1.17.3-r1')
  if [ -n "${removeme8}" ]; then
    printf "Removing conflicting bundler\n"
    emerge -C "<dev-ruby/bundler-1.17.3-r1"
  fi
  removeme9=$(portageq match / '<dev-ruby/did_you_mean-1.3.1')
  if [ -n "${removeme9}" ]; then
    printf "Removing old did_you_mean\n"
    emerge -C "<dev-ruby/did_you_mean-1.3.1"
  fi
  removeme10=$(portageq match / 'dev-libs/ilbc-rfc3951')
  if [ -n "${removeme10}" ]; then
    printf "Removing obsolete dev-libs/ilbc-rfc3951\n"
    emerge -C "dev-libs/ilbc-rfc3951"
  fi
  removeme11=$(portageq match / '<net-voip/yate-6.2.0')
  if [ -n "${removeme11}" ]; then
    printf "Removing old <net-voip/yate-6.2.0\n"
    emerge -C "<net-voip/yate-6.2.0"
  fi
  removeme12=$(portageq match / '<dev-ruby/metasm-1.0.5')
  if [ -n "${removeme12}" ]; then
    printf "Removing old <dev-ruby/metasm-1.0.5\n"
    emerge -C "<dev-ruby/metasm-1.0.5"
  fi
  removeme13=$(portageq match / 'sys-fs/eudev')
  if [ -n "${removeme13}" ]; then
    printf "Deselecting deprecated eudev if it is selected\n"
    emerge --deselect sys-fs/eudev
  fi
  #removeme14 used above before glibc install
  removeme15=$(portageq match / 'dev-python/prompt_toolkit')
  if [ -n "${removeme15}" ]; then
    printf "Removing prompt_toolkit, replaced by prompt-toolkit\n"
    emerge -C dev-python/prompt_toolkit
  fi

  #before main upgrades, let's set a good java-vm
  set_java
  set_ruby
}

main_upgrades() {
  emerge --buildpkg @changed-deps
  if ! emerge --deep --update --newuse -kb --changed-deps --newrepo @system; then
    emerge --deep --update --newuse -kb --changed-deps --newrepo --with-bdeps=y @system
  fi
  if ! emerge --deep --update --newuse -kb --changed-deps --newrepo @profile; then
    emerge --deep --update --newuse -kb --changed-deps --newrepo --with-bdeps=y @profile
  fi
  if ! emerge --deep --update --newuse -kb --changed-deps --newrepo @world; then
    emerge --deep --update --newuse -kb --changed-deps --newrepo --with-bdeps=y @world
  fi
  set_java #might fail, run it a few times
  set_ruby

  perl-cleaner --modules -- --buildpkg=y || safe_exit

  if ! emerge --deep --update --newuse -kb --changed-deps --newrepo @world; then
    emerge --deep --update --newuse -kb --changed-deps --newrepo --with-bdeps=y @world || safe_exit
  fi
  set_java #might fail, run it a few times
  set_ruby
  if [  -x "$(command -v haskell-updater 2>&1)" ]; then
    haskell-updater
  fi

  #if we are in catalyst, update the extra binpkgs
  if [ -n "${clst_target}" ]; then
    mkdir -p /etc/portage/profile
    #add kde
    echo 'pentoo/pentoo-desktop kde' >> /etc/portage/profile/package.use
    #required for kde
    echo 'media-libs/mesa wayland' >> /etc/portage/profile/package.use
    #add in all the opencl stuff
    echo 'pentoo/pentoo-cracking amdopencl intel-opencl' >> /etc/portage/profile/package.use
    #add in pentoo-extra to build more binpkgs
    echo 'USE="pentoo-extra"' >> /etc/portage/profile/make.defaults
    emerge --buildpkg @changed-deps || safe_exit
    emerge --buildpkg --usepkg --onlydeps --oneshot --deep --update --newuse --changed-deps --newrepo pentoo/pentoo || safe_exit
    etc-update --automode -5 || safe_exit
    #this is the wrong place to rebuild all the packages since it doesn't get fed back into catalyst
    #quickpkg --include-config=y $($(portageq get_repo_path / pentoo)/scripts/binpkgs-missing-rebuild)
    emerge -1 app-portage/recover-broken-vdb
    recover-broken-vdb-find-broken.sh || export WE_FAILED=1
    emerge -C app-portage/recover-broken-vdb
  fi

  if portageq list_preserved_libs /; then
    FEATURES="-getbinpkg" emerge @preserved-rebuild --usepkg=n --buildpkg=y || safe_exit
  fi
  FEATURES="-getbinpkg" smart-live-rebuild 2>&1 || safe_exit
  revdep-rebuild -i -v -- --usepkg=n --buildpkg=y || safe_exit
  if ! emerge --deep --update --newuse -kb --changed-deps --newrepo @world; then
    emerge --deep --update --newuse -kb --changed-deps --newrepo --with-bdeps=y @world || safe_exit
  fi
}

mount_boot() {
  #so since portage is no longer allowed to mount /boot, we need to do it
  if grep '/boot' /etc/fstab | grep -q noauto; then
    #pretty much going to trust fstab and ignore failures here
    mount /boot
  fi
}

umount_boot() {
  if grep '/boot' /etc/fstab | grep -q noauto; then
    #it's set to noauto, so always leave it
    umount /boot
  fi
}

#execution begins here
mount_boot
main_checks

if [ -z "${KERNEL_ONLY}" ]; then
  main_upgrades
else
  emerge --update sys-kernel/pentoo-sources sys-kernel/genkernel sys-kernel/linux-firmware sys-firmware/intel-microcode --oneshot || safe_exit
fi

#we need to do the clean BEFORE we drop the extra flags otherwise all the packages we just built are removed
currkern="$(uname -r)"
if [ "${currkern/pentoo/}" != "${currkern}" ]; then
  exclude="sys-kernel/pentoo-sources:${currkern/-pentoo/}"
elif [ "${currkern/gentoo/}" != "${currkern}" ]; then
  exclude="sys-kernel/pentoo-sources:${currkern/-pentoo/}"
fi
if [ -n "${exclude:-}" ]; then
  if ! EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS/--verbose /}" emerge --depclean --exclude "${exclude}"; then
    emerge --deep --update --newuse -kb --changed-deps --newrepo --with-bdeps=y @world
    EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS/--verbose /}" emerge --depclean --exclude "${exclude}" || safe_exit
  fi
else
  if ! EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS/--verbose /}" emerge --depclean; then
    emerge --deep --update --newuse -kb --changed-deps --newrepo --with-bdeps=y @world
    EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS/--verbose /}" emerge --depclean || safe_exit
  fi
fi
set_java || export WE_FAILED=1 #only tell the updater that this failed if it's still failing at the end
set_ruby || export WE_FAILED=1

if portageq list_preserved_libs /; then
  FEATURES="-getbinpkg" emerge @preserved-rebuild --usepkg=n --buildpkg=y || safe_exit
fi
umount_boot

if [ -n "${clst_target}" ]; then
  if [ -n "${debugshell}" ]; then
    /bin/bash
  fi
  etc-update --automode -5 || safe_exit
  fixpackages || safe_exit
  eclean-pkg --unique-use || safe_exit
  #sometimes binpkgs are size 0, and that's not okay
  find "$(portageq envvar PKGDIR)" -size 0 -delete
  #this is already run as part of eclean-pkg
  #emaint --fix binhost || safe_exit
  #remove kde/mate use flags, and pentoo-extra
  rm -r /etc/portage/profile
else
  #clean the user's systems a bit
  eclean-pkg -d -t 1m
  eclean-dist -d -t 1m
  #sometimes binpkgs are size 0, and that's not okay
  find "$(portageq envvar PKGDIR)" -size 0 -delete
fi

if [ -x "$(portageq get_repo_path / pentoo)/scripts/bug-461824.sh" ]; then
  "$(portageq get_repo_path / pentoo)/scripts/bug-461824.sh"
fi

if [ -z "${clst_target}" ]; then
  update_kernel
fi
if [ "${WE_FAILED}" = "1" ]; then
  printf "\nSomething failed during update. Run pentoo-updater again, if you see\n" 1>&2
  printf "this message again, look through the log at /tmp/pentoo-updater.log for:\n" 1>&2
  printf "FAILURE FAILURE FAILURE\n\n" 1>&2
  printf "For support via irc or discord you can pastebin your log like this (and share the link in chat):\n"
  printf "wgetpaste -s bpaste /tmp/pentoo-updater.log\n\n"
  exit 1
fi
