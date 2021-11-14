# {{{ appendpath

# Append our default paths
appendpath () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

# }}}

# vim:filetype=sh:tabstop=2:shiftwidth=2:fdm=marker:
