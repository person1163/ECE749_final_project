rm *.ucdb
make cli TEST_NAME=test_top CODE_COVERAGE_ENABLE=1 UVM_VERBOSITY=UVM_LOW BATCH_DO_COMMANDS='-do "set NoQuitOnFinish 1; run -all; coverage attribute -name TESTNAME -value $(TEST_NAME).$(TEST_SEED); coverage save $(TEST_NAME).$(TEST_SEED).ucdb; quit -f"'
cp transcript transcript_test_top
make merge_coverage
make view_coverage