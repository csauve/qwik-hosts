#!/usr/bin/env bash

backup_qwikrc() {
  if [ -f "$HOME/.qwikrc" ]; then
    cp -i "$HOME/.qwikrc" "$HOME/.qwikrc.backup"
  fi
}

create_test_qwikrc() {
 cat > "$HOME/.qwikrc" << EOM
# This is a qwikrc used by qwik-hosts for testing.
# It can be safely deleted.
DIR_QWIK="\$(pwd)/test-hosts"
HOSTS_FILE="\$DIR_QWIK/hosts"
EDITOR=vim
EOM
}

restore_qwikrc() {
  rm -f "$HOME/.qwikrc"
  if [ -f "$HOME/.qwikrc.backup" ]; then
    mv -f "$HOME/.qwikrc.backup" "$HOME/.qwikrc"
  fi
}
