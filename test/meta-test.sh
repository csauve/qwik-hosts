source test/common.sh

describe "Meta functions and information"

it_shows_version_info() {
  version_info=$(./qwik --version)
  echo $version_info | grep -qE 'qwik-hosts version \d\.\d\.\d' 
  echo $version_info | grep -q  'https://github.com/RichardSchmitz/qwik-hosts'
}

it_shows_help_text() {
  help_text=$(./qwik --help)
  echo $help_text | grep -q 'Usage:' 
  echo $help_text | grep -q 'qwik init' 
  echo $help_text | grep -q 'qwik add' 
  echo $help_text | grep -q 'qwik remove' 
  echo $help_text | grep -q 'qwik edit' 
  echo $help_text | grep -q 'qwik show' 
  echo $help_text | grep -q 'qwik enable' 
  echo $help_text | grep -q 'qwik disable' 
  echo $help_text | grep -q 'sudo qwik refresh' 
  echo $help_text | grep -q 'qwik list' 
  echo $help_text | grep -q 'qwik --version' 
  echo $help_text | grep -q 'qwik --help' 
}
