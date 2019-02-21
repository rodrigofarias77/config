set -C

HISTCONTROL=ignoreboth
HISTFILESIZE=20000
HISTSIZE=10000
HISTTIMEFORMAT='%s '
PROMPT_COMMAND='history -a'
PS1="\[\e]0;\u@\h:\w\a\]\[\e[1;37m\]\u@\h:\w\[\e[0m\]\$ "

jj=cron

alias cp='cp -aiv' la='ls -A' le='less -RSi' ll='la -hl --color=always' ls='ls -N --color=auto' mv='mv -iv'

alias cb="xsel -b"
alias bi="bind -f ~/.inputrc"
alias bt='acpi -b'
alias hh=htop
alias hs='python -m http.server'
alias ia="ip -4 -o a | sed -r 's/^[^ ]* ([^ ]*).*inet ([^/]*).*/\1: \2/'"
alias il="ip -o l | sed -nr 's/^[^ ]* ([^:]*).*ether ([^ ]*).*/\1: \2/p'"
alias io='sudo iotop'
alias lg='la -F | grep'
alias lo="tr A-Z a-z"
alias n1="1> /dev/null"
alias n2="2> /dev/null"
alias nh='unset HISTFILE'
alias nu="> /dev/null 2>&1"
alias oo='nu xdg-open'
alias os='[ $1 = -s ] && s=sudo && shift || s='
alias pc='parallel --will-cite'
alias rl='readlink -f'
alias rm='rm -v'
alias rs='rsync -ahv'
alias ss="sensors coretemp-isa-0000 | sed -n '/^Core/s/  \+/ /gp'"
alias sv='nu ssvncviewer -bgr233 -encodings zrle'
alias sx='sudo xv -auth /run/lightdm/root/:0'
alias ta='n1 tmux -2 new -AD -s 0'
alias tp='tar -x -OP -f'
alias uu='du -hs'
alias vn='vi -i NONE'
alias vr='vi -R'
alias wg='wget -nv --show-progress'
alias wo='wget -q -O -'
alias xd='export DISPLAY=:0'
alias xv='x11vnc -q -cursor arrow -display :0 -usepw'

alias sudo='sudo '

