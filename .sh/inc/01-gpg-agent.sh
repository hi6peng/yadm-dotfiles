# {{{ terminal

# use_gpg_agent_for_ssh
########################################
# Set things up for using gpg-agent

export GPG_TTY=$(tty)
if command -v gpg2 >/dev/null 2>&1; then
  alias gpg=gpg2
fi

use_gpg_agent_for_ssh() {
  SOCK="$( gpgconf --list-dirs agent-ssh-socket )"
  if [[ -n "${SOCK:-}" ]]
  then
    unset SSH_AGENT_PID
    export SSH_AUTH_SOCK="$SOCK"
  fi
}

#use_gpg_agent_for_ssh

# }}}

# vim:filetype=sh:tabstop=2:shiftwidth=2:fdm=marker:
