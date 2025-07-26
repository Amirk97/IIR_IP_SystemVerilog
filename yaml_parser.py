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

for rtl_file in config['files']['rtl']:
    print(rtl_file)
