class decode_in_coverage extends uvm_subscriber#(decode_in_transaction);
    `uvm_component_utils(decode_in_coverage)

    decode_in_configuration configuration;
    decode_in_transaction opc;

    covergroup decode_in_cg ;
        option.per_instance = 1;
        option.name = get_full_name();

        decode_in_op: coverpoint opc.opcode{
            bins ADD_bin = {4'b0001};
            bins AND_bin = {4'b0101};
            bins NOT_bin = {4'b1001};
            bins LD_bin  = {4'b0010};
            bins LDR_bin = {4'b0110};
            bins LDI_bin = {4'b1010};
            bins LEA_bin = {4'b1110};
            bins ST_bin  = {4'b0011};
            bins STR_bin = {4'b0111};
            bins STI_bin = {4'b1011};
            bins BR_bin  = {4'b0000};
            bins JMP_bin = {4'b1100};
        }
    endgroup

    function new(string name = "", uvm_component parent = null); 
        super.new(name, parent);
        decode_in_cg = new();
    endfunction

    virtual function void write(decode_in_transaction t);
        opc= t;
        decode_in_cg.sample();
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    function void set_configuration(decode_in_configuration cfg);
        configuration = cfg;
    endfunction
endclass
