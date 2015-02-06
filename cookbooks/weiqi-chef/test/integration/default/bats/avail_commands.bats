#!/usr/bin/env bats

@test "mocha binary is found in PATH" {
  run sudo bash -i -l -c "node --version"
  # it's the second line of output after the nvm "using version" notice
  [ "${lines[1]}" = "v0.10.36" ]
}

