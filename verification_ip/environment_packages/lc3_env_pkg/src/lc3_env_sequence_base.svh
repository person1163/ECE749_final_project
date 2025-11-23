//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This file contains environment level sequences that will
//    be reused from block to top level simulations.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class lc3_env_sequence_base #( 
      type CONFIG_T
      ) extends uvmf_virtual_sequence_base #(.CONFIG_T(CONFIG_T));


  `uvm_object_param_utils( lc3_env_sequence_base #(
                           CONFIG_T
                           ) );

  
// This lc3_env_sequence_base contains a handle to a lc3_env_configuration object 
// named configuration.  This configuration variable contains a handle to each 
// sequencer within each agent within this environment and any sub-environments.
// The configuration object handle is automatically assigned in the pre_body in the
// base class of this sequence.  The configuration handle is retrieved from the
// virtual sequencer that this sequence is started on.
// Available sequencer handles within the environment configuration:

  // Initiator agent sequencers in lc3_environment:
    // configuration.imem_agent_config.sequencer
    // configuration.dmem_agent_config.sequencer

  // Responder agent sequencers in lc3_environment:

  // Virtual sequencers in sub-environments located in sub-environment configuration
    // configuration.fetch_config.vsqr
    // configuration.memaccess_config.vsqr
    // configuration.control_config.vsqr

    typedef imem_random_sequence imem_agent_random_sequence_t;
    imem_agent_random_sequence_t imem_agent_rand_seq;

    typedef dmem_random_sequence dmem_agent_random_sequence_t;
    dmem_agent_random_sequence_t dmem_agent_rand_seq;


// This example shows how to use the environment sequence base for sub-environments
// It can only be used on environments generated with UVMF_2022.3 and later.
// Environment sequences generated with UVMF_2022.1 and earlier do not have the required 
//    environment level virtual sequencer
// typedef fetch_env_sequence_base #(
//         .CONFIG_T(fetch_env_configuration)
//         ) 
//         fetch_sequence_base_t;
// rand fetch_sequence_base_t fetch_seq;

// typedef memaccess_env_sequence_base #(
//         .CONFIG_T(memaccess_env_configuration)
//         ) 
//         memaccess_sequence_base_t;
// rand memaccess_sequence_base_t memaccess_seq;

// typedef control_env_sequence_base #(
//         .CONFIG_T(control_env_configuration)
//         ) 
//         control_sequence_base_t;
// rand control_sequence_base_t control_seq;



  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  function new(string name = "" );
    super.new(name);
    imem_agent_rand_seq = imem_agent_random_sequence_t::type_id::create("imem_agent_rand_seq");
    dmem_agent_rand_seq = dmem_agent_random_sequence_t::type_id::create("dmem_agent_rand_seq");

//     fetch_seq = fetch_sequence_base_t::type_id::create("fetch_seq");
//     memaccess_seq = memaccess_sequence_base_t::type_id::create("memaccess_seq");
//     control_seq = control_sequence_base_t::type_id::create("control_seq");

  endfunction

  virtual task body();

  
    if ( configuration.imem_agent_config.sequencer != null )
       repeat (25) imem_agent_rand_seq.start(configuration.imem_agent_config.sequencer);
    if ( configuration.dmem_agent_config.sequencer != null )
       repeat (25) dmem_agent_rand_seq.start(configuration.dmem_agent_config.sequencer);

//     fetch_seq.start(configuration.fetch_config.vsqr);
//     memaccess_seq.start(configuration.memaccess_config.vsqr);
//     control_seq.start(configuration.control_config.vsqr);

  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

