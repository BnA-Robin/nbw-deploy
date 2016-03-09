#!/bin/bash -x
ip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
host=$(hostname)
nick=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 6 | head -n 1)
rsync="rsync://$ip/new_lists"
(
echo NICK $nick
echo USER $nick 8 * : Notifier
sleep 1
echo 'JOIN #nbw-announce'
echo 'PRIVMSG #nbw-announce ' $rsync
echo 'PART #nbw-announce'
echo QUIT
) | nc irc.freenode.net 6667

