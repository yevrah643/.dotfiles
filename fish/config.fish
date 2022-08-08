set fish_greeting "Nice Day, Harvey!!!"

if type -q exa 
	alias ll "exa -l -g --icons"
	alias lla "ll -a"
end 

# set $VARIABLE 
set -gx EDITOR nvim 
set -gx HOME /Users/tuongquangphung/

set -gx PATH bin $PATH
set -gx PATH ~/.local/bin $PATH

# alias
alias vim nvim 
alias g git 
alias ls "ls -p -G"
alias la "ls -A"
alias lla "ll -A"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/tuongquangphung/opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

