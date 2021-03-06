#!usr/bin/env bash

# Set operating system variable
PLATFORM=$(uname -s)
export PLATFORM

# Add $PATH entries
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/bin:$PATH"

# GNU coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/share/man:$MANPATH"

# GNU findutils
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"

# GNU make
# export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
# export MANPATH="/usr/local/opt/make/libexec/gnuman:$MANPATH"

# GNU sed
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/gnu-sed/share/man:$MANPATH"

# GNU tar
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/gnu-tar/share/man:$MANPATH"

# Homebrew curl
export PATH="/usr/local/opt/curl/bin:$PATH"

# brew command-not-found
if brew command command-not-found-init > /dev/null; then
  eval "$(brew command-not-found-init)";
fi

# z
if [ -f "/usr/local/etc/profile.d/z.sh" ]; then
  . "/usr/local/etc/profile.d/z.sh"
fi

# Source additional dotfiles
for file in ~/.{aliases.local,bash_aliases,bash_prompt,exports,extras,inputrc,functions}; do
  [ -r "$file" ] && [ -f "$file" ] && . "$file";
done;
unset file

# Ignore shellcheck "Cannot follow non-constant source" errors
if which shellcheck > /dev/null; then
  export SHELLCHECK_OPTS="-e SC1090,SC1091"
fi

# Set vim as default editor
export EDITOR=vim
export VISUAL=vim

# Enable vi mode in shell
set -o vi

# Enable Homebrew-installed bash completion
if [ -f "/usr/local/etc/bash_completion" ]; then
  . "/usr/local/etc/bash_completion"
fi

if [ -f "/usr/local/share/bash-completion/bash_completion" ]; then
  . "/usr/local/share/bash-completion/bash_completion"
fi

if [ -f "/usr/local/etc/bash_completion.d" ]; then
  . "/usr/local/etc/bash_completion.d"
fi

if [ -f "/usr/local/share/bash-completion/bash_completion" ]; then
    . "/usr/local/share/bash-completion/bash_completion"
fi

# Enable grc (generic colorizer)
[ -f /usr/local/etc/grc.bashrc ] && . /usr/local/etc/grc.bashrc

# Enable hub and alias it to git
if which hub > /dev/null; then
  eval "$(hub alias -s)"
fi

# Enable thefuck if installed
if which thefuck > /dev/null; then
  eval "$(thefuck --alias)"
fi

# Go #
if which go > /dev/null; then
  export PATH=/usr/local/opt/go/libexec/bin:$PATH
  export GOPATH="$HOME/go"
  export GOOS="darwin"
  export GOBIN="$GOPATH/bin"
  export PATH="$GOBIN:$PATH"
fi

# Rust
## Cargo
if which cargo > /dev/null; then
  export PATH="$HOME/.cargo/bin":$PATH
fi

# s bash completion
if [ -f "$GOPATH/src/github.com/zquestz/s/autocomplete/s-completion.bash" ]; then
  . "$GOPATH/src/github.com/zquestz/s/autocomplete/s-completion.bash"
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file rather than overwriting it
shopt -s histappend;

# Correct spelling errors in arguments supplied to cd
shopt -s cdspell;

# Autocorrect on directory names to match a glob.
shopt -s dirspell 2> /dev/null

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# More intelligent Up/Down behavior
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Enable Travis CI (auto-inserted by Travis gem)
[ -f ~/.travis/travis.sh ] && . ~/.travis/travis.sh

# Use Homebrew-installed curl
export PATH="usr/local/opt/curl/bin:$PATH"

## Colors ##
# Use coreutils `ls` if possible
hash gls >/dev/null 2>&1 || alias gls="ls"

# Always use color, even when piping
if gls --color > /dev/null 2>&1; then
  export colorflag="--color";
else
  export colorflag="-G";
fi

# Force CLI colors
export CLICOLOR_FORCE=1

# ls options: A = include hidden (but not . or ..), F = put `/` after folders, h = byte unit suffixes
alias ls='gls -AFh ${colorflag} --group-directories-first'

# List all files colorized in long format
alias l='ls -lF ${colorflag}'

# List all files colorized in long format, including dotfiles
alias la='ls -laF ${colorflag}'

# List only hidden files
alias lh='ls -d .* ${colorflag}'

# List only directories
alias lsd='ls -l | grep "^d"'

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Enable fzf installed via git
[ -f ~/.fzf.bash ] && . ~/.fzf.bash

## Automatically start gpg-agent daemon
export PATH="/usr/local/opt/gpg-agent/bin:$PATH"

if test -f ~/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
  source ~/.gnupg/.gpg-agent-info
  export GPG_AGENT_INFO
  GPG_TTY=$(tty)
  export GPG_TTY
else
  eval "$(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)"
fi

# if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
#     source ~/.gnupg/.gpg-agent-info
#     export GPG_AGENT_INFO
# else
#     eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
#     eval $(gpg-agent --daemon ~/.gnupg/.gpg-agent-info)
# fi

# mmake (Modern Make) https://github.com/tj/mmake
alias make='mmake'

# PHP
# if [ -f /usr/local/opt/php70/bin/php ]; then
#   export PATH="/usr/local/opt/php70/bin/php:$PATH"
# fi

# export TERM=xterm-256color-italic

# Automatically trim long paths in the prompt (requires Bash 4.x)
## PROMPT_DIRTRIM=2

# set global virtualenv wrapper

## --files: List files that would be searched but do not search
## --no-ignore: Do not respect .gitignore, etc...
## --hidden: Search hidden files and folders
## --follow: Follow symlinks
## --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# bash completion for Docker.app
if [ -f "/Applications/Docker.app" ]; then
  . /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion
  . /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion
  . /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion
fi

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
# [ -f /usr/local/lib/node_modules/yarn-completions/node_modules/tabtab/.completions/yarn.bash ] && . /usr/local/lib/node_modules/yarn-completions/node_modules/tabtab/.completions/yarn.bash

complete -C /Users/christopherwatson/go/bin/gocomplete go

if [ -d ~/.bash_completion.d ]; then
  for file in ~/.bash_completion.d/*; do
    . $file
  done
fi

. ~/.t-completion.sh
. ~/.yarn-completion

# Colorls (https://github.com/athityakumar/colorls)

function lc()
{
  ruby ~/github/clones/colorls/colorls.rb $1;
}

alias lc='lc -r'
