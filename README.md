# dotfiles

My personal dotfiles!
This helps me in my various projects un Unix.

## Getting Started

After cloning this repository simply run the bootstrap script:

```
./bootstrap.sh
```
This will first install all the required package and then run DotManager with the default configuration file.

## Prerequisites

Nothing is required but having your Unix distribution installed.
Tested on Ubuntu 18.04.

# Usage

## Scripts

All scripts are located in **scripts**folder:
- **bootstrap.sh**: Installs all the usual packages and run default dotfile configuration.
- **install.sh**: Installs all the usual packages.
- **dotfiles.sh**: Run default dotfile configuration.

## DotManager

DotManager is a Python tool to deploy dotfiles based on JSON configuration file(s).  
To deploy the default dotfile configuration, you can run the tool with the following line:
```
python -m dot_manager dotmanager.json
```
You can also append your own configuration as it supports multiple configurations:
```
python -m dot_manager dotmanager.json myconfig.json
```

#### Configuration
Provided JSON is an object with the following members:
 - **root** (string/mandatory): path to root folder container all your dotfiles.
 - **sudo** (boolean/optional): indicates if the configuration requires administrator priviledges to be deployed. False by default.
 - **links** (object/optional): List of symlinks of this configuration.
 - **appends** (object/optional): List of appends of this configuration.
 - **runs** (object/optional): List of scripts to run for this configuration.

## TODOS

- Backup system
- DotManager documentation

## Authors

* **Romain Ducout** - *Main author* - [rducout](https://github.com/rducout)

