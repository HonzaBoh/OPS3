NEWUSER=<your_username>
useradd --create-home --shell /usr/bin/bash --user-group --groups  adm,dialout,cdrom,floppy,sudo,audio,dip,video,plugdev,netdev --password $(read -sp Password: pw ; echo $pw | openssl passwd -1 -stdin) $NEWUSER
