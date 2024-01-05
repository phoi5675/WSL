#!/bin/bash
inst_build_essentials() {
    sudo apt-get install build-essential ${LOG_LVL} -y
}

inst_ssh_server() {
    sudo apt-get install openssh-server
    sudo service ssh start # starts openssh server
}

inst_python2() {
    sudo apt-get install python2 -y ${LOG_LVL}
}

inst_python3() {
    printf "Installing python %s\n" ${VER_PY3}
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt-get update ${LOG_LVL}
    sudo apt-get install python"${VER_PY3}" ${LOG_LVL} -y
}

inst_git() {
    sudo apt-get install git ${LOG_LVL} -y
}

inst_java() {
    sudo apt-get install openjdk-${VER_OPEN_JDK}-jdk ${LOG_LVL} -y

    # Add $PATH and $JAVA_PATH to ${HOME}/."${SHELL}"rc
    echo "" >>"${HOME}"/."${SHELL}"rc # To make a new line
    echo "#JAVA_PATH" >>"${HOME}"/."${SHELL}"rc
    echo export JAVA_HOME="/usr/lib/jvm/java-${VER_OPEN_JDK}-openjdk-amd64" \
        >>"${HOME}"/."${SHELL}"rc
    echo export PATH=${PATH}:$JAVA_HOME/bin >>${HOME}/."${SHELL}"rc

}

inst_nodejs() {
    # Install nvm
    sudo apt-get install curl ${LOG_LVL} -y
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
    sudo apt-get update ${LOG_LVL}
    sudo apt-get install fonts-nanum ${LOG_LVL} -y
}

inst_docker_cli() {
    # Script from docker official doc
    # https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
    echo "Uninstall docker related package previously installed..."
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
        sudo apt-get remove $pkg
    done

    # Add Docker's official GPG key:
    sudo apt-get update ${LOG_LVL}
    sudo apt-get install ca-certificates curl gnupg ${LOG_LVL} -y
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    # Add the repository to Apt sources:
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
        sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
    sudo apt-get update

    echo "Install docker-cli..."
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin ${LOG_LVL} -y
}
