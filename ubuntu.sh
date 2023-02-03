#!/bin/bash
#
# A shell script for set-up ubuntu-based development environment.
#
#####################
# Pre-installations #
#####################
input_username() {
    printf "Type username you want to setup.\n"
    printf "If user not exists, this script will create a user.\n"
    sleep 0.5
    read -p "Username : " USERNAME

    if id ${USERNAME} &>/dev/null; then
        echo "${USERNAME} already exists. Skip creating user..."
    else
        read -p "Your name(Optional, leave blank if you want to) : " NAME
        sudo useradd -m ${USERNAME} -c ${NAME:=${USERNAME}} -s /bin/bash

        sudo passwd ${USERNAME}
        echo "Create user ${USERNAME}..."

        printf "\nAdd sudo permission to ${USERNAME}...\n"
        sudo usermod -aG sudo ${USERNAME}
    fi
    export HOME=/home/"${USERNAME}"
}
#####################
# Main(Entry point) #
#####################
# Entry point for this script.
main() {
    # Check script is running in root
    if [ "$EUID" -ne 0 ]; then
        echo "Please run as root"
        exit
    fi

    printf "Import variables...\n\n"
    . ./vars.sh

    printf "Import script files...\n\n"
    . ./setups.sh
    . ./installs.sh
    . ./misc.sh

    input_username

    # Load variables with prefix set_ / inst_
    local setups=($(typeset -F | sed -u "s|declare -f||g" | grep set_))
    local installs=($(typeset -F | sed -u "s|declare -f||g" | grep inst_))

    printf "Applying setups...\n\n"
    for setup in "${setups[@]}"; do
        local statement="$(echo "${setup}" | tr \'a-z\' \'A-Z\')"
        if [[ "$statement" -eq 1 ]]; then
            printf "Running %s...\n" "${setup}"
            ${setup}
        fi
    done

    printf "apt-get update after setup...\n"
    sudo apt-get update -qq >/dev/null

    printf "Installing devlopment environments...\n\n"
    for install in "${installs[@]}"; do
        local statement="$(echo "${install}" | tr \'a-z\' \'A-Z\')"
        if [[ "$statement" -eq 1 ]]; then
            printf "Running %s...\n" "${install}"
            ${install}
        fi
    done

    printf "\n\nInstallation completed!\n"

    echo "Fix permission..."
    sudo chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}
}

readonly LOGFILE="setup_script_result.log"

# Add prefix for logs
main 2> >(tee >(sed "s/^/[ERROR] $(date +'%Y.%m.%d %H:%M:%S') /" >>${LOGFILE})) \
1> >(tee >(sed "s/^/[LOG] $(date +'%Y.%m.%d %H:%M:%S') /" >>${LOGFILE}))

add_log_header

change_user_prompt
