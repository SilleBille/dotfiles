#!/bin/bash

for i in /etc/profile.d/*.sh; do
	source $i
done

if [ "$TILIX_ID" ] || [ "$VTE_VERSION" ]; then
        source /etc/profile.d/vte.sh
fi

# Keep all history
HISTSIZE=-1
HISTFILESIZE=-1

# Force pretty colors
eval "$(dircolors)"
alias ls="ls --color=auto --group-directories-first"
alias grep="grep --color=auto"

export GOPATH="$HOME/Development/go/"

## Common aliases
# emacs alias to fix x-keypass
alias emacs='GPG_AGENT_INFO="" emacs --display "" --no-window-system '

# youtube audio download
alias yaudio='youtube-dl -x --audio-quality 0 --audio-format best -f bestaudio'
alias yvideo='youtube-dl -x --audio-quality 0 --audio-format best -f best -k'

# Convert to mp3
alias ape2mp3='for a in *.ape; do ffmpeg -i "$a" -qscale:a 320k -b 320k "${a[@]/%ape/mp3}" && rm "$a"; done'
alias flac2mp3='parallel avconv -i {} -qscale:a 320k -b 320k {.}.mp3 ::: *.flac'
alias m4a2mp3='parallel avconv -i {} -qscale:a 320k -b 320k {.}.mp3 ::: *.m4a'
alias wav2mp3='parallel avconv -i {} -qscale:a 320k -b 320k {.}.mp3 ::: *.wav'

# Generate a new password
alias genpass="tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1"

## PS1
PS1='[\u@\h \W]\$ '

export PATH="/usr/lib64/ccache:$GOPATH/bin:$HOME/.rbenv/bin:/usr/local/go/bin:/opt/bin:/opt/node/bin:/usr/games/bin:$HOME/bin:/usr/local/racket/bin:$PATH"

alias allpdflatex="echo *.tex | entr -r pdflatex -halt-on-error ./*.tex"

# git aliases
alias gta='git add'
alias gtb='git branch'
alias gtc='git clone'
alias gtd='git diff'
alias gtdt='git difftool'
alias gtdc='git diff --cached'
alias gtdh='git diff HEAD~'
alias gtfp='git push --force'
alias gtl='git log'
alias gtm='git commit -s'
alias gtma='git commit -s --amend'
alias gto='git checkout'
alias gtob='git checkout -b'
alias gtp='git push'
alias gtpsu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gtr='git rebase'
alias gtrm='git rebase -i master'
alias gtrc='git rebase --continue'
alias gtre='git reset'
alias gtrh='git reset HEAD'
alias gts='git status'
alias gtsl='git shortlog -s -n'
alias gtu='git pull'
alias gtum='git checkout master && git pull upstream master && git push'
function gtub() {
    local branch=$1
    git checkout "$branch" && git pull upstream "$branch" && git push
}

# grep aliases
alias gir='grep --exclude=tags -iIr'
alias gic='grep --exclude=tags -nIHr'
alias gif='grep --exclude=tags -iInHr'

# project aliases
alias actags='ctags -R  --c-kinds=+cdefglmnpstuvx --langmap=c:+.cin.hin'
alias fbuild='rm build -rf ; mkdir build ; cd build ; touch .gitkeep ; cmake .. && time make -j5'
alias fcbuild='rm build -rf ; mkdir build ; cd build ; touch .gitkeep ; cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ .. && make -j5'
alias fdbuild='rm build -rf ; mkdir build ; cd build ; touch .gitkeep ; CFLAGS="-Wall -Wextra -Og -ggdb" CXXFLAGS="-Wall -Wextra -Og -ggdb" cmake -D CMAKE_BUILD_TYPE=Debug .. && make -j5'
alias fcdbuild='rm build -rf ; mkdir build ; cd build ; touch .gitkeep ; CFLAGS="-Wall -Wextra -Og -ggdb" CXXFLAGS="-Wall -Wextra -Og -ggdb" cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -D CMAKE_BUILD_TYPE=Debug .. && make -j5'


# Laptop aliases
ldock() {
    dconf write /org/gnome/settings-daemon/plugins/xsettings/overrides "{'Gdk/WindowScalingFactor': <1>}"
    dconf write /org/gnome/desktop/interface/text-scaling-factor 0.75
}

lundock() {
    dconf write /org/gnome/settings-daemon/plugins/xsettings/overrides "{'Gdk/WindowScalingFactor': <2>}"
    dconf write /org/gnome/desktop/interface/text-scaling-factor 0.65
}

# Upload images
upload() {
    img="$1"
    extension="${img##*.}"
    rimg="$RANDOM-$RANDOM.$extension"
    echo "$img->$rimg"
    scp "$img" "cipherboy:/home/website/cipherboy-website/i/$rimg"
    echo "https://cipherboy.com/i/$rimg"
}

if [ ! -f "$HOME/.no_powerline" ] && [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi
