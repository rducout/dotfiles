#!/usr/bin/env python
"""
Linker class of Dotmanager.
Appends configuration files to already existing files.
"""
import os
from dot_manager.utils.utils import Utils

__author__ = "Romain Ducout"

class Linker(object):
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

        os.system("ln -s \"{link_path}\" \"{target_path}\" 2> /dev/null".format(
            link_path=link_path,
            target_path=target_path
        ))

    def manage_links(self):
        """Apply all link configurations of the configuration file"""
        config_links = self.config["links"]
        for target_path, link_config in config_links.iteritems():
            if isinstance(link_config, basestring):
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
