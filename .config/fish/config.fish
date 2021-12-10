set -x fish_greeting

set -x VISUAL nvim
set -x EDITOR nvim

set -x fzf_fd_opts -HE .git
set -x GOPROXY https://goproxy.io,direct
set -x GOPATH $HOME/.go
set -x PUB_HOSTED_URL https://pub.flutter-io.cn
set -x FLUTTER_STORAGE_BASE_URL https://storage.flutter-io.cn
set -x KUBECONFIG $HOME/.kube/kubeconfig.yml

set -x HOMEBREW_NO_ENV_HINTS 1

fish_add_path /usr/local/sbin
fish_add_path /usr/local/opt/gnu-tar/libexec/gnubin
fish_add_path /usr/local/opt/openssl/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/gnu-tar/libexec/gnubin
fish_add_path $HOME/.krew/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.yarn/bin
fish_add_path $HOME/.local/bin
fish_add_path $GOPATH/bin

abbr t 'trans :zh'

alias d docker
alias icat 'kitty +kitten icat'
alias k kubectl
alias kx kubectx
alias l 'ls -al'
alias ld lazydocker
alias lg lazygit
alias ls exa
alias n nvim
alias v vim
alias s 'kitty +kitten ssh'

if status is-interactive
    if type -q fnm
        fnm env | source
    end

    if type -q pyenv
        pyenv init --path | source
    end

    if type -q starship
        starship init fish | source
    end
end
