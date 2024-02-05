#!/bin/bash

set_timezone() {
    sudo ln -s --force /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
}

set_mirror_to_kakao() {
    echo "Change apt server to kakao..."
    sudo sed -i 's/\(kr\.\)\{0,1\}archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
    sudo apt-get update -q >/dev/null
}

set_shell_prompt() {
    echo "Add shell prompt settings from ${CONFIG}/."${SHELL}"_config..."
    cat "${CONFIG}"/."${SHELL}"_config >>"${HOME}"/."${SHELL}"rc
    # source "${HOME}"/."${SHELL}"rc
}

set_vim() {
    echo "Add vim settings from ${CONFIG}/.vimrc..."
    cat "${CONFIG}"/.vimrc >>"${HOME}"/.vimrc
}

set_gitconfig() {
    local gitconfig_dir="${CONFIG}/gitconfigs"

    echo "Copying global configs..."
    cp ${gitconfig_dir}/.gitconfig "${HOME}"/.gitconfig
    cp ${gitconfig_dir}/.gitignore_global "${HOME}"/.gitignore_global
    cp ${gitconfig_dir}/.gitmessage "${HOME}"/.gitmessage
    # echo "Copying local configs..."
    # cp ${gitconfig_dir}/.gitconfig_github "${github_dir}"/.gitconfig
    # cp ${gitconfig_dir}/.gitconfig_bitbucket "${bitbucket_dir}"/.gitconfig

    read -p "Write user name for git : " GIT_USERNAME
    read -p "Write email for git : " GIT_EMAIL

    sed -i "s/name = \S*/ name = ${GIT_USERNAME}/" "${HOME}"/.gitconfig
    sed -i "s/email = \S*/ email = ${GIT_EMAIL}/" "${HOME}"/.gitconfig
    sed -i "s_.gitmessage_${HOME}/.gitmessage_" "${HOME}"/.gitconfig
    echo "Setup for .gitconfig done!"

    echo "Set git name as ${GIT_USERNAME}"
    echo "Set git email as ${GIT_EMAIL}"
    printf "Set default gitconfig message as below.\n\n%s\n\n" "$(cat ${HOME}/.gitmessage)"
}

set_zsh() {
    if [[ "$SHELL" -eq "$ZSH" ]]; then
        echo "Install Oh-my-zsh..."
        sudo apt-get update -q >/dev/null
        sudo apt-get install zsh ${LOG_LVL} -y >/dev/null

        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ""
        cat >>~/."${BASH}"rc <<EOF

# Exec zsh on vscode
if [ -t 1 ]; then
  exec zsh
fi

EOF
        local ZSH_CUSTOM="${HOME}"/.oh-my-zsh/custom
        echo "Install plugins..."
        # plugins from https://gist.github.com/n1snt/454b879b8f0b7995740ae04c5fb5b7df
        # Auto-suggestions
        git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
        # Syntax-highlighting
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
        # Fast-syntax-highlighting
        git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
        # Autocomplete
        git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

        echo "Add plugins to .zshrc..."
        sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)/g' \
            ~/."${ZSH}"rc

        echo "Change theme to custom..."
        sed -i -E 's/ZSH_THEME="\w+"/ZSH_THEME="custom"/g' ~/."${ZSH}"rc
        cp "${CONFIG}"/custom.zsh-theme "${HOME}"/.oh-my-zsh/themes/

    else
        echo "Skip setup zsh..."
    fi
}

set_created_user_to_default() {
    read -p "Set ${USERNAME} as default user when wsl starts? [Y/n] " PROMPT

    if [[ ${PROMPT} = "Y" ]] || [[ ${PROMPT} = "y" ]] || [[ -z ${PROMPT} ]]; then
        touch /etc/wsl.conf
        cat >/etc/wsl.conf <<EOF
[user]
default=${USERNAME}
EOF
    fi

}
