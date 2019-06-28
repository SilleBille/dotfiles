# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# added by travis gem
[ -f /home/dmoluguw/.travis/travis.sh ] && source /home/dmoluguw/.travis/travis.sh

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="[\u@\h \[\e[32m\]\w\[\e[0m\]] \[\e[33m\]\$(parse_git_branch)\[\e[0m\] $ "

# Shortcut to reload bashrc file
alias reload='source $HOME/.bashrc'

# Load scripts in bashrc.d directory
for script in $HOME/.bashrc.d/*.sh; do
	source "$script"
done
