if [ -n "$GUIX_ENVIRONMENT" ]
then
    export PS1="\u@\h \w [dev]\$ "
fi

# Load the default Guix profile
GUIX_PROFILE="$HOME/.guix-profile"
if [ -f "$GUIX_PROFILE"/etc/profile ]; then
  . "$GUIX_PROFILE"/etc/profile
fi

# Load common user Guix profile
GUIX_PROFILE="$HOME/.config/guix/current"
if [ -f "$GUIX_PROFILE"/etc/profile ]; then
    . "$GUIX_PROFILE"/etc/profile
fi

# Load additional Guix profiles
GUIX_EXTRA_PROFILES=$HOME/.guix-extra-profiles
if [ -d "$profile"/etc/profile ]; then
    for i in $GUIX_EXTRA_PROFILES/*; do
    profile=$i/$(basename "$i")
    if [ -f "$profile"/etc/profile ]; then
	GUIX_PROFILE="$profile"
	. "$GUIX_PROFILE"/etc/profile
    fi
    unset profile
    done
fi

# Load Nix environment
if [ -f /run/current-system/profile/etc/profile.d/nix.sh ]; then
  . /run/current-system/profile/etc/profile.d/nix.sh
fi

export GUIX_LOCPATH=$HOME/.config/guix/current/lib/locale

# Make applications in other profiles visible to launcher
export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.guix-extra-profiles/music/music/share"
export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.guix-extra-profiles/video/video/share"
export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.guix-extra-profiles/browsers/browsers/share"
