# fnm
case ":${PATH}:" in
    *:"$HOME/.fnm":*)
        ;;
    *)
        export PATH="$HOME/.fnm:$PATH"
        eval "`fnm env`"
        ;;
esac
