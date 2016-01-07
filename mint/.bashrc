. ~/.bash_aliases
. ~/.bash_prompt
. ~/z/z.sh

set -o vi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

. /usr/local/share/chruby/chruby.sh
chruby ruby 2.3.0

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/go/bin

eval "$(hub alias -s)"

if [ -f $GOPATH/src/github.com/github/hub/etc/hub.bash_completion.sh ]; then
	. $GOPATH/src/github.com/github/hub/etc/hub.bash_completion.sh
fi

export SASS_LIBSASS_PATH=$HOME/libsass

### from El Capitan .bashrc ###

# Use English UTF-8 as default
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Load extra dotfiles if present
for file in ~/.{bash_prompt,extras,functions,inputrc}; do
  [ -r "$file" ] && [ -f "$file" ] && . "$file";
done;
unset file;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Enable gulp completion
eval "$(gulp --completion=bash)"

# Enable thefuck
# alias fuck='$(thefuck $(fc -ln -1))'

### Bash modifications ###

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Check the window size after each command ($LINES, $COLUMNS)
shopt -s checkwinsize

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

## ls colors and aliases ##
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# List all - Long list of all files in colorized format
alias la='ls -laF --color'

# List only hidden files
alias lh="ls -d .*"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
alias ls='command ls --color'

# Always enable colored grep output
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
	function diff() {
		git diff --no-index --color-words "$@";
	}
fi;

# Use the text that has already been typed as the prefix for searching through
# commands (i.e. more intelligent Up/Down behavior)
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Git-Friendly configuration
export GIT_FRIENDLY_NOBUNDLE
export GIT_FRIENDLY_NO_NPM
export GIT_FRIENDLY_NO_BOWER

eval `dircolors ~/.dircolors`

[ -f ~/.fzf.bash ] && source ~/.fzf.bash