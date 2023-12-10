#!/usr/bin/env python3

"""Utility to generate DEPEND data for ebuilds
"""

import distutils.core
import sys
import re

import os
import tomli

__author__ = "Anton Bolshakov"
__license__ = "GPL-3"
__email__ = "blshkv@pentoo.ch"

#FIXME: missing deps if platform_system is specified, see:
#dev-python/libsast
#requires: dev-python/tomli

def portage_mapping(replace_string):
    result = replace_string
    mapping =  {
        "dev-python/androguard": "dev-util/androguard",
        "dev-python/async_timeout": "dev-python/async-timeout",
        "dev-python/Brotli": "app-arch/brotli[python]",
        "dev-python/browser_cookie3": "dev-python/browser-cookie3",
        "dev-python/bs4": "dev-python/beautifulsoup4",
        "dev-python/cached_property": "dev-python/cached-property",
        "dev-python/capstone": "dev-libs/capstone[python]",
        "dev-python/cli_helpers": "dev-python/cli-helpers",
        "dev-python/colored_traceback": "dev-python/colored-traceback",
        "dev-python/deep_translator": "dev-python/deep-translator",
        "dev-python/Django": "dev-python/django",
        "dev-python/geographiclib": "sci-geosciences/GeographicLib[python]",
        "dev-python/editorconfig": "dev-python/editorconfig-core-py",
        "dev-python/flask-BabelEx": "dev-python/flask-babelex",
        "dev-python/flask_caching": "dev-python/flask-caching",
        "dev-python/Flask": "dev-python/flask",
        "dev-python/flask-Login": "dev-python/flask-login",
        "dev-python/flask-Mail": "dev-python/flask-mail",
        "dev-python/flask-Principal": "dev-python/flask-principal",
        "dev-python/flask-SocketIO": "dev-python/flask-socketio",
        "dev-python/flask-WTF": "dev-python/flask-wtf",
        "dev-python/frida": "dev-python/frida-python",
        "dev-python/importlib-metadata": "dev-python/importlib-metadata",
        "dev-python/iptools": "dev-python/python-iptools",
        "dev-python/ipsw_parser": "dev-python/ipsw-parser",
        "dev-python/IPy": "dev-python/ipy",
        "dev-python/IPython": "dev-python/ipython",
        "dev-python/jinja2": "dev-python/jinja",
        "dev-python/lief": "dev-util/lief",
        "dev-python/magic_filter": "dev-python/magic-filter",
        "dev-python/Markdown": "dev-python/markdown",
        "dev-python/nest_asyncio": "dev-python/nest-asyncio",
        "dev-python/openstep-parser": "dev-python/openstep_parser",
        "dev-python/parameter_decorators": "dev-python/parameter-decorators",
        "dev-python/Pillow": "dev-python/pillow",
        "dev-python/protobuf": "dev-python/protobuf-python",
        "dev-python/pjsip": "net-libs/pjproject",
        "dev-python/prompt_toolkit": "dev-python/prompt-toolkit",
        "dev-python/protego": "dev-python/Protego",
        "dev-python/psycopg2-binary": "dev-python/psycopg",
        "dev-python/psycopg2": "dev-python/psycopg",
        "dev-python/pycrypto": "dev-python/pycryptodome",
        "dev-python/pycryptodomedomex": "dev-python/pycryptodome",
        "dev-python/Pygments": "dev-python/pygments",
        "dev-python/PyGObject": "dev-python/pygobject",
        "dev-python/PyJWT": "dev-python/pyjwt",
        "dev-python/PyMySQL": "dev-python/pymysql",
        "dev-python/pyOpenSSL": "dev-python/pyopenssl",
        "dev-python/pypykatz": "app-exploits/pypykatz",
        "dev-python/pysocks": "dev-python/PySocks",
        "dev-python/pyVNC": "dev-python/pyvnc",
        "dev-python/PyYAML": "dev-python/pyyaml",
        "dev-python/redis": "dev-python/redis-py",
        "dev-python/ropgadget": "app-exploits/ropgadget",
        "dev-python/ruamel.yaml": "dev-python/ruamel-yaml",
        "dev-python/scapy": "net-analyzer/scapy",
        "dev-python/SQLAlchemy": "dev-python/sqlalchemy",
        "dev-python/sqlalchemy-Utc": "dev-python/sqlalchemy_utc",
        "dev-python/tls-parser": "dev-python/tls_parser",
        "dev-python/tornado": "www-servers/tornado",
        "dev-python/typing_extensions": "dev-python/typing-extensions",
        "dev-python/Twisted": "dev-python/twisted",
        "dev-python/unicorn": "dev-util/unicorn[python]",
        "dev-python/wordcloud": "media-gfx/word_cloud",
        "dev-python/zope.interface": "dev-python/zope-interface"
    }

    for key in mapping:
        if replace_string == key:
          result = replace_string.replace(key, mapping[key])
          break

    return result

