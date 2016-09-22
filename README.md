# applehosts
This script was put together in response to a group of users testing web applications on Dev servers using internal DNS and based on studying various other, similar scripts to programatically change hosts files. Its combination of the three methods to list, add and remove the hosts file entries is designed to enable users to simply manipulate the Mac's hosts file without escalating their user to admin status. To understand the options, run the script without any parameters.

There are four parts to the use of this script:

First, gitclone or download and locate the script in suitable location where it can be obfuscated to avoid user attention but still be accessed by all. You could just as easily put it in your user home folder if that suits but I have successfully located it in /usr/local/bin/applehosts for use by any Mac user.

Second, we have to make the script executable. In that simple, single user instance where we copy the script to anywhere in the user home folder we can do something like: chmod a+x /pathto/change-hosts.sh. If we want to make this more useful to all the users of this machine and we have placed it in the /usr/local/bin/ folder for example, we could try: sudo chmod 0111 /pathto/change-hosts.sh.

Third, check that the script defaults are suitable and applicable to your use case by editing the file in your favourite editor, something like: sudo nano /pathto/change-hosts.sh. The three options provided are for the location of the hosts file, the default IP and the default name as shown below.

```
HOSTS="/etc/hosts"
DEFAULT_IP=127.0.0.1
IP=${2:-$DEFAULT_IP}
DEFAULT_HOSTNAME="localhost"
HOSTNAME=${3:-$DEFAULT_HOSTNAME}
```

Fourth, we have to enable a user or groups of users rights to run this script as sudo. They may not be admin users so we need to enable the correct permissions in the sudoers file. Open the file in your favourite editor, something like: sudo /etc/sudoers. Find the section below and add the highlighted line. 

```
##
## User privilege specification
##
root ALL=(ALL) ALL
%admin  ALL=(ALL) ALL

## Uncomment to allow members of group wheel to execute any command
# %wheel ALL=(ALL) ALL

## Same thing without a password
# %wheel ALL=(ALL) NOPASSWD: ALL
mytrusteduser ALL=(root) NOPASSWD: /pathto/change-hosts.sh
```

Note that we are allowing mytrusteduser to run this script (and this script only) as root without using a password. You can find other variations of this but this example suits my purpose.

Now mytrusteruser can open a terminal window and run the script: sudo /pathto/change-hosts.sh list. Note that sudo is a required prefix for the remove method which uses sed commands but if you applied the chmod 0111 permissions then sudo is required to run any of the script methods.

