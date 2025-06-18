# Dotfiles

![License](https://img.shields.io/badge/license-MIT-blue.svg)

A portable and reproducible configuration setup by Yifattih for Unix-like systems.
These dotfiles make setting up a new system consistent, efficient, and tailored to my personal workflow and preferences.

## Contents

* `.bashrc` – Bash configuration (functions, environment variables)
* `.bash_aliases` –  Aliases
* `.gitconfig` – Git global configuration
* `.gitmessage` – Git info message for commits
* `.config/` – App-specific configurations (e.g., `warp-terminal/`, etc.)

## Features

* Minimal and portable
* Reproducible system setup across machines
* Designed for Ubuntu and Debian-based distros
* Easy integration with an **unattended Ubuntu installation** (see [ubuntu-unattended-autoinstall-template](https://github.com/yifattih/ubuntu-unattended-autoinstall-template))

## Requirements

* `bash`
* `git`
* `stow` (for symlink management)
* `curl`
* `wget`

## Installation

1. Clone this repository:

```bash
git clone https://github.com/yifattih/dotfiles ~/dotfiles
cd ~/dotfiles
```

2. Generate symlink farm:

```bash
stow .
```

This will:

* Download the dotfiles repository and place it into yout `$HOME` directory
* Symlink the dotfiles into your `$HOME` directory

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

## Related Repositories

* [ubuntu-unattended-autoinstall-template](https://github.com/yifattih/ubuntu-unattended-autoinstall-template) – Automated Ubuntu installation setup.

## License

[MIT](LICENSE)
