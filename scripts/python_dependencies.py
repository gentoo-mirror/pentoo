#!/usr/bin/env python3

"""Utility to generate DEPEND data for ebuilds
"""

import distutils.core
import sys
import re

__author__ = "Anton Bolshakov"
__license__ = "GPL-3"
__email__ = "blshkv@pentoo.ch"

def portage_mapping(search):
    mapping =  {
        "dev-python/prompt-toolkit": "dev-python/prompt_toolkit",
        "dev-python/bs4": "dev-python/beautifulsoup:4",
        "dev-python/ruamel.yaml": "dev-python/ruamel-yaml",
        "dev-python/pycrypto": "dev-python/pycryptodome",
        "dev-python/Django": "dev-python/django",
        "dev-python/frida": "dev-python/frida-python",
        "dev-python/lief": "dev-util/lief",
        "dev-python/androguard": "dev-util/androguard",
        "dev-python/tls-parser": "dev-python/tls_parser",
        "dev-python/pyOpenSSL": "dev-python/pyopenssl",
    }

    for key in mapping:
        search = search.replace(key, mapping[key])
    return search

def main():
    setup = distutils.core.run_setup("./setup.py")
#    print(setup.install_requires)

    print("RDEPEND=\"")
    for i in setup.install_requires:

        #match: my-na.me<5.0.0,>=4.0.0
        #and match: my-na.me
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
          print("\t"+portage_mapping("dev-python/"+match.group(1)))
        else:
          print("Error: fail to detect dependency name")
          sys.exit(1)

    print("\"")

if __name__ == '__main__':
    main()
