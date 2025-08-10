#!/usr/bin/env python3

import yaml
import sys

if len(sys.argv) < 2:
    print("Correct usage: yaml_parse.py <files.yaml>")
    sys.exit(1)

yaml_file = sys.argv[1]

# Load YAML file
with open(yaml_file, "r") as f:
    config = yaml.safe_load(f)

if (sys.argv[2] == "rtl"):
    for rtl_file in config['files']['rtl']:
        print(rtl_file)
elif (sys.argv[2] == "tb"):
        for files in config['files']['rtl']:
            print(files)
        for files in config['files']['tb']:
            print(files)
elif (sys.argv[2] == "uvm_src_path"):
        print (config['include_dirs']['uvm'])

        
