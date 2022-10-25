set -x fish_greeting

set -x VISUAL nvim
set -x EDITOR nvim

set -x fzf_fd_opts -HE .git
set -x GOPATH $HOME/.go
set -x PUB_HOSTED_URL https://pub.flutter-io.cn
set -x FLUTTER_STORAGE_BASE_URL https://storage.flutter-io.cn
set -x GPG_TTY (tty)

set -x HOMEBREW_NO_ENV_HINTS 1
set -x USE_GKE_GCLOUD_AUTH_PLUGIN True

fish_add_path /usr/local/sbin
fish_add_path /usr/local/opt/gnu-tar/libexec/gnubin
fish_add_path /usr/local/opt/openssl/bin
fish_add_path (brew --prefix)/sbin
fish_add_path (brew --prefix)/bin
fish_add_path (brew --prefix)/opt/gnu-tar/libexec/gnubin
fish_add_path $HOME/.krew/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.yarn/bin
fish_add_path $HOME/.local/bin
fish_add_path $GOPATH/bin
fish_add_path $HOME/.bun/bin

source (brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc

function kubectl
  kubecolor $argv
end

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

alias k kubectl
alias kx kubectx
alias ld lazydocker
alias lg lazygit
alias n nvim
alias ipmi "ipmitool -I lanplus -H 10.10.0.10 -U shikun -P (gopass cat personal/common)"
