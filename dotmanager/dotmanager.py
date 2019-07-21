import json
import argparse
import os

class PRINT_COLORS:
    GREEN = '\033[92m'
    RED = '\033[91m'
    NONE = '\033[0m'

def print_msg(msg):
    print PRINT_COLORS.GREEN + msg + PRINT_COLORS.NONE
def print_err(msg):
    print PRINT_COLORS.RED + msg + PRINT_COLORS.NONE

def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('file', type=argparse.FileType('r'), help='JSON configuration file')
    return parser.parse_args()

def manage_link(link_path, target_path, force=False, create_dir=False):
    target_path = os.path.expanduser(target_path)

    if not os.path.exists(link_path):
        print_err("No target at path: {path}".format(path=link_path))
        return
    
    if create_dir:
        os.makedirs(os.path.dirname(target_path), exist_ok=True)
    
    if os.path.exists(target_path):
        if force:
            os.remove(target_path)
        else:
            print_err("Target path already exists: {path}".format(path=target_path))
            return
            
    os.system("ln -s {link_path} {target_path} 2> /dev/null".format(
        link_path=link_path,
        target_path=target_path
    ))

def manage_links(config_file):
    config_path = config_file.name
    config_dir = os.path.dirname(config_path)
    config = json.load(config_file)
    
    config_root = os.path.abspath(os.path.join(config_dir, config["root"]))
    config_links = config["links"]
    for target_path, link_config in config_links.iteritems():
        if isinstance(link_config, basestring):
            link_path = os.path.join(config_root, link_config)
            manage_link(link_path, target_path)
        else:
            link_path = os.path.join(config_root, link_config["path"])
            create_dir = link_config["create_dir"] if "create_dir" in link_config else False
            force = link_config["force"] if "force" in link_config else False
            manage_link(
                link_path,
                target_path,
                link_config["force"],
                create_dir
            )

def manage_append(src_path, target_path):
    f = open(target_path)
    """
    for line in f:
        if line.contains('Added by '):
            newline = line.replace('foo', 'bar')
    """

def manage_appends(config_file):
    config_path = config_file.name
    config_dir = os.path.dirname(config_path)
    config = json.load(config_file)
    
    config_root = os.path.abspath(os.path.join(config_dir, config["root"]))
    config_appends = config["append"]
    for target_path, append in config_appends.iteritems():
        src_path = os.path.join(config_root, append)
        manage_link(src_path, target_path)

def manage_dotfiles(config_file):
    manage_links(config_file)
    manage_appends(config_file)

def main():
    args = parse_arguments()
    print_msg("Running DotManager")
    manage_dotfiles(args.file)
    print_msg("Leaving DotManager")
  
if __name__== "__main__":
    main()
