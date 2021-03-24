set -o noclobber

shopt -s globstar
shopt -s nocaseglob

HISTCONTROL=ignoreboth
HISTFILESIZE=20000
HISTSIZE=10000
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a'
PS1='\[\e]0;\u@\h:\w\a\]\[\e[1;37m\]\u@\h:\w\[\e[0m\]\$ '

dt=%y%m%d-%H%M%S
jj='crond|systemd|sudo'

alias cp='cp -aiv' la='ls -A' le='less -RSi' ll='la -hl --color=always' ls='ls -N --color=auto' mv='mv -iv' rm='rm -Iv'

alias cn='cp --no-preserve=all'
alias cu='curl -#LO'
alias fd='fd -c never'
alias hh=htop
alias hs='python3 -m http.server'
alias lg='la -F | grep'
alias nh='unset HISTFILE'
alias oo='nu xdg-open'
alias os='[ $1 = -s ] && s=sudo && shift || s='
alias rl='readlink -f'
alias rt='rr -t /tmp'
alias rz='rr -z'
alias ti='ll -tr'
alias tp='tar -OPx -f'
alias uu='du -hs'
alias vn='vi -i NONE'
alias xd='export DISPLAY=:0'

alias sudo='sudo '

ap () { PATH="$HOME/bin:/usr/local/bin:$PATH"; }
ba () { os; $s rc -p $1 ~/backup; }
bd () { os; $s vi -d $1 ~/backup/$(rl $1 | tr / +); }
bh () { ls ~/backup/bash/*.gz | tail -${1:-10} | xargs zcat | perl -0pe 's/#(\d+)\n(.*)/\1 \2/g' | sort -u | le; }
bi () { bind -f ~/.inputrc; }
bx () { for i in $(borg list --short $1 | tac); do borg info $1::$i; read; done; }
ca () { python3 -c "print($1)"; }
cb () { xsel -b $@; }
cc () { cut -c -$((${1:-1}*16-1)) | column -c $(tput cols); }
cl () { cd $(find -maxdepth 1 -type d | sort | tail -1); }
cm () { ca "$2*$3/$1"; }
co () { sed -e 's/^\s\+//' -e 's/\s\+/ /g' | cut -d ' ' -f $1; }
cs () { curl -o /dev/null -Ls -w '%{http_code}\n' $1; }
cw () { wmctrl -c $1; }
cx () { sed "s/\t/  /g" | cut -c -${1:-$COLUMNS}; }
cz () { sudo compsize $1 | grep ^TOTAL | co 2-4; }
d1 () { sed -n 's/^< //p'; }
d2 () { sed -n 's/^> //p'; }
d8 () { dig +short $1 @8.8.8.8; }
db () { os; $s vi -d $(ls -t $1{,-*} | head -2); }
di () { dict -d wn "$*" | tail -n +5 | paste -s -d '' | sed -r -e 's/ {9,}/ /g' -e 's/ {6}([a-z]+) /\n\n\U\1\n  /g' -e 's/ {6}/\n  /g' | fold -s -w $COLUMNS; }
dp () { os; $s vi -d $2 ${1%/}/$2; }
ds () { os; $s vi -d $2 scp://$1/$2; }
dt () { vi -d $1 <(tp $2); }
ec () { head -c ${2:-80} /dev/zero | tr '\0' $1; echo; }
ef () { mq $2 && return; encfs -i 60 ${@:3} $(rl $1) $2; }
er () { [ $1 ] && a="/$1/" || a=0; [ $2 ] && b="/$2/" || b=$; sed -n "$a,${b}p"; }
et () { le $(ls /tmp/$1*log | tail -1); }
ff () { df -Th $@ | tail -n +2 | grep -v tmpfs | sort -k 7 | xargs printf '%-15.15s %-10.10s %5s %5s %5s %5s %s\n'; }
fu () { fusermount -u $2 /tmp/$1; }
gr () { fd -t f ${3:-.} ${2:-.} -X grep -il "$1"; }
hg () { history | grep -i "$1" | le; }
hl () { grep -E --color "$1|"; }
ho () { sed "s:$HOME:~:"; }
hr () { curl -s $1 | sed -nr 's/.*href[^>]*.([^<]*).*/\1/p'; }
ia () { ip -4 -o a | sed -r 's/^[^ ]* ([^ ]*).*inet ([^/]*).*/\1: \2/'; }
ii () { curl -s https://ipinfo.io/$1 && echo; }
il () { ip -o l | sed -nr 's/^[^ ]* ([^:]*).*ether ([^ ]*).*/\1: \2/p'; }
im () { mkdir im && cp ${@:3} im && mogrify -quality $1% -resize $2x$2 -verbose ${@:3}; }
jg () { journalctl -n 5000 | grep -i "$@" | le +G; }
jj () { journalctl -n 5000 | grep -Eiv "$jj" | le +G; }
kp () { nc -w 1 -z $1 $2; }
l2 () { la -F $1 | cc 2; }
lc () { la -F $1 | cc; }
lh () { ll $1 | head -20; }
lo () { tr A-Z a-z; }
lr () { ll -d $2**/*$1*; }
lt () { ll $1 | tail -20; }
lu () { la -p | us; }
ma () { mail -s "$HOSTNAME: $1" ${@:2}; }
mc () { mkdir -p "$1" && cd "$1"; }
ml () { mv "$1" "${1,,}"; }
mo () { mv "$@" $OLDPWD; }
mq () { mountpoint -q $1 && echo "$1 already mounted"; }
ms () { ma $1 $ma <<< "$? - $PWD"; }
n1 () { "$@" 1> /dev/null; }
n2 () { "$@" 2> /dev/null; }
nd () { nu "$@" & disown; }
nn () { n2 sudo nethogs $(route -n | sed -n '3s/.* //p'); }
nu () { "$@" &> /dev/null; }
om () { sudo chown -v --reference=$1 ${@:2}; sudo chmod -v --reference=$1 ${@:2}; }
on () { while eval $([ $4 ] || echo !) nc -w 10 -z $1 $2; do date; sleep ${3:-60}; done; ma on $ma <<< $@; }
pk () { pp $1 | tail -1 | co 2 | xargs -r kill --verbose $2; sleep 1; pp $1; }
pm () { ca "($(ps -eF | grep -i $1 | co 6 | paste -d + -s))//1024"; }
pp () { ps -ef --sort=start_time | grep -i ${1:-$^} | grep -v grep; }
ra () { shuf -i ${2:-1}-$1 -n 1; }
rd () { nc -w 5 -z $1 3389 && n2 zenity --password | nd xfreerdp +auto-reconnect /cert:ignore /dynamic-resolution /from-stdin -grab-keyboard /u:$2 /v:$1 ${@:3}; }
re () { t=/tmp/tr; ef ~/.trash $t && rr -t $t "$@"; }
rn () { mv "$2" "$1.${2##*.}"; }
rp () { local c=$(type -p perl-rename prename | head -1); e="s/$1/$2/gi"; $c -n "$e" "${@:3}"; ry && $c -iv "$e" "${@:3}"; }
rs () { s='rsync -ahv --del'; $s -n "$@" && ry && $s --max-size=10M "$@" && $s -P "$@"; }
ry () { echo -en "${1:-? }"; read r; [ "$r" = y ]; }
sb () { unalias -a; . ~/.bashrc; }
sd () { s='rsync -ahv'; $s -n "$@" && ry && $s "$@"; }
sf () { mq $2 && return; mkdir -p $2; sshfs $1 $2 ${@:3}; }
sg () { systemctl list-unit-files | co 1 | grep -i $1; }
sm () { s='rsync -ahv --del'; $s -n "${@:2}" && ry && $s --max-size=1M "${@:2}" && $s -P --bwlimit=$1 "${@:2}"; ms rsync; }
sr () { rs "$@" && rm -r "${@:1:$#-1}"; }
ss () { sensors coretemp-isa-0000 | sed -n '/^Core/s/  \+/ /gp'; }
sv () { nu ssvncviewer -bgr233 -encodings zrle -x11cursor $@; }
sx () { sudo x11vnc -q -display :0 -usepw -auth /run/lightdm/root/:0 $@; }
ta () { n1 tmux -2 attach -d; }
tb () { tp $1 | cb; }
td () { d=$(($(date +%s -d "$2")-$(date +%s -d "$1"))); date -d @$d -u +"$((d/86400))d %T"; }
tg () { grep -i $1 $(ls -t ~/trash/*idx) | sed "s/idx:/tar /" | while read t a; do echo "$(ll $t) $a"; tp $t "$a" | head -100; echo; ec -; done | le; }
tt () { cd ~/tmp && ll; }
tx () { bsdtar -tf "$1" | head; read; bsdtar -xvf "$1"; }
up () { uptime | xargs; }
us () { n2 xargs -d '\n' -r du -chsx | sort -h | tail -100; }
ux () { fd -t f '\.' | sed 's/.*\.//' | sort -u | while read i; do z=$(fd -e $i -t f -X du -ch | tail -1 | cut -f 1); echo -e "$z\t$i"; done | sort -h; while read -p '> ' i; do [ $i ] || break; fd -e $i -t f -X du -ch | sort -h | tail; done; }
vc () { t=/tmp/vc-$(date +%s).${1:-txt} && cb -o > $t && vi $t && cb < $t && rr -z $t; }
wa () { while eval $@; do sleep 60; echo; ec -; done; }
wd () { w3m -cols ${2:-80} -dump -O ASCII $1; }
wm () { a=$(eval $1); echo "$a"; b=$a; while true; do sleep $2 || return 1; b=$(eval $1); date; diff <(echo "$a") <(echo "$b") | d2 | tee /dev/tty | ma "$3" -E $ma; a=$b; done; }
wp () { while pgrep -a $1; do sleep 5m; date; done; }
wx () { while read i; do eval $@; done; }
xg () { compgen -c | sort -u | grep $@; }
xv () { x11vnc -q -display :0 -usepw $@; }

for i in ~/.aliases-*; do . $i; done

eval $(dircolors)