bc () { os; $s rc -p $1 ~/backup; }
bd () { os; $s vi -d $1 ~/backup/$(rl $1 | tr / +); }
ca () { python -c "print($1)"; }
cc () { cut -c -${1:-15} | column -c $(tput cols); }
cl () { cd $(find -maxdepth 1 -type d | sort | tail -1); }
co () { xargs -L 1 | cut -d " " -f $1; }
cw () { wmctrl -c $1; }
cx () { sed "s/\t/  /g" | cut -c -${1:-$COLUMNS}; }
db () { os; $s vi -d $(ls -t $1{,-*} | head -2); }
di () { dict -d wn "$*" | tail -n +5 | paste -s -d '' | sed -r -e 's/ {9,}/ /g' -e 's/ {6}([a-z]+) /\n\n\U\1\n  /g' -e 's/ {6}/\n  /g' | fold -s -w $COLUMNS; }
dp () { os; $s vi -d $2 ${1%/}/$2; }
ds () { vi -d $2 scp://$1/$PWD/$2; }
ec () { head -c ${2:-80} /dev/zero | tr '\0' $1; echo; }
ef () { mq $2 && return; encfs -i 60 ${@:3} $(rl $1) $2; }
er () { [ $1 ] && a="/$1/" || a=0; [ $2 ] && b="/$2/" || b=$; sed -n "$a,${b}p"; }
et () { le $(ls /tmp/$1*log | tail -1); }
ff () { df -Th $@ | tail -n +2 | grep -v tmpfs | sort -k 7 | xargs printf '%-15.15s %-10.10s %5s %5s %5s %5s %s\n'; }
fl () { sudo fdisk -l $@ | cat -s; }
fr () { n2 find $2 -xdev -type f ${@:3} | grep -i "$1" | sed 's:^\./::' | sort; }
fu () { fusermount -u ${2:+-z} /tmp/$1; }
gr () { fr ${3:-.} $2 | xn grep -il "$1"; }
hg () { hi $2 | grep -i $1; }
hl () { grep -E --color "$1|"; }
ho () { sed "s:$HOME:~:"; }
ii () { wo ipinfo.io/$1 && echo; }
im () { mkdir im && cp ${@:3} im && mogrify -quality $1% -resize $2x$2 -verbose ${@:3}; }
jg () { journalctl -n 5000 | grep -i $@ | le +G; }
jj () { journalctl -n 5000 | grep -Eiv "$jj" | le +G; }
jr () { bb -m $1 && jpegtran -copy all -rotate ${2:-90} $1-* > $1 && rr $1-*; }
l2 () { la -F $1 | cc 31; }
lc () { la -F $1 | cc; }
lh () { ll $1 | head -20; }
lt () { ll $1 | tail -20; }
lu () { la -p $@ | us; }
ma () { mail -s "$(hostname -s): $1" ${@:2}; }
mc () { mkdir -p "$1" && cd "$1"; }
mo () { mv "$@" $OLDPWD; }
mq () { mountpoint -q $1 && echo "$1 already mounted"; }
ms () { ma $1 $ma <<< "$? - $PWD"; }
nd () { nu "$@" & disown; }
nn () { n2 sudo nethogs $(ip -o l | cut -d : -f 2 | grep -v lo | head -1); }
om () { sudo chown --reference=$1 ${@:2} && sudo chmod --reference=$1 ${@:2}; }
on () { while eval $([ $4 ] || echo !) nc -w 10 -z $1 $2; do date; sleep ${3:-60}; done; ma on $ma <<< $@; }
pk () { pp $1 | tail -1 | co 2 | xargs -r kill --verbose $2; sleep 1; pp $1; }
pp () { ps -ef --sort=start_time | grep -i ${1:-$^} | grep -v grep; }
ra () { shuf -i ${2:-1}-$1 -n 1; }
rd () { nc -z $1 3389 && n2 zenity --password | nd xfreerdp -grab-keyboard /cert-ignore /dynamic-resolution /from-stdin /u:$2 /v:$1; }
re () { t=/tmp/tr; ef ~/.trash $t && rr -t $t "$@"; }
rf () { find $@ -exec rm -iv {} +; }
ry () { echo -en "${1:-? }"; read r; [ "$r" = y ]; }
sb () { unalias -a; . ~/.bashrc; }
sd () { rs -n --del "$@"; ry && rs --del "$@"; }
sf () { mq $2 && return; mkdir -p $2; sshfs $1 $2 ${@:3}; }
sm () { l=/tmp/sm-$(date +%s).log; rs -n --del "${@:2}"; ry && for i in {1..5}; do rs --del --max-size=1M "${@:2}" && rs -P --del --bwlimit=$1 --log-file=$l "${@:2}" && break || sleep 10m; done; echo -e "${@:2}\n\n--\n$(cat $l)" | ma sync $ma; }
sr () { sed -nr -e 's/.*<title>([^<]*).*/\1/p' -e "/${1:-.}/s/.*(http[^\"<]*).*/  \1/p"; }
td () { d=$(($(date +%s -d "$2")-$(date +%s -d "$1"))); date -d @$d -u +"$((d/86400))d %T"; }
tg () { grep -i $1 $(ls -r ~/trash/*idx) | sed "s/idx:/tar /" | while read t a; do echo $t $a; tar -OPx -f $t "$a" | head -100; echo; ec -; done | le; }
tt () { cd ~/tmp && ll; }
up () { uptime | xargs; }
us () { n2 xn du -chsx | sort -h; }
vc () { t=/tmp/vc-$(date +%s).${1:-txt} && cb -o > $t && vi $t && cb < $t && rr -z $t; }
wa () { while eval $1; do sleep ${2:-60}; echo; ec -; done; }
wd () { w3m -cols ${2:-80} -dump -O ASCII $1; }
wm () { a=$(eval $1); echo "$a"; b=$a; while true; do sleep $2 || return 1; b=$(eval $1); date; diff <(echo "$a") <(echo "$b") | sed -n "s/^> //p" | tee -a /dev/tty | ma $3 -E $ma; a=$b; done; }
xg () { compgen -c | sort -u | grep $@; }
xn () { xargs -d "\n" "$@"; }

for i in ~/.aliases-*; do . $i; done

eval $(dircolors)
