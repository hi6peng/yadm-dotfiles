# {{{ terminal

# use-gpg-agent-for-ssh
########################################
# Set things up for using gpg-agent

export GPG_TTY=$(tty)
alias gpg=gpg2

function use-gpg-agent-for-ssh {
  SOCK="$( gpgconf --list-dirs agent-ssh-socket )"
  if [[ -n "${SOCK:-}" ]]
  then
    unset SSH_AGENT_PID
    export SSH_AUTH_SOCK="$SOCK"
  fi
}

#use-gpg-agent-for-ssh

# }}}

# vim:filetype=sh:tabstop=2:shiftwidth=2:fdm=marker:
