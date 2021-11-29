#xset r rate 200 60
#xsetroot -cursor_name left_ptr

export LANG=en_US.utf-8
export LC_COLLATE="en_US.UTF-8"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

xmodmap ~/.scratch.emacs.d/exwm/Xmodmap
#xrdb ~/.scratch.emacs.d/exwm/Xresources
compton &
# xss-lock -- slock &
feh --bg-scale "/home/vagrant/.dotfiles/backgrounds/mountains-1412683.jpg"
# polybar &
#exec dbus-launch --exit-with-session ~/.dotfiles/.bin/update-screens &
#exec dbus-launch --exit-with-session emacs -l ~/.dotfiles/.guix.emacs.d/lisp/dw-desktop.el
# urxvt
exec i3

# sky-1920x1080-4k-5k-wallpaper-8k-stars-mountains-night-5708.jpg
# macos-catalina-1920x1080-night-mountains-wwdc-2019-5k-21589.jpg
# macos-catalina-1920x1080-day-mountains-wwdc-2019-5k-21590.jpg
# space-1920x1080-8k-wallpaper-lava-4k-5k-live-wallpaper-android-12769.jpg
