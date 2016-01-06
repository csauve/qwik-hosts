source test/common.sh

describe "Current host configuration state"

before() {
  backup_qwikrc
  create_test_qwikrc
  ./qwik init
  ./qwik add host1
}

it_lists_current_state() {
  ./qwik list | grep -qE '_default.+enabled'
  ./qwik list | grep -qE 'host1.+disabled'
}

it_enables_and_disables_hosts() {
  [ ! -h "./test-hosts/hosts-enabled/host1" ]
  ./qwik enable host1
  [ -h "./test-hosts/hosts-enabled/host1" ]
  ./qwik disable host1
  [ ! -h "./test-hosts/hosts-enabled/host1" ]
}

after() {
  rm -rf "./test-hosts"
  restore_qwikrc
}
