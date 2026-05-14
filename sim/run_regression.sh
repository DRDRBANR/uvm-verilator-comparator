#!/bin/bash
TESTS=("base_test")
ERRORS=0
SUCCESS=0

echo "=== Starting UVM Regression ==="
for test in "${TESTS[@]}"; do
    echo "-> Running $test..."
    make run_test TEST=$test > "${test}.log" 2>&1
    if [ $? -eq 0 ]; then
        echo "   [PASSED]"
        SUCCESS=$((SUCCESS + 1))
    else
        echo "   [FAILED] - Check ${test}.log"
        ERRORS=$((ERRORS + 1))
    fi
done

echo "Passed: $SUCCESS | Failed: $ERRORS"
if [ $ERRORS -gt 0 ]; then exit 1; fi
exit 0
