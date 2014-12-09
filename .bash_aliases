alias kido="cd /home/rmongia/kido"
alias bin="cd $HOME/kido/build"
alias cf="find . -iname \"*.c\" -o -iname \"*.cpp\" -o -iname \"*.h\" -o -iname \"*.hpp\" > cscope.files"
alias cs='cscope -b -i cscope.files -f cscope.out'
alias tagify="ctags -L cscope.files"
alias nmrestart="pkill nm-applet && nohup nm-applet &"
alias vpnstop="sudo service openvpn stop"
alias vpnstart="sudo service openvpn start"
alias vg="/usr/bin/valgrind --leak-check=no --show-reachable=no --workaround-gcc296-bugs=yes --num-callers=50 --suppressions=/home/rmongia/kido/cmake/instart.supp"
alias gg="git grep"

alias mj='make -j 6 -l 3'
alias dmj='make -j 20'
alias pmj='distcc-pump make -j15'

# To make autocomplete work with aliases
complete -F _make mj
complete -F _make pmj
complete -F _make dmj

if [ $HOSTNAME != "rmongia-desktop" ]; then
 alias cp=gcp
 alias d="ssh rmongia-desktop"
fi
