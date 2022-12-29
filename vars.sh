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
PATH=$(cat /etc/environment) # Default ${PATH} in ubuntu(debian)

# Set-ups
readonly SET_MIRROR_TO_KAKAO=1
readonly SET_SHELL_PROMPT=1
readonly SET_VIM=1
readonly SET_GITCONFIG=1
readonly SET_ZSH=1
readonly SET_CREATED_USER_TO_DEFAULT=1

# ISNT_* : Install * (0 -> 1 to install package)
readonly INST_BUILD_ESSENTIALS=1
readonly INST_PYTHON2=1
readonly INST_PYTHON3=1
readonly INST_GIT=1
readonly INST_JAVA=1
readonly INST_NODEJS=1
readonly INST_KOR_FONT=1

# Versions
readonly VER_OPEN_JDK=11
readonly VER_NODEJS=lts
readonly VER_PY3=3.9

# Folders
readonly CONFIG="$(pwd)/config"

# Miscs
readonly LOG_LVL="-q"
