#!/usr/bin/env bash
#                                      __   
#   ___ ____ ___ _  ___ __ _  ___  ___/ /__ 
#  / _ `/ _ `/  ' \/ -_)  ' \/ _ \/ _  / -_)
#  \_, /\_,_/_/_/_/\__/_/_/_/\___/\_,_/\__/ 
# /___/                                     
# 


project_cache_folder="$HOME/.cache/hyprland-dotfiles"
gamemode_monitor="$HOME/.config/hypr/conf/monitors/gamemode.conf"

# Notifications
source "$HOME/.config/hypr/scripts/notification-handler.sh"
APP_NAME="System"
NOTIFICATION_ICON="joystick"


if [ -f $HOME/.config/hypr/settings/gamemode-enabled ]; then
  if [ -f $project_cache_folder/last_monitor.conf ]; then
    cat $project_cache_folder/last_monitor.conf > $HOME/.config/hypr/conf/monitor.conf
    rm $project_cache_folder/last_monitor.conf
  fi
  if [ -f $project_cache_folder/restart-wpauto ]; then
    rm $project_cache_folder/restart-wpauto
    $HOME/.config/hypr/scripts/wallpaper-automation.sh &
  fi
  hyprctl reload
  rm $HOME/.config/hypr/settings/gamemode-enabled
  notify_user --a "${APP_NAME}" \
            --i "${NOTIFICATION_ICON}" \
            --s "Gamemode deactivated" \
            --m "Animations and blur are now enabled."
else
  if [ -f $gamemode_monitor ]; then
    cat $HOME/.config/hypr/conf/monitor.conf > $project_cache_folder/last_monitor.conf
    echo "source = $gamemode_monitor" > $HOME/.config/hypr/conf/monitor.conf
  fi
  if [ -f $project_cache_folder/wallpaper-automation ]; then
    touch $project_cache_folder/restart-wpauto
    $HOME/.config/hypr/scripts/wallpaper-automation.sh
  fi
  hyprctl --batch "\
    keyword animations:enabled 0;\
    keyword decoration:shadow:enabled 0;\
    keyword decoration:blur:enabled 0;\
    keyword general:gaps_in 0;\
    keyword general:gaps_out 0;\
    keyword general:border_size 1;\
    keyword decoration:active_opacity 1;\
    keyword decoration:inactive_opacity 1;\
    keyword decoration:fullscreen_opacity 1;\
    keyword decoration:rounding 0"
  touch $HOME/.config/hypr/settings/gamemode-enabled
  notify_user --a "${APP_NAME}" \
          --i "${NOTIFICATION_ICON}" \
          --s "Gamemode activated" \
          --m "Animations and blur are now disabled."
fi