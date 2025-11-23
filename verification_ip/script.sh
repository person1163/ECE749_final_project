#!/bin/bash

# Run yaml2uvmf.py
python "/Users/vaibhavtahiliani/Desktop/vtahili_p2 2/project_benches/UVMF_2023.4_2/scripts/yaml2uvmf.py" \
    lc3_bench.yaml \
    lc3_environment.yaml \
    imem_interface.yaml \
    dmem_interface.yaml \
    fetch_in_interface.yaml \
    fetch_out_interface.yaml \
    fetch_util_comp_fetch_predictor.yaml \
    fetch_environment.yaml \
    control_in_interface.yaml \
    control_out_interface.yaml \
    control_util_comp_control_predictor.yaml \
    control_environment.yaml \
    memaccess_in_interface.yaml \
    memaccess_out_interface.yaml \
    memaccess_util_comp_memaccess_predictor.yaml \
    memaccess_environment.yaml \

