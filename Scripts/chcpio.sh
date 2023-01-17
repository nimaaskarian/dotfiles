#!/bin/bash

sudo mv "$HOME/.cache/wal/vconsole.conf" /etc/vconsole.conf
sudo mkinitcpio -P
