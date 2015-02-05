#!/usr/bin/env bats
#
# An example bats test

@test "git binary is found in PATH" {
  run which git
  [ "$status" -eq 0 ]
}

