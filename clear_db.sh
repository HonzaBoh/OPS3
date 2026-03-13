#!/bin/bash

CONF="/etc/mysql/my.cnf"

if [ ! -f "$CONF" ]; then
    echo "ERROR: $CONF not found."
    exit 1
fi

if grep -q "bind-address *= *0.0.0.0" "$CONF" || grep -q "^\[mysqld\]" "$CONF"; then
    sudo sed -i '/bind-address *= *0.0.0.0/d' "$CONF"
    sudo sed -i '/^\[mysqld\]/d' "$CONF"

    echo "Conf removed."
else
    echo "No conf changes necessary."
fi

sudo systemctl restart mysql 2>/dev/null
sudo systemctl stop mysql 2>/dev/null

echo "Done."