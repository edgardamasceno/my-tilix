#!/bin/bash

# Tilix
sudo add-apt-repository ppa:webupd8team/terminix -y
sudo apt install tilix

# VTE configuration fix
FILE=/etc/profile.d/vte.sh
if [ ! -f "$FILE" ]; then
    ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
fi

write_rc () {
   echo -e "\n# VTE Configuration Fix for Tilix\nif [ \$TILIX_ID ] || [ \$VTE_VERSION ]; then\n\tsource /etc/profile.d/vte.sh\nfi" >> ~/$1
}

write_rc .bashrc
write_rc .zshrc

# Tilix themes
DIR=/etc/profile.d/vte.sh
if [ ! -d "$DIR" ]; then
    mkdir -p ~/.config/tilix/schemes/
    THEMES=/tmp/tilix-themes
   if [ ! -d "$THEMES" ]; then
      git clone https://github.com/storm119/Tilix-Themes.git /tmp/tilix-themes
      mv /tmp/tilix-themes/Themes/* ~/.config/tilix/schemes/   
   fi
fi

# Restore my personal configuration
curl -s https://raw.githubusercontent.com/edgardamasceno/my-tilix/master/tilix.dconf | dconf load /com/gexperts/Tilix/