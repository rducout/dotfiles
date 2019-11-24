#!/usr/bin/env python
"""
Utilitary methods.
"""

__author__ = "Romain Ducout"

class PrintColors(object):
    """Characters to change console color"""
    GREEN = '\033[92m'
    RED = '\033[91m'
    NONE = '\033[0m'

class Utils(object):
    """Utilities methods"""

    @staticmethod
    def print_msg(msg):
        """Print a simple message"""
        print PrintColors.GREEN + msg + PrintColors.NONE

    @staticmethod
    def print_err(msg):
        """Print an error"""
        print PrintColors.RED + msg + PrintColors.NONE

    @staticmethod
    def print_separator():
        """Print a separator"""
        Utils.print_msg('############################################################')

    @staticmethod
    def print_block(msg):
        """Print a message surrounded by separators"""
        Utils.print_separator()
        Utils.print_msg(msg)
        Utils.print_separator()
