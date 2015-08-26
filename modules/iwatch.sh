#!/bin/bash
# Dependencies
sudo aptitude install iwatch -y






IWATCH(1)                   General Commands Manual                  IWATCH(1)



NAME
       iwatch  - a realtime filesystem monitor / monitor any changes in direc‐
       tories/files specified

SYNOPSIS
       iwatch [options]

DESCRIPTION
       This manual page documents briefly the iwatch  command.   iWatch  is  a
       realtime  filesystem  monitoring  program. It's a simple perl script to
       monitor changes in specific directories/files and send email  notifica‐
       tion  immediately.  It reads the dir/file list from xml config file and
       needs inotify support in kernel (Linux Kernel >= 2.6.13).

OPTIONS
       Usage for daemon mode of iWatch:

       iwatch [-d] [-f <config file>] [-v] [-p <pid file>]

       In the daemon mode iWatch has the following options:

       -d     Execute the application as daemon. iWatch will run in  foregroud
              without this option.

       -f <configfile.xml>
              Specify    alternative    configuration    file.    Default   is
              /etc/iwatch/iwatch.xml.

       -p <pidfile>
              Specify an alternate pid file (default: /var/run/iwatch.pid)

       -v     Be verbose.

       Usage for command line mode of iWatch:

       iwatch [-c command]  [-e  event[,event[,..]]]  [-h|--help]  [-m  <email
       address>]  [-r] [-s <on|off>] [-t <filter string>] [-v] [--version] [-x
       exception] [-X <regex string as exception>] <target>

       In the command line mode iWatch has the following options:

       -c <command>
              You can specify a command to be executed if an event occurs. For
              details    about    the   string   format   take   a   look   at
              /usr/share/doc/iwatch/README.gz.

       -C <charset>
              Specify the charset (default is utf-8).

       -e <event[,event[,..]]>
              Events list. For details about possible events take  a  look  at
              /usr/share/doc/iwatch/README.gz.

       -h, --help
              Print help message.

       -m <emailaddress>
              Contact  point's email address. Without this option, iwatch will
              not send any email notification (obviously).

       -r     Recursivity of the watched directory.

       -s on|off
              Enable or disable reports to the  syslog  (default  is  off/dis‐
              abled).

       -t <filter>
              Filter  string (regex) to compare with the filename or directory
              name.

       -x <exception file or directory>
              Specify the file or directory which should not be watched.

       -X <regex string as exception>
              Specify a regex string as exception.

USAGE EXAMPLES
       % iwatch /tmp
              Monitor changes in /tmp directory with default events.

       % iwatch -r -e access,create -m root@localhost -x /etc/mail /etc
              Monitor only access and create events in /etc  directory  recur‐
              sively  with  /etc/mail as exception and send email notification
              to cahya@localhost.

       % iwatch -r -c (w;ps -ef)|mail -s '%f was changed' root@localhost /bin
              Monitor /bin directory recursively and execute the command.

       % iwatch -r -X '.svn' ~/projects
              Monitor ~/projects directory recursively, but exclude  any  .svn
              directories inside. This can't be done with a normal '-x' option
              since '-x' can only exclude the defined path.

AUTHOR
       iwatch was written by Cahya Wirawan <cahya@gmx.at>.

       This manual page was written by Michael  Prokop  <mika@debian.org>  for
       the Debian project (but may be used by others).



                                                                     IWATCH(1)
