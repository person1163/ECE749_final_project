class decode_out_transaction extends uvm_sequence_item;
    `uvm_object_utils(decode_out_transaction)

    int  transaction_view_h;
    logic [15:0] ir;
    logic [15:0] npc_out;
    logic [5:0] E_control;
    logic [1:0] W_control;
    logic mem_control; 
    time start_time, end_time;

    function new (string name="decode_out_transaction");
        super.new(name);
    endfunction    

    virtual function string  convert2string();
        return $sformatf("IR=%x npc_out=%x  E_control=%x W_control=%x mem_control=%x",ir,npc_out,E_control,W_control,mem_control);
    endfunction   

    virtual function void wave_view(int transaction_viewing_stream_h);
       transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"decode_out_transaction",start_time);
       $add_attribute(transaction_view_h,ir,"IR");
       $add_attribute(transaction_view_h, npc_out, "npc_out");
       $add_attribute(transaction_view_h, E_control, "E_control");
       $add_attribute(transaction_view_h, W_control, "W_control");
       $add_attribute(transaction_view_h, mem_control, "mem_control");       
       $end_transaction(transaction_view_h,end_time);
       $free_transaction(transaction_view_h);
    endfunction
virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    decode_out_transaction RHS;

   
    if (!$cast(RHS, rhs)) begin
      `uvm_error(get_type_name(), "Type mismatch in do_compare — rhs is not decode_out_transaction")
      return 0;
    end

    return (
         (this.ir         == RHS.ir)
      && (this.npc_out    == RHS.npc_out)
      && (this.E_control  == RHS.E_control)
      && (this.W_control  == RHS.W_control)
      && (this.mem_control== RHS.mem_control)
    );
  endfunction
endclass