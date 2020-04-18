#!/usr/bin/env python

import sys

try:
    configuration_name = sys.argv[1]
    config_file_name = ".config/gcloud/configurations/config_{}".format(configuration_name)
except IndexError:
    # current-context is not set
    sys.exit(1)

try:
    from configparser import ConfigParser
except ImportError:
    from ConfigParser import RawConfigParser as ConfigParser

try:
    from pathlib import Path
    config_file = Path.home() / config_file_name
except ImportError:
    import os
    config_file = os.path.join(os.path.expanduser("~"), config_file_name)

config = ConfigParser()
project_name = "?"

try:
    config.read(config_file)
    if config.has_section("core") and config.has_section("core", "project"):
        project_name = config.get("core", "project") + "??"
except:
    project_name = configuration_name

print(project_name)
sys.exit(0)
