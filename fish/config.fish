# function fish_greeting
#     echo yevrah643 hop on (set_color yellow; date +%T; set_color normal)
# end
set fish_greeting ""

# Start Up the Starship theme
starship init fish | source

# exa shortcut
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

if status is-interactive
    # Commands to run in interactive sessions can go here
end
