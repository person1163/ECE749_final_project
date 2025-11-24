//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records imem transaction information using
//       a covergroup named imem_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_transaction_coverage  extends uvm_subscriber #(.T(imem_transaction ));

`uvm_component_utils( imem_transaction_coverage )

T coverage_trans;
//bit [3:0] instruction_dout;

// pragma uvmf custom class_item_additional begin
// pragma uvmf custom class_item_additional end

// ****************************************************************************
covergroup imem_transaction_cg;
  // pragma uvmf custom covergroup begin
  // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
  option.auto_bin_max=1024;
  option.per_instance=1;

 PC: coverpoint coverage_trans.PC
  {
    bins PC_random = {[0:$]};
  }	
  instrmem_rd: coverpoint coverage_trans.instrmem_rd;
  complete_instr: coverpoint coverage_trans.complete_instr;
  // pragma uvmf custom covergroup end
endgroup

covergroup arithmetic_operation;

// Opcodes for specific arithmetic operations
alu_not_opcode: coverpoint coverage_trans.Instr_dout[15:12] {
  bins op_not = {4'h9};
}

alu_and_opcode: coverpoint coverage_trans.Instr_dout[15:12] {
  bins op_and = {4'h5};
}

alu_add_opcode: coverpoint coverage_trans.Instr_dout[15:12] {
  bins op_add = {4'h1};
}

// Define reusable macros for opcode checks
`define IS_ADD_OPCODE (coverage_trans.Instr_dout[15:12] == 4'h1)
`define IS_AND_OPCODE (coverage_trans.Instr_dout[15:12] == 4'h5)
`define IS_NOT_OPCODE (coverage_trans.Instr_dout[15:12] == 4'h9)

// Destination register
dest_reg: coverpoint coverage_trans.Instr_dout[11:9] 
  iff (`IS_ADD_OPCODE || `IS_AND_OPCODE || `IS_NOT_OPCODE);

// Source 1 register
src1_reg: coverpoint coverage_trans.Instr_dout[8:6] 
  iff (`IS_ADD_OPCODE || `IS_AND_OPCODE || `IS_NOT_OPCODE);

// Immediate bit
imm_bit: coverpoint coverage_trans.Instr_dout[5] 
  iff (`IS_ADD_OPCODE || `IS_AND_OPCODE);

// Source 2 register
src2_reg: coverpoint coverage_trans.Instr_dout[2:0] 
  iff (coverage_trans.Instr_dout[5] == 1'b0 && 
       (`IS_ADD_OPCODE || `IS_AND_OPCODE));

// Immediate field
imm5_field: coverpoint coverage_trans.Instr_dout[4:0] 
  iff (coverage_trans.Instr_dout[5] == 1'b1 && 
       (`IS_ADD_OPCODE || `IS_AND_OPCODE)) {
  bins imm5_range = {[0:31]};
}

//ALU cross and registers. 
add_x_sr1: cross alu_add_opcode,src1_reg {}
add_x_sr2: cross alu_add_opcode,src2_reg {}
add_x_sr1_sr2: cross add_x_sr1,src2_reg {}

and_x_sr1: cross alu_and_opcode,src1_reg {}
and_x_sr1_sr2: cross and_x_sr1,src2_reg {}

endgroup

covergroup memory_operation;

  // Opcodes for memory operations
  mem_ld_opcode: coverpoint coverage_trans.Instr_dout[15:12] {
    bins op_ld = {4'h2};
  }

  mem_ldr_opcode: coverpoint coverage_trans.Instr_dout[15:12] {
    bins op_ldr = {4'h6};
  }

  mem_ldi_opcode: coverpoint coverage_trans.Instr_dout[15:12] {
    bins op_ldi = {4'ha};
  }

  mem_lea_opcode: coverpoint coverage_trans.Instr_dout[15:12] {
    bins op_lea = {4'he};
  }

  mem_st_opcode: coverpoint coverage_trans.Instr_dout[15:12] {
    bins op_st = {4'h3};
  }

  mem_str_opcode: coverpoint coverage_trans.Instr_dout[15:12] {
    bins op_str = {4'h7};
  }

  mem_sti_opcode: coverpoint coverage_trans.Instr_dout[15:12] {
    bins op_sti = {4'hb};
  }

  // Define reusable macros for opcode checks
  `define IS_MEM_LD (coverage_trans.Instr_dout[15:12] == 4'h2)
  `define IS_MEM_LDR (coverage_trans.Instr_dout[15:12] == 4'h6)
  `define IS_MEM_LDI (coverage_trans.Instr_dout[15:12] == 4'ha)
  `define IS_MEM_LEA (coverage_trans.Instr_dout[15:12] == 4'he)
  `define IS_MEM_ST (coverage_trans.Instr_dout[15:12] == 4'h3)
  `define IS_MEM_STR (coverage_trans.Instr_dout[15:12] == 4'h7)
  `define IS_MEM_STI (coverage_trans.Instr_dout[15:12] == 4'hb)

  // Destination register for load and lea operations
  dest_reg_mem: coverpoint coverage_trans.Instr_dout[11:9]
    iff (`IS_MEM_LD || `IS_MEM_LDR || `IS_MEM_LDI || `IS_MEM_LEA);

  // Source register for store operations
  src_reg_mem: coverpoint coverage_trans.Instr_dout[11:9]
    iff (`IS_MEM_ST || `IS_MEM_STR || `IS_MEM_STI);

  // Base register for LDR and STR operations
  base_r_reg_mem: coverpoint coverage_trans.Instr_dout[8:6]
    iff (`IS_MEM_LDR || `IS_MEM_STR);

  // pcOffset6 field for LDR and STR operations
  pcOffset_6_reg_mem: coverpoint coverage_trans.Instr_dout[5:0]
    iff (`IS_MEM_LDR || `IS_MEM_STR) {
    bins pcOffset_6_reg = {[0:63]};
  }

  // pcOffset9 field for LD, LDI, LEA, ST, and STI operations
  pcOffset_9_reg_mem: coverpoint coverage_trans.Instr_dout[8:0]
    iff (`IS_MEM_LD || `IS_MEM_LDI || `IS_MEM_LEA || `IS_MEM_ST || `IS_MEM_STI) {
    bins pcOffset_9_reg = {[0:511]};
  }

pcOffset_6_x_str: cross mem_str_opcode, pcOffset_6_reg_mem {}
endgroup

covergroup control_operation;

// Opcodes for control operations
con_opcode: coverpoint coverage_trans.Instr_dout[15:12] {
  bins op_br = {4'h0};          // BR opcode
  bins op_jmp = {4'hc};         // JMP opcode
}

// Define macros for opcode checks
`define IS_CONTROL_BR  (coverage_trans.Instr_dout[15:12] == 4'h0)
`define IS_CONTROL_JMP (coverage_trans.Instr_dout[15:12] == 4'hc)

// NZP register for BR operation
NZP_reg: coverpoint coverage_trans.Instr_dout[11:9]
  iff (`IS_CONTROL_BR) {
  ignore_bins nzp_reg = {3'b000}; // Ignore no condition
}

// PC offset for BR operation
pc_control_9: coverpoint coverage_trans.Instr_dout[8:0]
  iff (`IS_CONTROL_BR) {
  bins pc_control_value = {[0:511]};
}

// Base register for JMP operation
base_r_control: coverpoint coverage_trans.Instr_dout[8:6]
  iff (`IS_CONTROL_JMP);

endgroup

// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
function new(string name="", uvm_component parent=null);
  super.new(name,parent);
  imem_transaction_cg=new;
  control_operation=new;
  memory_operation=new;
  arithmetic_operation=new;
  // `uvm_warning("COVERAGE_MODEL_REVIEW", "A covergroup has been constructed which may need review because of either generation or re-generation with merging.  Please note that transaction variables added as a result of re-generation and merging are not automatically added to the covergroup.  Remove this warning after the covergroup has been reviewed.")
endfunction

// ****************************************************************************
// FUNCTION : build_phase()
// This function is the standard UVM build_phase.
//
function void build_phase(uvm_phase phase);
  imem_transaction_cg.set_inst_name($sformatf("imem_transaction_cg_%s",get_full_name()));
endfunction

// ****************************************************************************
// FUNCTION: write (T t)
// This function is automatically executed when a transaction arrives on the
// analysis_export.  It copies values from the variables in the transaction 
// to local variables used to collect functional coverage.  
//
virtual function void write (T t);
  //`uvm_info("COV","Received transaction",UVM_NONE);
  coverage_trans = t;
  imem_transaction_cg.sample();
  control_operation.sample();
  memory_operation.sample();
  arithmetic_operation.sample();
endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

