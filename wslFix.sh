#!/bin/bash
USERNAME=$1
useradd -m -G sudo,adm,netdev,dialout,plugdev $1
