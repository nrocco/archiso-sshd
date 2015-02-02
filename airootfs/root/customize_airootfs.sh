#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/
chmod 700 /root

mkdir -p /root/.ssh
chmod 700 /root/.ssh

cat <<EOF > /root/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAl706TkY3Hz1EGuHk+07qJFysuaSmvjsS8MtSVmPnfC/gFXwkXRmGNURpMs2zfp0I2m8hjoVDoeooXR/6itmHTeH3a0J1hVcE9bqEIaTa8j1hbPZT65zqxqAS+N1yCyVMQ5kxw+PvGyeEYqUzlwosXWbxdoGxw+sLqGrtcms9hm0= n.dirocco@tech.leaseweb.com
ssh-dss AAAAB3NzaC1kc3MAAACBAJx8smUiRbZi6J72NxHKhCEvVcdhuzCbd8Sa+igrvR1fBkCHTMGTJS2HivfjoYkJwuTTSys63NgfopHB/Lx+VRSaCxJSRYvtJZsXej8Qfct8nDPv253jiumXqSjyF/JTw5hUBJj09pQbspAIMS1egdXyPfVtcbjO1lFpeUygk8DTAAAAFQCXk3+QAmG2lYGRBIs5Nfu75PXKfQAAAIBZ53pR05Zgkf+pallJRKOXahrQ+3/myPYtFdT4NA/FAiH5+CqJf93NUK+wu5f3F/C5ajKUOKCgiw0dsX+XneatWXW9cDuF0sxL+yQovdonfgx9uyqsaXSoK7mJHDICEw42PnRMDM1g9eEZwjrei0LEVe+yfLEieo9g/sILoL5q9AAAAIArzRkgo3XT7+dK3ikOcQ0ZRLTlbnNUh+xuZo4S72vWyQd6VW0qjiu1u6vKU7KaevjoBJYI+Fc20uHNNu5jGCVRggNnKlA9DXSXS3E+RVYfv0fM6bGohYOfkIUZxOIivcKHbIGhf+8Y/1VL6kPdu8JuVoIRYJjMjcfOzaIwXaWiHg== dirocco.nico@gmail.com
EOF
chmod 600 /root/.ssh/authorized_keys

echo 'root:ThisIsSoVerySecret123' | chpasswd

useradd -m -p "" -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /usr/bin/zsh arch || true

chmod 750 /etc/sudoers.d
chmod 440 /etc/sudoers.d/g_wheel

sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

systemctl enable pacman-init.service choose-mirror.service
systemctl set-default multi-user.target
