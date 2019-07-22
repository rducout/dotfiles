#!/usr/bin/env python
"""
Main class of Dotmanager.
Takes as input a configuration script and apply the given configuration.
"""
import json
import io
import os
from os.path import expanduser
from dot_manager.utils.utils import Utils

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

    def apply_configuration(self):
        """Parse the configuration file and applies its content"""
        Utils.print_msg("1. Managing links")
        self.manage_links()
        Utils.print_msg("2. Managing appends")
        self.manage_appends()

    @staticmethod
    def manage_link(link_path, target_path, force=False, create_dir=False):
        """Apply a single link configuration"""
        target_path = os.path.expanduser(target_path)

        if not os.path.exists(link_path):
            Utils.print_err("No target at path: {path}".format(path=link_path))
            return

        if create_dir:
            os.makedirs(os.path.dirname(target_path), True)

        if os.path.exists(target_path):
            if force:
                os.remove(target_path)
            else:
                Utils.print_err("Target path already exists: {path}".format(path=target_path))
                return

        os.system("ln -s {link_path} {target_path} 2> /dev/null".format(
            link_path=link_path,
            target_path=target_path
        ))

    def manage_links(self):
        """Apply all link configurations of the configuration file"""
        config_links = self.config["links"]
        for target_path, link_config in config_links.iteritems():
            if isinstance(link_config, basestring):
                link_path = os.path.join(self.config_root, link_config)
                DotManager.manage_link(link_path, target_path)
            else:
                link_path = os.path.join(self.config_root, link_config["path"])
                create_dir = link_config["create_dir"] if "create_dir" in link_config else False
                force = link_config["force"] if "force" in link_config else False
                DotManager.manage_link(
                    link_path,
                    target_path,
                    force,
                    create_dir
                )

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
                    dst_buffer.write(line)
                if line.startswith(end_str):
                    is_in_append = False

        with open(expanduser(path), "w") as write_file:
            write_file.write(dst_buffer.getvalue())

    @staticmethod
    def manage_append(src_path, target_path, start_str=APPEND_START_STR, end_str=APPEND_END_STR):
        """Apply a single append configuration"""
        DotManager.extract_append(target_path, start_str, end_str)

        with open(expanduser(src_path), "r") as src_file:
            src_data = src_file.read()
            with open(expanduser(target_path), "a") as target_file:
                target_file.write(start_str)
                target_file.write(src_data)
                target_file.write(end_str)

    def manage_appends(self):
        """Apply all append configurations of the configuration file"""
        config_appends = self.config["append"]
        for target_path, append in config_appends.iteritems():
            src_path = os.path.join(self.config_root, append)
            DotManager.manage_append(src_path, target_path)
