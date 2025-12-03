rm *.ucdb
module load questa
make clean
make cli TEST_NAME=test_top TEST_SEED=2900320262
make view_coverage