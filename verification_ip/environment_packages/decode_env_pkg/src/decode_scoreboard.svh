class decode_scoreboard extends uvm_component;
  `uvm_component_utils(decode_scoreboard)

  `uvm_analysis_imp_decl(_expected)
  uvm_analysis_imp_expected #(decode_out_transaction, decode_scoreboard) expected_ae;
  `uvm_analysis_imp_decl(_actual)
  uvm_analysis_imp_actual   #(decode_out_transaction, decode_scoreboard) actual_ae;
  decode_out_transaction expected_q[$];
  int expected_count;
  int compared_count;
  int match_count;
  int mismatch_count;
  bit wait_for_scoreboard_empty;

  function new(string name = "decode_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    expected_ae = new("expected_ae", this);
    actual_ae   = new("actual_ae", this);
    wait_for_scoreboard_empty = 1'b1;
  endfunction

  function void write_expected(decode_out_transaction t);
    expected_q.push_back(t);
    expected_count++;

  endfunction

  function void write_actual(decode_out_transaction t);
    decode_out_transaction exp;

    if (expected_q.size() == 0) begin
      return;
    end

    exp = expected_q.pop_front();
    compared_count++;

    if (t.compare(exp)) begin
      match_count++;
      `uvm_info(get_type_name(), $sformatf("Transaction %0d MATCHED with expected output", compared_count),UVM_LOW)
    end
    else begin
      mismatch_count++;
      `uvm_error(get_type_name(),$sformatf("Transaction %0d MISMATCH!", compared_count))

    end
  endfunction

  task wait_for_scoreboard_drain();
    wait (expected_q.size() == 0);
  endtask

  virtual function void phase_ready_to_end(uvm_phase phase);
    if (phase.get_name() == "run") begin
      if (wait_for_scoreboard_empty) begin
        phase.raise_objection(this, {get_full_name(), " - Delaying EOT"});
        fork
          begin
            wait_for_scoreboard_drain();
            phase.drop_objection(this, {get_full_name(), " - Done draining"});
          end
        join_none
      end
    end
  endfunction

  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(),$sformatf("Scoreboard Summary:\nExpected received: %0d\nCompared: %0d\nMatches: %0d\nMismatches: %0d\nRemaining in queue: %0d", expected_count, compared_count, match_count, mismatch_count, expected_q.size()),UVM_LOW)
  endfunction

endclass
