#!/bin/bash
# secure shared memory
echo "tmpfs /dev/shm tmpfs defaults,noexec,nosuid 0 0" >> /etc/ftab
