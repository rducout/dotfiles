#!/usr/bin/env python
"""
Appender class of Dotmanager.
Appends configuration files to already existing files.
"""
import io
import os
from os.path import expanduser

__author__ = "Romain Ducout"

APPEND_START_STR = '# Added by DotManager -- start\n'
APPEND_END_STR = '# Added by DotManager -- end\n'

class Appender(object):
    """Applies the appends of a configuration"""

    def __init__(self, config, config_root):
        self.config = config
        self.config_root = config_root

    def apply_configuration(self):
        """Parse the configuration file and applies the appends"""
        self.manage_appends()

    @staticmethod
    def extract_append(path, start_str, end_str):
        """Removes all lines in given file between start_str and end_str included"""
        is_in_append = False
        dst_buffer = io.BytesIO()
        with open(expanduser(path), "r") as read_file:
            lines = read_file.readlines()
            for line in lines:
                if line.startswith(start_str):
                    is_in_append = True
                if not is_in_append:
                    dst_buffer.write(str.encode(line))
                if line.startswith(end_str):
                    is_in_append = False

        with open(expanduser(path), "w") as write_file:
            write_file.write(dst_buffer.getvalue().decode())

    @staticmethod
    def manage_append(src_path, target_path, start_str=APPEND_START_STR, end_str=APPEND_END_STR):
        """Apply a single append configuration"""
        Appender.extract_append(target_path, start_str, end_str)

        with open(expanduser(src_path), "r") as src_file:
            src_data = src_file.read()
            with open(expanduser(target_path), "a") as target_file:
                target_file.write(start_str)
                target_file.write(src_data)
                target_file.write(end_str)

    def manage_appends(self):
        """Apply all append configurations of the configuration file"""
        if "appends" not in self.config:
            return

        config_appends = self.config["appends"]
        for target_path in config_appends:
            append = config_appends[target_path]
            src_path = os.path.join(self.config_root, append)
            Appender.manage_append(src_path, target_path)
