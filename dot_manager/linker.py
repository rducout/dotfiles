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
    def manage_link(link_path, target_path, force=True, create_dir=False):
        """Apply a single link configuration"""
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

        print("Linking {link_path} --> {target_path}".format(
            link_path=link_path,
            target_path=target_path
        ))
        os.system("ln -s \"{link_path}\" \"{target_path}\" 2> /dev/null".format(
            link_path=link_path,
            target_path=target_path
        ))

    def manage_links(self):
        """Apply all link configurations of the configuration file"""
        if "links" not in self.config:
            return

        config_links = self.config["links"]
        for target_path in config_links:
            link_config = config_links[target_path]
            try:
                target_path = target_path.format(user_root=self.config["user_root"])
            except:
                pass
            if isinstance(link_config, string_types):
                link_path = os.path.join(self.config_root, link_config)
                Linker.manage_link(link_path, target_path)
            else:
                link_path = os.path.join(self.config_root, link_config["path"])
                create_dir = link_config["create_dir"] if "create_dir" in link_config else False
                force = link_config["force"] if "force" in link_config else True
                Linker.manage_link(
                    link_path,
                    target_path,
                    force,
                    create_dir
                )
