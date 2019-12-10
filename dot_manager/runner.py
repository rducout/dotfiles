#!/usr/bin/env python
"""
Runner class of Dotmanager.
Run configuration scripts.
"""
import os
import subprocess

__author__ = "Romain Ducout"

class Runner(object):
    """Applies the runs of a configuration"""

    def __init__(self, config, config_root):
        self.config = config
        self.config_root = config_root

    def apply_configuration(self):
        """Parse the configuration file and applies its runs"""
        self.manage_runs()

    @staticmethod
    def manage_run(target_path, run_config):
        """Apply a single run configuration"""
        target_path = os.path.expanduser(target_path)
        if "description" in run_config:
            print(run_config["description"])
        subprocess.call([target_path])

    def manage_runs(self):
        """Apply all runs configurations of the configuration file"""
        if "runs" not in self.config:
            return

        config_runs = self.config["runs"]
        for link_path in config_runs:
            run_config = config_runs[link_path]
            Runner.manage_run(
                os.path.join(self.config_root, link_path),
                run_config
            )
