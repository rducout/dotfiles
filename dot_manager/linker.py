#!/usr/bin/env python
"""
Linker class of Dotmanager.
Appends configuration files to already existing files.
"""
import os
from six import string_types
from dot_manager.utils.utils import Utils

__author__ = "Romain Ducout"

class Linker():
    """Applies the links of a configuration"""

    def __init__(self, config, config_root):
        self.config = config
        self.config_root = config_root

    def apply_configuration(self):
        """Parse the configuration file and applies its links"""
        self.manage_links()

    @staticmethod
    def manage_link(link_path, target_path, create_dir=True):
        if not os.path.exists(link_path):
            Utils.print_err("No file to link at path: {path}".format(path=link_path))
            return

        print("Linking {link_path} --> {target_path} :".format(
            link_path=link_path,
            target_path=target_path
        ))

        for path, dirs, files in os.walk(link_path):
            for name in files:
                file_link_path = os.path.join(path, name)
                file_rel_path = os.path.relpath(file_link_path, link_path)
                file_target_path = os.path.join(target_path, file_rel_path)
                file_target_path = os.path.expanduser(file_target_path)

                if not os.path.exists(os.path.dirname(file_target_path)) and create_dir:
                    os.makedirs(os.path.dirname(file_target_path))

                print("\t{file_rel_path}".format(file_rel_path=file_rel_path))

                os.system("ln -sf \"{file_link_path}\" \"{file_target_path}\" 2> /dev/null".format(
                    file_link_path=file_link_path,
                    file_target_path=file_target_path
                ))

    def manage_links(self):
        """Apply all link configurations of the configuration file"""
        if "links" not in self.config:
            return

        config_links = self.config["links"]
        for link_path in config_links:
            link_config = config_links[link_path]
            if isinstance(link_config, string_types):
                link_path = os.path.join(self.config_root, link_path)
                target_path = link_config
                Linker.manage_link(link_path, target_path)
