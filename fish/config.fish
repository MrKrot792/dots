if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias lz='/bin/ls'
alias ls='eza -l --color=always --icons=always --no-quotes --almost-all --sort=type --no-user --no-permissions --git'
alias lt='eza -lT --color=always --icons=always --no-quotes --almost-all --sort=type --no-user --no-permissions --git'
alias v='nvim'
alias c='bat'

zoxide init fish | source
