#!/bin/bash

# Tilix
sudo add-apt-repository ppa:webupd8team/terminix -y
sudo apt install tilix

# VTE Configuration Fix
ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
write_rc () {
   echo -e "\n# VTE Configuration Fix for Tilix\nif [ \$TILIX_ID ] || [ \$VTE_VERSION ]; then\n\tsource /etc/profile.d/vte.sh\nfi" >> ~/$1
}

write_rc .bashrc
write_rc .zshrc

# Tilix Themes
mkdir -p ~/.config/tilix/schemes/
git clone https://github.com/storm119/Tilix-Themes.git /tmp/tilix-themes
mv /tmp/tilix-themes/Themes/* ~/.config/tilix/schemes/