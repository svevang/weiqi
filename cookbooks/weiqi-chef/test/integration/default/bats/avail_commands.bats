#!/usr/bin/env bats

@test "mocha binary is found in PATH" {
  run bash -c "find ~/.nvm | grep bin\/mocha"
  [ "$status" -eq 0 ]
}

