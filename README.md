# Dotfiles

![License](https://img.shields.io/badge/license-MIT-blue.svg)

My personal portable and reproducible configuration setup for debian systems.
These dotfiles make setting up a new system consistent, efficient, and tailored to my personal workflow and preferences.

## Contents

* `.bash_aliases` –  Aliases
* `.bashrc` – Bash configuration (functions, environment variables)
* `.config/` – App-specific configurations (e.g., `warp-terminal/`, etc.)
* `.gitconfig` – Git global configuration
* `.gitmessage` – Git info message for commits
* `.stow-local-ignore` - Stow ignore file list
* `.vimrc` - Vim configuration
* `install.sh` - Packages and dotfiles installer
* `packages/apt_pkgs.txt` - List of packages to install using the Advanced Package Tool (APT) formatted as `<installation name>:<binary name>`
* `packages/other_pkgs.sh` - Script to install packages outside package manager tool
* `packages/snap_pkgs.txt` - List of packages to install using snap package manager

## Features

* Minimal and portable
* Reproducible system setup across machines
* Designed for Ubuntu and Debian-based distros

## Requirements

* `bash`
* `git`

## Installation

1. Clone this repository to `${HOME}`:

```bash
git clone https://github.com/yifattih/dotfiles ~/dotfiles
cd ~/dotfiles
```

2. Run the installer:

```bash
,/install.sh -p -s -f
```
Note: run `./install.sh --help` for more information about the flags

This will:
* Download the packages listed and create the symlinks of the dotfiles into your `$HOME` directory

## Structure

```
dotfiles/
├── .bash_aliases
├── .bashrc
├── .config
│   └── warp-terminal
│       └── user_preferences.json
├── .gitconfig
└── .gitmessage
```

## Backup & Restore

To manually backup:

```bash
cp ~/.bashrc ~/dotfiles_backup/.bashrc
```

To restore:

```bash
cp ~/dotfiles_backup/.bashrc ~/
```

## License

[MIT](LICENSE)
