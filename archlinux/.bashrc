#!usr/bin/env bash

# Set vim as default editor
export EDITOR='vim'

# Enable vi mode in shell
set -o vi

# Enable bash aliases if present
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable z
. ~/z/z.sh

# Enable chruby
. /usr/share/chruby/chruby.sh
chruby ruby 2.3.0

# Golang env variables
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$GOPATH/bin:$PATH

# Enable nvm
export NVM_DIR="$HOME/.nvm"
. /usr/share/nvm/nvm.sh
. /usr/share/nvm/bash_completion

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Load extra dotfiles if present
for file in ~/.{bash_prompt,exports,inputrc,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && . "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Long list of all files in colorized format
alias ll='ls -laF --color'

# List only hidden files
alias lh="ls -d .*"

# Always use color output for `ls`
alias ls='command ls --color'

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Solarized dircolors
eval `dircolors ~/.dir_colors`

# Enable fzf
[ -f ~/.fzf.bash ] && . ~/.fzf.bash

# npm no sudo fix
export NPM_PACKAGES="/home/cwonarch/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH  # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
