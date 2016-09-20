#! /bin/sh
# @author: Harry Thompson
# July 2016
# script for making changes to hosts file on Mac

HOSTS="/etc/hosts"
DEFAULT_IP=127.0.0.1
IP=${2:-$DEFAULT_IP}
DEFAULT_HOSTNAME="localhost"
HOSTNAME=${3:-$DEFAULT_HOSTNAME}

case "$1" in
  list)
        cat $HOSTS
        exit 2
        ;;
  add)
        echo "adding $IP $HOSTNAME to $HOSTS";
        echo "$IP $HOSTNAME"  >> $HOSTS
        ;;
  remove)
        echo "removing $IP $HOSTNAME from $HOSTS";
        sed -ie "\|^$IP $HOSTNAME\$|d" $HOSTS
        ;;
  *)
        echo
        echo "======================================================="
        echo "script to make changes to a hosts file"
        echo
        echo "usage: "
        echo "sudo change-hosts.sh [list|add|remove] [ip] [hostname]"
        echo
        echo "defaults:"
        echo "ip defaults to 127.0.0.1"
        echo "hostname defaults to localhost"
        echo
        echo "examples:"
        echo "hosts.sh list"
        echo "hosts.sh add testing.com"
        echo "hosts.sh remove 192.168.1.1 testing.com"
        echo
        echo "list and add will work with normal user permissions but"
        echo "remove requires sudo. Add the following line to an"
        echo "apropriate place in your sudoers file to enable sudo"
        echo "control without need for a password:"
        echo "sudouser ALL=(root) NOPASSWD: /path/to/change-hosts.sh"
        echo "======================================================="
        echo
        exit 1
        ;;
esac

echo "finished"

exit 0
