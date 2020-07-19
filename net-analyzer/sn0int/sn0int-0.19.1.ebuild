# Copyright 2017-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
addr2line-0.12.2
adler32-1.1.0
aho-corasick-0.7.13
ansi_term-0.11.0
anyhow-1.0.31
arrayref-0.3.6
arrayvec-0.5.1
atty-0.2.14
autocfg-1.0.0
backtrace-0.3.49
base64-0.10.1
base64-0.11.0
base64-0.12.2
bitflags-1.2.1
blake2-0.8.1
blake2b_simd-0.5.10
block-buffer-0.7.3
block-padding-0.1.5
boxxy-0.11.0
bs58-0.3.1
bufstream-0.1.4
bumpalo-3.4.0
byte-tools-0.3.1
bytemuck-1.2.0
byteorder-1.3.4
bytes-0.4.12
bytes-0.5.5
bytesize-1.0.1
caps-0.3.4
cc-1.0.54
cfg-if-0.1.10
chrono-0.4.11
chrootable-https-0.15.2
clap-2.33.1
cloudabi-0.0.3
color_quant-1.0.1
colored-1.9.3
constant_time_eq-0.1.5
crc32fast-1.2.0
crossbeam-channel-0.4.2
crossbeam-deque-0.7.3
crossbeam-epoch-0.8.2
crossbeam-queue-0.2.3
crossbeam-utils-0.7.2
crypto-mac-0.7.0
cssparser-0.27.2
cssparser-macros-0.6.0
ct-logs-0.6.0
ctrlc-3.1.4
data-encoding-2.2.1
data-encoding-macro-0.1.8
data-encoding-macro-internal-0.1.8
deflate-0.8.4
der-parser-3.0.4
derive_more-0.99.8
diesel-1.4.5
diesel_derives-1.4.1
diesel_migrations-1.4.0
digest-0.8.1
dirs-2.0.2
dirs-next-1.0.1
dirs-sys-0.3.5
dirs-sys-next-0.1.0
dtoa-0.4.6
dtoa-short-0.3.2
either-1.5.3
embedded-triple-0.1.0
endian-type-0.1.2
enum-as-inner-0.2.1
env_logger-0.7.1
errno-0.2.5
errno-dragonfly-0.1.1
error-chain-0.12.2
failure-0.1.8
failure_derive-0.1.8
fake-simd-0.1.2
filetime-0.2.10
fnv-1.0.7
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futf-0.1.4
futures-0.1.29
futures-cpupool-0.1.8
fxhash-0.2.1
gcc-0.3.55
generator-0.6.21
generic-array-0.12.3
geo-0.13.0
geo-types-0.5.0
getrandom-0.1.14
gif-0.10.3
gimli-0.21.0
glob-0.3.0
h2-0.1.26
heck-0.3.1
hermit-abi-0.1.14
hex-0.3.2
hlua-badtouch-0.4.2
hmac-0.7.1
hostname-0.3.1
html5ever-0.25.1
http-0.1.21
http-0.2.1
http-body-0.1.0
httparse-1.3.4
humantime-1.3.0
hyper-0.12.35
hyper-rustls-0.17.1
idna-0.2.0
image-0.23.6
indexmap-1.4.0
input_buffer-0.3.1
iovec-0.1.4
ipconfig-0.2.2
ipnetwork-0.16.0
itoa-0.4.6
jpeg-decoder-0.1.19
js-sys-0.3.40
kamadak-exif-0.5.1
keccak-0.1.0
kernel32-sys-0.2.2
kuchiki-0.8.0
lazy_static-1.4.0
lexical-core-0.7.4
libc-0.2.71
libflate-0.1.27
libsodium-sys-0.2.5
libsqlite3-sys-0.17.3
line-wrap-0.1.1
linked-hash-map-0.5.3
lock_api-0.3.4
log-0.4.8
loom-0.3.4
lru-cache-0.1.2
lua52-sys-0.1.2
lzw-0.10.0
mac-0.1.1
maplit-1.0.2
markup5ever-0.10.0
match_cfg-0.1.0
matches-0.1.8
maxminddb-0.14.0
maybe-uninit-2.0.0
md-5-0.8.0
memchr-2.3.3
memoffset-0.5.4
migrations_internals-1.4.1
migrations_macros-1.4.2
miniz_oxide-0.3.7
mio-0.6.22
mio-uds-0.6.8
miow-0.2.1
mqtt-protocol-0.8.1
mutate_once-0.1.1
net2-0.2.34
new_debug_unreachable-1.0.4
nibble_vec-0.0.4
nix-0.14.1
nix-0.15.0
nix-0.17.0
nodrop-0.1.14
nom-5.1.2
nude-0.3.0
num-bigint-0.2.6
num-integer-0.1.43
num-iter-0.1.41
num-rational-0.3.0
num-traits-0.2.12
num_cpus-1.13.0
object-0.20.0
once_cell-1.4.0
opaque-debug-0.2.3
opener-0.4.1
os-version-0.1.1
parking_lot-0.9.0
parking_lot_core-0.6.2
pdqselect-0.1.0
pem-0.7.0
percent-encoding-2.1.0
phf-0.8.0
phf_codegen-0.8.0
phf_generator-0.8.0
phf_macros-0.8.0
phf_shared-0.8.0
pkg-config-0.3.17
pledge-0.3.1
pledge-0.4.0
plist-0.5.5
png-0.16.5
ppv-lite86-0.2.8
precomputed-hash-0.1.1
proc-macro-error-1.0.2
proc-macro-error-attr-1.0.2
proc-macro-hack-0.5.16
proc-macro2-0.4.30
proc-macro2-1.0.18
publicsuffix-1.5.4
quick-error-1.2.3
quote-0.6.13
quote-1.0.7
radix_trie-0.1.6
rand-0.7.3
rand_chacha-0.2.2
rand_core-0.5.1
rand_hc-0.2.0
rand_pcg-0.2.1
rayon-1.3.1
rayon-core-1.7.1
redox_syscall-0.1.56
redox_users-0.3.4
regex-1.3.9
regex-syntax-0.6.18
remove_dir_all-0.5.3
resolv-conf-0.6.3
ring-0.16.15
rle-decode-fast-1.0.1
rocket_failure_errors-0.2.0
rstar-0.7.1
rust-argon2-0.7.0
rustc-demangle-0.1.16
rustc_version-0.2.3
rusticata-macros-2.1.0
rustls-0.16.0
rustyline-5.0.6
rustyline-6.2.0
ryu-1.0.5
safemem-0.3.3
same-file-1.0.6
scoped-tls-0.1.2
scoped_threadpool-0.1.9
scopeguard-1.1.0
sct-0.6.0
seccomp-sys-0.1.3
selectors-0.22.0
semver-0.9.0
semver-parser-0.7.0
separator-0.4.1
serde-1.0.114
serde_derive-1.0.114
serde_json-1.0.55
serde_urlencoded-0.6.1
servo_arc-0.1.1
sha-1-0.8.2
sha2-0.8.2
sha3-0.8.2
shellwords-1.0.0
siphasher-0.3.3
slab-0.4.2
sloppy-rfc4880-0.1.5
smallvec-0.6.13
smallvec-1.4.0
sn0int-0.19.1
sn0int-common-0.11.0
sn0int-std-0.19.0
socket2-0.3.12
sodiumoxide-0.2.5
spin-0.5.2
stable_deref_trait-1.1.1
static_assertions-1.1.0
string-0.2.1
string_cache-0.8.0
string_cache_codegen-0.5.1
strsim-0.8.0
structopt-0.3.15
structopt-derive-0.4.8
strum-0.18.0
strum_macros-0.18.0
subtle-1.0.0
syn-0.15.44
syn-1.0.33
syn-mid-0.5.0
synstructure-0.12.4
syscallz-0.14.0
take_mut-0.2.2
tar-0.4.29
tempfile-3.1.0
tendril-0.4.1
termcolor-1.1.0
textwrap-0.11.0
thin-slice-0.1.1
thread_local-1.0.1
threadpool-1.8.1
tiff-0.5.0
time-0.1.43
tinyvec-0.3.3
tokio-0.1.22
tokio-buf-0.1.1
tokio-codec-0.1.2
tokio-core-0.1.17
tokio-current-thread-0.1.7
tokio-executor-0.1.10
tokio-fs-0.1.7
tokio-io-0.1.13
tokio-reactor-0.1.12
tokio-rustls-0.10.3
tokio-sync-0.1.8
tokio-tcp-0.1.4
tokio-threadpool-0.1.18
tokio-timer-0.2.13
tokio-udp-0.1.6
tokio-uds-0.2.6
toml-0.5.6
trust-dns-0.17.0
trust-dns-proto-0.8.0
try-lock-0.2.2
tungstenite-0.10.1
typenum-1.12.0
uname-0.1.1
unicode-bidi-0.3.4
unicode-normalization-0.1.13
unicode-segmentation-1.6.0
unicode-width-0.1.7
unicode-xid-0.1.0
unicode-xid-0.2.0
untrusted-0.7.1
unveil-0.2.1
url-2.1.1
utf-8-0.7.5
utf8parse-0.1.1
utf8parse-0.2.0
vcpkg-0.2.10
vec_map-0.8.2
version_check-0.9.2
void-1.0.2
walkdir-2.3.1
want-0.2.0
wasi-0.9.0+wasi-snapshot-preview1
wasm-bindgen-0.2.63
wasm-bindgen-backend-0.2.63
wasm-bindgen-macro-0.2.63
wasm-bindgen-macro-support-0.2.63
wasm-bindgen-shared-0.2.63
web-sys-0.3.40
webpki-0.21.3
webpki-roots-0.17.0
webpki-roots-0.18.0
webpki-roots-0.19.0
widestring-0.4.2
winapi-0.2.8
winapi-0.3.8
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
winreg-0.6.2
ws2_32-sys-0.2.1
x509-parser-0.7.0
xattr-0.2.2
xml-rs-0.8.3
"

inherit bash-completion-r1 cargo fcaps

DESCRIPTION="Semi-automatic OSINT framework and package manager"
HOMEPAGE="https://github.com/kpcyrd/sn0int"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="doc"

RESTRICT="mirror"

BDEPEND="
	doc? ( dev-python/sphinx )
	virtual/pkgconfig"

RDEPEND="
	dev-db/sqlite:=
	dev-libs/libsodium:=
	sys-libs/libseccomp"

DEPEND="${RDEPEND}"

src_compile() {
	cargo_src_compile
	target/release/sn0int completions bash > "${T}"/sn0int.bash-completion || die
}

src_install() {
	cargo_src_install

	newbashcomp "${T}"/sn0int.bash-completion $PN

	if use doc; then
		emake docs
		dodoc -r docs/_build/html
	fi

	dodoc *.md Dockerfile contrib/docker/Dockerfile.alpine
}

pkg_postinst() {
	fcaps CAP_SYS_CHROOT /usr/bin/sn0int
}