def pyproject_toml():
    try:
        with open('./pyproject.toml', 'rb') as f:
            try:
                print("pyproject.toml found")
                dependencies = tomli.load(f)['tool']['poetry']['dependencies']
            except:
                try:
                    # FIXME: add support pyproject dependencies = [], see fastapi as an example
                    # Dependency specification in pyproject.toml
                    # https://peps.python.org/pep-0631/

                    # https://stackoverflow.com/questions/49689880/proper-way-to-parse-requirements-file-after-pip-upgrade-to-pip-10-x-x
                    # FIXME: use https://pypi.org/project/requirements-parser
                    # or pkg_resources.parse_requirements(value)
                    # or importlib_metadata (may be the best option)
                    # or pyproject-metadata
                    from pip._internal.network.session import PipSession
                    from pip._internal.req import parse_requirements
                    requirements = parse_requirements('requirements.txt', PipSession())

                    dependencies_list=[requirement.requirement for requirement in requirements]
                    #convert to plain dict
                    i = iter(dependencies_list)
                    #FIXME: this produces "[package-version, *]", change to [package, version]
                    #Hit: use requirements-parser
                    dependencies=dict.fromkeys(i, "*")

                except:
                    # FIXME:
                    # build-backend = "setuptools.build_meta"
                    print("Unable to find 'poetry' dependencies, trying setuptools instead")
                    return 1
    except FileNotFoundError:
        return 1
    #Debug
    #print(dependencies )  # List of static requirements
    for key, value in dependencies.items():
        if key == "python":
            continue
        #if value is {'git': 'https://github.com/BC-SECURITY/pyVNC.git'}
        if type(value) is dict:
            value="9999"
            continue
        if value == "*":
            print("\t"+portage_mapping("dev-python/" +key) +"[${PYTHON_USEDEP}]")
        else:
            print("\t>="+portage_mapping("dev-python/" + key) + '-' + value.replace('^','') + "[${PYTHON_USEDEP}]")

def distutils_setup():
    try:
        setup = distutils.core.run_setup("./setup.py")
    except FileNotFoundError:
        print("setup.py not found")
        return 1

    if not hasattr(setup, 'install_requires') or len(setup.install_requires)==0:
        print("RDEPEND=\"\"")
        sys.exit(1)
    #Debug:
    #print(setup.install_requires)

    print("RDEPEND=\"")

    for i in setup.install_requires:
        #match: my-na.me<5.0.0,>=4.0.0
        #and match: my-na.me
        #print("setup requjires: ", i)
        pattern = '([-.\w]+)(>=|>|==|=<|<)?([\d.]+)?(,)?(>=|>|==|=<|<)?([\d.]+)?'
        match = re.search(pattern, i)
#        if match:
#          print("Match:", match.group(1), match.group(2), match.group(3), match.group(4), match.group(5), match.group(6))
#          print("Match0:", match.group(0) )
#        else:
#          print("pattern not found")
        if match.group(2) == ">=" or match.group(2) == "==":
          print("\t>="+portage_mapping("dev-python/"+match.group(1))+"-"+ match.group(3)+"[${PYTHON_USEDEP}]")
        elif match.group(5) == ">=" or match.group(5) == "==":
          print("\t>="+portage_mapping("dev-python/"+match.group(1))+"-"+ match.group(6)+"[${PYTHON_USEDEP}]")
        elif match.group(1):
          print("\t"+portage_mapping("dev-python/"+match.group(1))+"[${PYTHON_USEDEP}]")
        else:
          print("Error: fail to detect dependency name")
          sys.exit(1)

    print("\"")

def main():
    if pyproject_toml():
        distutils_setup()

if __name__ == '__main__':
    main()
