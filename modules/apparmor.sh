#!/bin/bash
aptitude install -y apparmor
aptitude install -y apparmor-profiles
apparmor_status
