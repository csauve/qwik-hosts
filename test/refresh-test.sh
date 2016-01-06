source test/common.sh

describe "Write the master hosts file"

before() {
  backup_qwikrc
  create_test_qwikrc
  ./qwik init
  ./qwik add host1
}

it_refreshes() {
  ./qwik enable host1
  ./qwik refresh
  [ -f "./test-hosts/hosts" ]
  grep -q 'WARNING: This file was automatically generated using qwik-hosts.' "./test-hosts/hosts"
  grep -q '127.0.0.1       localhost' "./test-hosts/hosts"
  grep -q '255.255.255.255 broadcasthost' "./test-hosts/hosts"
  grep -q '::1             localhost' "./test-hosts/hosts"
  grep -q 'fe80::1%lo0     localhost' "./test-hosts/hosts"
  grep -q '# host1' "./test-hosts/hosts"
}

after() {
  rm -rf "./test-hosts"
  restore_qwikrc
}
