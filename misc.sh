#!/bin/bash

add_log_header() {
    # Add header to log file
    HEADER="===============================================\\
|              Installation log               |\\
===============================================\\
\\
Installation date : $(date +'%Y.%m.%d %H:%M')\\
Created user : ${USERNAME}\\
\\
==============================================="

    HEADER="$(sed <<<"${HEADER}" -e 's`|`\\&`g')"

    sed -i "1i\ ${HEADER}" ${LOGFILE}
}

change_user_prompt() {
    if [[ ${SELECT} = "Y" ]] || [[ ${SELECT} = "y" ]] || [[ -z ${SELECT} ]]; then
        su -l ${USERNAME}
        exit 0
    else
        exit 0
    fi
}

backup_and_restore_shell_config() {
    local BASH_BAK = '.bashrc.bak'
    local ZSH_BAK = '.zshrc.bak'

    # backup .bashrc
    if [[ -f "${HOME}/${BASH_BAK}" ]]; then
        read -p "${BASH_BAK} already exists. do you want to overwrite?[y|N]" PROMPT
        if [[ ${PROMPT} = "Y" ]] || [[ ${PROMPT} = "y" ]]; then
            cp "${HOME}/.bashrc" "${HOME}/${BASH_BAK}"
        fi
    else
        echo "backup .bashrc..."
        cp "${HOME}/.bashrc" "${HOME}/${BASH_BAK}"
    fi

    # backup .zshrc
    if [[ -f "${HOME}/${ZSH_BAK}" ]]; then
        read -p "${ZSH_BAK} already exists. do you want to overwrite?[y|N]" PROMPT
        if [[ ${PROMPT} = "Y" ]] || [[ ${PROMPT} = "y" ]]; then
            cp "${HOME}/.bashrc" "${HOME}/${ZSH_BAK}"
        fi
    elif [[ ${SET_ZSH} -eq 1 ]]; then
        echo "backup .zshrc..."
        cp "${HOME}/.zshrc" "${HOME}/${ZSH_BAK}"
    fi
}
