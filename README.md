# dotfiles

My personal dotfiles!

## Getting Started on Ubuntu

### Prerequisites

Nothing is required but having your Unix distribution installed.
Tested on Ubuntu 18.04.

### Installation

After cloning this repository simply run the bootstrap script:

```bash
./bootstrap.sh
```
This will first install all the required package and then run DotManager with the default configuration file.

## Getting Started on Windows

### Prerequisites

You will need to run the following scripts on an Ubuntu command prompt after having installed is using WSL (Windows Subsystem for Linux).

### Installation

Similar to Ubuntu, after cloning this repository simply run the bootstrap script in the windows folder:

```bash
cd windows
./bootstrap.sh
```

# Usage

## Scripts

All scripts are located in **scripts** folder:
- **bootstrap.sh**: Installs all the usual packages and run default dotfile configuration.
- **install.sh**: Installs all the usual packages.
- **dotfiles.sh**: Run default dotfile configuration.

## DotManager

DotManager is a Python tool to deploy dotfiles based on JSON configuration file(s).  
To deploy the default dotfile configuration, you can run the tool with the following line:
```bash
python -m dot_manager dotmanager.json
```
You can also append your own configuration as it supports multiple configurations:
```bash
python -m dot_manager dotmanager.json myconfig.json
```

#### Configuration
Provided JSON is an object with the following members:
 - **root** (string/mandatory): path to root folder container all your dotfiles.
 - **sudo** (boolean/optional): indicates if the configuration requires administrator priviledges to be deployed. False by default.
 - **links** (object/optional): List of symlinks of this configuration.
 - **appends** (object/optional): List of appends of this configuration.
 - **runs** (object/optional): List of scripts to run for this configuration.

## Authors

* **Romain Ducout** - *Main author* - [rducout](https://github.com/rducout)

