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
