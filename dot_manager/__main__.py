#!/usr/bin/env python
"""
Entry point of DotManager
"""

import argparse
from dot_manager.utils.utils import Utils
from dot_manager.dotmanager import DotManager

__author__ = "Romain Ducout"

def parse_arguments():
    """Parse the arguments"""
    parser = argparse.ArgumentParser()
    parser.add_argument('file', type=argparse.FileType('r'), help='JSON configuration file')
    return parser.parse_args()

def main():
    """Main method - parse arguments and process configuration file"""
    Utils.print_block("Starting DotManager")

    args = parse_arguments()
    dotmanager = DotManager(args.file)
    dotmanager.apply_configuration()

    Utils.print_block("Ending DotManager")

if __name__ == '__main__':
    main()
