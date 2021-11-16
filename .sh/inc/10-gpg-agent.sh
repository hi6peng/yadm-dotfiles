########################################
# Set things up for using gpg-agent

export GPG_TTY=$(tty)

function use-gpg-agent-for-ssh {
    SOCK="$( gpgconf --list-dirs agent-ssh-socket )"
    if [[ -n "${SOCK:-}" ]]
    then
        unset SSH_AGENT_PID
        export SSH_AUTH_SOCK="$SOCK"
    fi
}

#use-gpg-agent-for-ssh
