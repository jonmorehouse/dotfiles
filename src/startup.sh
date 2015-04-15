# startup commands to be run on every new shell or reload
if (( $+commands[keychain] )); then
  # start a new gpg-agent for this process
  eval `keychain --eval -q --agents gpg`
  export GPG_PID=`echo $GPG_AGENT_INFO | awk '{ split($0,a,":"); print a[2] }'`
  
  # handle gpg_processes
  gpg_file="/tmp/gpg_agents"

  # now store this current tty/pid in /tmp/gpg_agents
  echo "$(tty) $GPG_PID" >> $gpg_file

  # export GPG_TTY so that this tty is used here locally
  export GPG_TTY=$(tty)

  # update pinentry tty to use current tty
  echo UPDATESTARTUPTTY | gpg-connect-agent >> /dev/null

  # run gpg-bootstrap if we have a .passphrase file
  if [[ -f $HOME/.passphrase ]]; then 
      $DOTFILES_DIR/scripts/gpg-bootstrap 2>&1 > /dev/null
  fi
fi

if (( $+commands[rbenv] ));then
  eval "$(rbenv init -)"
fi

if (( $+commands[chruby-exec] )); then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  RUBIES+=(
    /usr/local/bin/ruby
  )
fi

if (( $+commands[pro] ));then
  # pro cd function
  pcd() {
    local projDir=$(pro search $1)
    cd ${projDir}
  }
fi

if (( $+commands[goop] ));then
  if [[ -f ./Goopfile ]]; then
    eval `goop env` 
  fi
fi

if [[ $(type load) =~ ".*function$" && -f .env ]];then
  load .env 2&> /dev/null
fi
