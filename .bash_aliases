set -o noclobber

shopt -s globstar
shopt -s nocaseglob

HISTCONTROL=ignoreboth
HISTFILESIZE=20000
HISTSIZE=10000
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a'
PS1='\[\e]0;\u@\h:\w\a\]\[\e[1;37m\]\u@\h:\w\[\e[0m\]\$ '

ad='--af=dynaudnorm'
dt=%y%m%d-%H%M%S
jj='cron|systemd'
sp=--save-position-on-quit

alias cp='cp -aiv' la='ls -A' le='less -RSi' ll='la -hl --color=always' ls='ls -N --color=auto' mv='mv -iv' rm='rm -Iv'

alias cn='cp --no-preserve=all'
alias cu='curl -#LOR'
alias fd='fd -HIL -c never --xdev'
alias hh=htop
alias lg='la -F | grep'
alias nh='unset HISTFILE'
alias oo='n2 xdg-open'
alias os='[ $1 = -s ] && s=sudo && shift || s='
alias ti='ll -tr'
alias tp='tar -OPx -f'
alias uu='du -hs'
alias vn='vi -i NONE'

alias sudo='sudo '

ap () { echo "$PATH" | grep -Fq "$1" || PATH="$1:$PATH"; }
ba () { os; $s rc -p $1 ~/backup; }
bd () { os; $s vi -d $1 ~/backup/$(realpath $1 | tr / +); }
bh () { ls ~/backup/bash/*.gz | tail -25 | xargs zcat | tr '\n' '#' | grep -Eao '[0-9]{10}#[^#]+' | tr '#' ' ' | sort -u | le; }
bi () { bind -f ~/.inputrc; }
br () { c='csd-backlight-helper -b raw'; b=$($c --get-brightness); m=$($c --get-max-brightness); [ $1 ] && sudo $c --set-brightness $(($m * $1 / 100)) || echo $((($b + 1) * 100 / $m)); }
bx () { for i in $(borg list --short $1 | tac); do borg info $1::$i; read; done; }
ca () { python3 -c "print($1)"; }
cb () { xsel -b $@; }
cc () { cut -c -$((${1:-1}*16-1)) | column -c $(tput cols); }
cf () { ld | while read i; do l=$(find "$i" -type f | wc -l); echo -e "$l\t$i"; done | sort -n; }
cm () { ca "$2 * $3 / $1"; }
co () { tr -s ' ' '\t' | cut -f $1; }
cs () { curl -o /dev/null -Ls -w '%{http_code}\n' $1; }
cw () { wmctrl -c $1; }
cx () { sed "s/\t/  /g" | cut -c -${1:-$COLUMNS}; }
cz () { sudo compsize -x $1 | grep ^TOTAL | co 2-4; }
d1 () { sed -n 's/^< //p'; }
d2 () { sed -n 's/^> //p'; }
db () { os; $s vi -d $(ls -t $1{,-*} | head -2); }
dc () { vi -d $1 <(cb -o); }
di () { dict -d wn "$*" | tail -n +5 | paste -s -d '' | sed -r -e 's/ {9,}/ /g' -e 's/ {6}([a-z]+) /\n\n\U\1\n  /g' -e 's/ {6}/\n  /g' | fold -s -w $COLUMNS; }
dp () { os; $s vi -d $2 ${1%/}/$2; }
ds () { $s vi -d $2 scp://$1/$2; }
dt () { vi -d $1 <(tp $2); }
ec () { head -c ${2:-80} /dev/zero | tr '\0' $1; echo; }
ef () { mq $2 && return; encfs -i ${3:-5} ${@:4} $(realpath $1) $(realpath $2); }
er () { [ $1 ] && a="/$1/" || a=0; [ $2 ] && b="/$2/" || b=$; sed -n "$a,${b}p"; }
ff () { df -Th --exclude-type={devtmpfs,efivarfs,tmpfs} $@; }
fo () { cat -n | sort -u -k 2 | sort -n -k 1 | cut -f 2; }
fu () { fusermount -u $2 /tmp/$1; }
hc () { host $1 1.1.1.1 | sed -n 's/.*has address //p'; }
hg () { history | grep -i "$1" | le; }
hl () { grep -E --color "$1|"; }
ho () { sed "s:$HOME:~:"; }
hr () { curl -Ls $1 | sed -nr 's/.*href[^>]*.([^<]*).*/\1/p'; }
hs () { docker run -it -p 8080:80 -v $PWD:/usr/share/nginx/html --pull always --rm nginx; }
hu () { sudo sed -i "/$1$/s/^[^ ]*/$2/" /etc/hosts; }
ia () { ip -4 -o a | sed -r 's/^[^ ]* ([^ ]*).*inet ([^/]*).*/\1: \2/'; }
ii () { curl -s https://ipinfo.io/$1 && echo; }
il () { ip -o l | sed -nr 's/^[^ ]* ([^:]*).*ether ([^ ]*).*/\1: \2/p'; }
jg () { journalctl -b $2 | grep -i "$1" | le +G; }
jj () { journalctl -b $1 | grep -Eiv "($jj)" | le +G; }
kp () { nc -vz -w 1 $1 $2; }
l2 () { la -F $1 | cc 2; }
lc () { la -F $1 | cc; }
ld () { find -maxdepth 1 -mindepth 1 -type d -printf '%P\n' | sort; }
lh () { ll $1 | head -20; }
lo () { tr A-Z a-z; }
lr () { ll -d $2**/*$1*; }
lt () { ll $1 | tail -20; }
lu () { la -p | us; }
m1 () { while true; do date; xdotool mousemove_relative 50 0 sleep .1 mousemove_relative -- -50 0; sleep 5m; done; }
ma () { mail -s "$HOSTNAME: $1" ${@:2} $ma; }
mc () { mkdir -p "$1" && cd "$1"; }
mh () { ef ~/.$1 /tmp/$1 $2 && cd /tmp/$1 && nh; }
ml () { mv "$1" "${1,,}"; }
mo () { mv "$@" $OLDPWD; }
mp () { nd mpv --quiet "$@"; }
mq () { mountpoint -q $1 && echo "$1 already mounted"; }
ms () { ma $1 <<< $?; }
n1 () { "$@" 1> /dev/null; }
n2 () { "$@" 2> /dev/null; }
nd () { nu "$@" & disown; }
nn () { n2 sudo nethogs $(route -n | sed -n '3s/.* //p'); }
ns () { sudo nmap -sn $1 | grep -v ^Host | tr '\n' @ | sed 's/@MAC/ - MAC/g' | tr @ '\n'; }
nu () { "$@" &> /dev/null; }
om () { sudo chown -v --reference=$1 ${@:2}; sudo chmod -v --reference=$1 ${@:2}; }
on () { while ! nc -vz -w 5 $1 $2; do date; sleep ${3:-60}; done; ma on <<< $@; }
pc () { sed -nr "s/^${2:-.*}:([^ ]*).*/\1/p" $1 | head -1 | cb; }
pk () { k=/bin/kill; $k --help | grep -q '\--verbose' && k="$k --verbose"; pp $1 | ty | tail -1 | co 2 | xargs -r $k $2; sleep 1; pp $1; }
pm () { s=$(ps -eF | tail -n +2 | grep -i "$1" | grep -v grep | co 6 | paste -d + -s); ca "round((${s:-0}) / 1024, 1)"; }
pp () { [ $1 ] || return; ps -ef --sort=start_time | grep -i $1 | grep -v grep; }
pt () { mpv --no-audio --really-quiet --vo=tct "$@"; }
ra () { shuf -i ${2:-1}-$1 -n 1; }
rd () { nc -w 5 -z $1 3389 || return; l=/tmp/rdp-$(date +%s).log p=$(sp); xfreerdp3 +auto-reconnect /cert:ignore /dynamic-resolution -grab-keyboard /p:"$p" /u:$2 /v:$1 /wm-class:ssvnc ${@:3} &> $l & disown; unset p; ry && le $l; }
re () { t=/tmp/trash; ef ~/.trash $t && rr -t $t "$@"; }
rn () { mv "$2" "$1.${2##*.}"; }
rp () { c=$(type -p perl-rename prename); $c --help | grep -q '\--interactive' && c="$c -i"; $c -n "$@"; ry && $c -v "$@"; }
rs () { s='rsync -ahv --del'; $s -n "$@" && ry && $s --max-size=10M "$@" && $s -P "$@"; }
ry () { echo -en "${1:-? }"; read r; [ "$r" = y ]; }
s5 () { export ALL_PROXY=socks5h://localhost:1080; }
sb () { unalias -a; . ~/.bashrc; }
sd () { s='rsync -ahv'; $s -n "$@" && ry && $s "$@"; }
sf () { mq $2 && return; mkdir -p $2; sshfs $1 $2 ${@:3}; }
sg () { systemctl list-unit-files ${2:+--user} | co 1 | grep -i $1; }
sm () { s='rsync -ahv --del'; $s -n "${@:2}" && ry && t=$(date +%s) && $s --max-size=1M "${@:2}" && $s -P --bwlimit=$1 "${@:2}"; e=$?; [ $(($(date +%s) - $t)) -gt 60 ] && ma rsync <<< $e; }
sp () { systemd-ask-password --emoji=no; }
ss () { sensors coretemp-isa-0000 | sed -n '/^Core/s/  \+/ /gp'; }
sv () { sp | nd ssvncviewer -autopass -bgr233 -encodings zrle $@; }
sx () { sudo x11vnc -q -display :0 -usepw -auth /run/lightdm/root/:0 $@; }
ta () { n1 tmux -2 attach -d; }
tb () { tp $1 | cb; }
td () { d=$(($(date +%s -d "$2") - $(date +%s -d "$1"))); echo "$(($d / 86400))d $(date -d @$d -u +%T)"; }
tg () { find ~/trash/ -name '*.idx' | sort -r | xargs grep -i "$1" | sed 's/idx:/tar /' | while read t a; do x=$(tar -OPx -f $t "$a" | head -${3:-25} | tr -d '\0'); grep -iq "$2" <<< $x && echo -e "$(ll $t) $a\n$x\n" && sleep 5; done; }
tl () { for i in $(ls -r ${2:-/tmp}/$1*.log); do le $i; read -p $i; done; }
tt () { cd ~/tmp${1:+-x} && ll; }
tv () { sudo systemctl start vncserver@:1; }
tx () { bsdtar -tf "$1" | head; read; bsdtar -xvf "$1"; }
ty () { tee /dev/tty; }
up () { uptime | xargs; }
us () { xargs -d '\n' -r du -chsx | sort -h; }
ux () { fd -t f '\.' | sed 's/.*\.//' | sort -u | while read i; do z=$(fd -e $i -t f -X du -ch | tail -1 | cut -f 1); echo -e "$z\t$i"; done | sort -h; while read -p '> ' i; do [ $i ] || break; fd -e $i -t f -X du -ch | sort -h | tail; done; }
vc () { t=/tmp/vc-$(date +%s).${1:-txt} && cb -o > $t && vi $t && cb < $t && rr $t; }
wa () { while eval "$1"; do sleep ${2:-60}; echo; ec -; done; }
wd () { w3m -cols ${2:-80} -dump -O ASCII $1; }
wm () { a=$(eval $1); echo "$a"; b=$a; while true; do sleep $2 || return 1; b=$(eval $1); date; diff <(echo "$a") <(echo "$b") | d2 | ty | ma "$3" -E; a=$b; done; }
wp () { while pgrep -af $1; do sleep 5m; date; done; }
wx () { while read i; do eval $@; done; }
xd () { echo $DISPLAY; read -p '> ' DISPLAY; }
xg () { compgen -c | sort -u | grep $@; }
xt () { sleep 5; xdotool type "$*"; }
xv () { x11vnc -o /tmp/x11vnc.log -display :0 -usepw -wait 100 $@; }
yp () { y=https://www.youtube.com; [ $2 ] && a= b=cat || a=$sp b=tac; curl -s $y/$1 | grep -o '/watch?v=[^"\]*' | sed "s|^|$y|" | $b | yt $a --playlist=-; }
yt () { l=/tmp/mpv-$(date +%s).log; mpv --loop --quiet --ytdl-format=worst $ad $@ &> $l & disown; echo $l; sleep 5; le $l; }

for i in ~/.aliases-*; do . $i; done

eval $(dircolors)
