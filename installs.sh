#!/bin/bash
inst_build_essentials() {
    sudo apt-get install build-essential -qq >/dev/null
}

inst_python2() {
    sudo apt-get install python2 -y -qq >/dev/null
}

inst_python3() {
    printf "Installing python %s\n" ${VER_PY3}
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt-get update -qq >/dev/null
    sudo apt-get install python"${VER_PY3}" -qq >/dev/null
}

inst_git() {
    sudo apt-get install git -qq >/dev/null
}

inst_java() {
    sudo apt-get install openjdk-${VER_OPEN_JDK}-jdk -qq >/dev/null

    # Add $PATH and $JAVA_PATH to ${HOME}/."${SHELL}"rc
    echo "" >>"${HOME}"/."${SHELL}"rc # To make a new line
    echo "#JAVA_PATH" >>"${HOME}"/."${SHELL}"rc
    echo export JAVA_HOME="/usr/lib/jvm/java-${VER_OPEN_JDK}-openjdk-amd64" \
        >>"${HOME}"/."${SHELL}"rc
    echo export PATH=${PATH}:$JAVA_HOME/bin >>${HOME}/."${SHELL}"rc

}

inst_nodejs() {
    # Install nvm
    sudo apt-get install curl -qq >/dev/null
    curl --no-progress-meter -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh |
        bash

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

    NODEJS_PREFIX=""
    if [[ "${VER_NODEJS}" == "lts" ]]; then
        NODEJS_PREFIX="--"
    fi
    nvm install --no-progress "${NODEJS_PREFIX}""${VER_NODEJS}"
}

inst_kor_font() {
    sudo apt-get update -qq >/dev/null
    sudo apt-get install fonts-nanum -qq >/dev/null
}
