#!/usr/bin/env python
"""
Main class of Dotmanager.
Takes as input a configuration script and apply the given configuration.
"""
import json
import os
import subprocess
from dot_manager.utils.utils import Utils
from dot_manager.appender import Appender
from dot_manager.linker import Linker

__author__ = "Romain Ducout"

APPEND_START_STR = '# Added by DotManager -- start\n'
APPEND_END_STR = '# Added by DotManager -- end\n'

class DotManager(object):
    """Applies a Dotfile configuration"""

    def __init__(self, config_file):
        config_path = config_file.name
        config_dir = os.path.dirname(config_path)

        self.config = json.load(config_file)
        self.config_root = os.path.abspath(os.path.join(config_dir, self.config["root"]))

        self.linker = Linker(self.config, self.config_root)
        self.appender = Appender(self.config, self.config_root)

    def apply_configuration(self):
        """Parse the configuration file and applies its content"""
        if self.config["sudo"]:
            if os.getuid() != 0:
                Utils.print_err("This configuration requires to run as sudo user!")
                return
        Utils.print_msg("1. Managing links")
        self.linker.apply_configuration()
        Utils.print_msg("2. Managing appends")
        self.appender.apply_configuration()
