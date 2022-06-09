#!/bin/env bash
# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.

[ -x /snap/bin/nvim ] && alias nvim=/snap/bin/nvim && alias vui="nvim-qt --nvim /snap/bin/nvim"
