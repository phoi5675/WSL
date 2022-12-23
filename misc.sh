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
    # FIXME: statement not working even if enter 'Y', 'y', or 'n'.
    # Change user to created one.
    read -p "Do you want to login as ${USERNAME}? [Y/n]" SELECT
    if [[ ${SELECT} -eq "Y" ]] || [[ ${SELECT} -eq "y" ]]; then
        su -l ${USERNAME}
        exit 0
    else
        exit 0
    fi
}
