#!/bin/bash
#
# common functions

function test_curl() {
    ip=$1
    ssh_command="$2"
    expected="$3"
    elapsed=0
    total=660; # 11 min
    let "begin = $(date +%s)"
    while (( $total > $elapsed)); do
        if contents="$($ssh_command curl -s $ip)"; then
            if [ "x$contents" = "x$expected" ]; then
              return 0
            else
              echo FAIL did not get expected content
              echo expected: $expected
              echo actual  : $contents
              return 1
            fi
        fi
        # while loop end:
        sleep 10
        let "elapsed = $(date +%s) - $begin"
        echo $elapsed of $total have elapsed, try again...
    done
    return 1
}