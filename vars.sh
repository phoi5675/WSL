#!/bin/bash
#
# Constants to customize installation and set-ups.
#
#######################################################
#                                                     #
# EDIT CONSTANTS TO CUSTOMIZE DEVLOPMENT ENVIRONMENT! #
#                                                     #
#######################################################

# Constants
#
# Shell
readonly ZSH='zsh'
readonly BASH='bash'
readonly SHELL=${ZSH}

# Default environments
PATH=$(echo $PATH) # Default ${PATH} in ubuntu(debian)

# Set-ups
readonly SET_TIMEZONE=1                       # Set timezone specified by ${TIMEZONE}
readonly SET_MIRROR_TO_KAKAO=1                # Set apt server to kakao, which is faster than default korea mirror server
readonly SET_SHELL_PROMPT=1                   # Set shell prompt. See ~/config/.bash_config or .zsh_config
readonly SET_VIM=1                            # Set syntax and hightlight setting. See ~/config/.vimrc
readonly SET_GITCONFIG=1                      # Set git config and git message. See ~/config/gitconfigs/.gitconfig and .gitmessage
readonly SET_ZSH=1                            # Install and set oh-my-zsh and use custom theme
readonly SET_CREATED_USER_TO_DEFAULT=0        # Set a created user while this script running as a default user when WSL starts. Applies to WSL only
readonly SET_OPEN_SESSION_CONNECTED_VIA_SSH=0 # Open a screen session when connecting server via ssh

# ISNT_* : Install * (0 -> 1 to install package)
readonly INST_BUILD_ESSENTIALS=1 # Install build-essentials package in ubuntu
readonly INST_SSH_SERVER=1       # Install and activate openssh-server
readonly INST_PYTHON2=1          # Install python2
readonly INST_PYTHON3=1          # Install python3 - set ${VER_PY3} manually if you want to install other version of python3.
readonly INST_GIT=1              # Install git
readonly INST_JAVA=1             # Install openjdk
readonly INST_NODEJS=1           # Install node using nvm
readonly INST_KOR_FONT=1         # Install fonts-nanum to support korean
readonly INST_POWERLINE_FONT=1   # Install powerline fonts for oh-my-zsh in desktop environment
readonly INST_DOCKER_CLI=0       # Install docker-cli
readonly INST_XRDP=0             # Install xrdp(remote desktop server for ubuntu)

# Versions
readonly VER_OPEN_JDK=11
readonly VER_NODEJS=16
readonly VER_PY3=3.9

# Folders
readonly CONFIG="$(pwd)/config"

# Miscs
readonly LOG_LVL="-q"
readonly TIMEZONE="Etc/UTC" # Alternative : "Asia/Seoul". See /usr/share/zoneinfo
