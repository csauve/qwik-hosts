source test/common.sh

describe "Filesystem operations on host modules"

before() {
  backup_qwikrc
  create_test_qwikrc
  ./qwik init
}

it_creates_directories_and_default_host() {
  [ -d "./test-hosts" ] && [ -d "./test-hosts/hosts-available" ] && [ -d "test-hosts/hosts-enabled" ]
  [ -f "./test-hosts/hosts-available/_default" ] && [ -h "./test-hosts/hosts-enabled/_default" ]
  grep -q '127.0.0.1       localhost' "./test-hosts/hosts-available/_default"
  grep -q '255.255.255.255 broadcasthost' "./test-hosts/hosts-available/_default"
  grep -q '::1             localhost' "./test-hosts/hosts-available/_default"
  grep -q 'fe80::1%lo0     localhost' "./test-hosts/hosts-available/_default"
}

it_creates_new_host() {
  # Add a new host
  ./qwik add host1
  [ -f "./test-hosts/hosts-available/host1" ]
  grep -q '# host1' "./test-hosts/hosts-available/host1"

  # Can't add a host if it already exists
  status=$(set +e ; ./qwik add host1 >/dev/null ; echo $?)
  [ 2 -eq $status ]
}

it_removes_a_host() {
  # Add a new host and then remove it
  ./qwik add host2
  [ -f "./test-hosts/hosts-available/host2" ]
  ./qwik remove host2 <<< yes
  [ ! -f "./test-hosts/hosts-available/host2" ]
}

it_shows_a_host() {
  ./qwik add host3
  ./qwik show host3 | grep -q '# host3'
}

after() {
  rm -rf "./test-hosts"
  restore_qwikrc
}
