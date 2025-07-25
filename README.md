# My Dotfiles for Ubuntu: Automated Host and DevContainer Setup
## TL;DR
These dotfiles provision environments tailored to my personal workflow and preferences across different machines, including my personal host system and containerized DevContainers. It automates package installation, shell configuration, and tooling setup.

## About This Repository
This setup reflects my approach to building reproducible and efficient development environments. It automates system provisioning using tools like GNU Stow and shell scripting, and it supports both local and container-based environments using tools like DevPod. The goal is to minimize manual setup and maximize consistency across machines.

I maintain it as part of my daily work and learning in DevOps and software development.

## What this Repository is Not
This is my personal configuration. It is not a general-purpose system setup tool or framework.

## Prerequisite
- Ubuntu 24.04
- Git

## Getting Started
The installer runs automatically when provisioning a Devcontainer with DevPod and the repository is provided:
```bash
devpod up . --dotfiles https://github.com/yifattih/dotfiles
# install.sh runs automatically during the build
```

For host installation, a flag must be passed for full installation:
```bash
git clone https://github.com/yifattih/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh --host
```

## Motivation and Description
System configuration files (dotfiles), allow users to customize the system and tailor it to their needs—from desktop appearance to specific tooling behavior. With dotfiles those changes persist: the user doesn't need to tweak the settings every time they log in, launch software, or runs previously configured tool. Therefore, it is very convenient to keep the system configuration files stored because whenever I copy them to a system with a fresh OS installation, software, or tool, I can carry my preferences. For instance, I have custom settings for my editor (Neovim). Without configuration files I would have to remember and reapply each setting manually.

This dotfiles setup serves as a tool to make my system and tooling configuration reproducible. Therefore, it not only stores configuration files, but also performs other tasks like package installation and symlink management. The main goals with my dotfiles tool are:

* Designed for Ubuntu 24.04 base installations
* Installs packages and configures tools based on environment 
    - Host
    - DevContainers created with DevPod
* Automated environment bootstrapping
* Stored in the cloud

By placing the dotfiles under version control I gain access to historical changes. With GitHub I gain automated backup in the cloud, and sharing and collaboration support. Therefore, with the dotfiles under Git/GitHub, I can consistently replicate my environment when needed. For instance, I usually provision DevContainers that resemble functionalities of my host machine, like Neovim configuration. With this setup I can easily configure a development environment by simply cloning my dotfiles repository and running the installer.

## Structure and Organization
System configuration is applied to the environment by creating symlinks using GNU Stow, which ensures that files are linked correctly into the user's home directory. Configuration files are organized by modules, or directories, for each tool. Each module follows the structure of the actual environment. 

## Components
`git/`: Git configuration files and templates
`nvim/`: Neovim setup and plugin manager
`shell/`: bash shell configuration files 
`tmux/`: Tmux setup and plugin manager
`bin/`: Installer helper scripts
`apt-packages.txt`: List of packages to be installed with the APT package manager
`snap-packages.txt`: List of packages to install with Snap
`install.sh`: Entry point script for bootstrapping the environment

## Directory Structure
```bash
.
├── git 
├── nvim 
├── shell
├── tmux
├── bin
├── apt-packages.txt
├── snap-packages.txt
├── install.sh
├── LICENSE
└── README.md
```

## Features Managed per Environment
### Host Environment
- Package installation via APT and Snap
- Neovim plugin installation and configuration
- Starship prompt installation and Bash shell configuration 
- Git configuration
- Tmux Plugin Manager installation and configuration
- DevPod installation and command completion setup
- GitHub CLI installation
- Fonts download and setup
- System keymap configuration
- Docker Engine installation and command completion setup
- Zettelkasten system installation and setup

### Containerized Development Environment (devcontainer)
- Package installation via APT
- Neovim plugin installation and configuration
- Starship prompt installation and Bash shell configuration 
- Git configuration
- Tmux Plugin Manager installation and configuration
- Docker Engine installation + command completion set up
- Zettelkasten system installation and setup

## License and Contribution
Feel free to fork or adapt. Licensed under the [MIT License](./LICENSE).
