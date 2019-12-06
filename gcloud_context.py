#!/usr/bin/env python

import sys

from pathlib import Path
from configparser import ConfigParser

config = ConfigParser()
config.read(Path.home() / ".config/gcloud/configurations/config_{}".format(sys.argv[1]))
print(config.get("core", "project"))
