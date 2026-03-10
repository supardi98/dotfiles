#!/bin/bash
clear
cat <<"EOF"
   ___          __
  / _ \___ ___ / /____  _______
 / , _/ -_|_-</ __/ _ \/ __/ -_)
/_/|_|\__/___/\__/\___/_/  \__/

EOF
echo "You can restore to the default ML4W variations."
echo "PLEASE NOTE: You can reactivate to a customized variation or selection in the settings script."
echo "Your customized variation will not be overwritten or deleted."

if gum confirm "Do you want to restore all variations to the default values?"; then
    echo

    echo "source = /home/supardi/Projects/ricing/conf/keybindings/default.conf" >/home/supardi/Projects/ricing/conf/keybinding.conf
    echo "Hyprland keybinding.conf restored!"

    echo "source = /home/supardi/Projects/ricing/conf/environments/default.conf" >/home/supardi/Projects/ricing/conf/environment.conf
    echo "Hyprland environment.conf restored!"

    echo "source = /home/supardi/Projects/ricing/conf/windowrules/default.conf" >/home/supardi/Projects/ricing/conf/windowrule.conf
    echo "Hyprland windowrule.conf restored!"

    echo "source = /home/supardi/Projects/ricing/conf/animations/default.conf" >/home/supardi/Projects/ricing/conf/animation.conf
    echo "Hyprland animation.conf restored!"

    echo "source = /home/supardi/Projects/ricing/conf/decorations/default.conf" >/home/supardi/Projects/ricing/conf/decoration.conf
    echo "Hyprland decoration.conf restored!"

    echo "source = /home/supardi/Projects/ricing/conf/windows/default.conf" >/home/supardi/Projects/ricing/conf/window.conf
    echo "Hyprland window.conf restored!"

    echo "source = /home/supardi/Projects/ricing/conf/monitors/default.conf" >/home/supardi/Projects/ricing/conf/monitor.conf
    echo "Hyprland monitor.conf restored!"

    echo
    echo ":: Restore done!"
else
    echo ":: Restore canceled!"
    exit
fi
