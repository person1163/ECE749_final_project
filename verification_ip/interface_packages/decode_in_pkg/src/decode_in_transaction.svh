class decode_in_transaction extends uvm_sequence_item;
    `uvm_object_utils(decode_in_transaction)

    int  transaction_view_h;
    rand bit[15:0] npc_in ;
    rand bit[15:0] Imem_dout ;
    typedef enum bit [3:0] {
            ADD= 4'b0001,
            AND= 4'b0101,
            NOT= 4'b1001,
            LD=  4'b0010,
            LDR= 4'b0110,
            LDI= 4'b1010,
            LEA= 4'b1110,
            ST=  4'b0011,
            STR= 4'b0111,
            STI= 4'b1011,
            BR=  4'b0000,
            JMP= 4'b1100
                          } op;
    time start_time, end_time;
    rand op opcode;

    
    constraint c_opcode_match { Imem_dout[15:12] == opcode; }

    constraint add_op { 
        if(Imem_dout[15:12]==4'b0001 && Imem_dout[5]==0)
        {
                    Imem_dout[4:3]==2'b00;
        }
    }
    constraint and_op{
         if(Imem_dout[15:12]==4'b0101 && Imem_dout[5]==0)
        {
                    Imem_dout[4:3]==2'b00;
        }
    }
        constraint not_op{
         if(Imem_dout[15:12]==4'b1001&& Imem_dout[5]==0)
        {
                    Imem_dout[5:0]==6'b111111;
        }
    }
    
    
    function new (string name="decode_in_transaction");
        super.new(name);
    endfunction    

    virtual function string  convert2string();
        return $sformatf("npc in=%x instr_dout=%x",npc_in,Imem_dout);
    endfunction   

    virtual function void wave_view(int transaction_viewing_stream_h);
       transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"decode_in_transaction",start_time);
       $add_attribute(transaction_view_h,opcode,"opcode");
       $add_attribute(transaction_view_h, npc_in, "npc_in");
       $add_attribute(transaction_view_h, Imem_dout, "Imem_dout");
       $end_transaction(transaction_view_h,end_time);
       $free_transaction(transaction_view_h);
    endfunction

endclass