# Code to check 4KB boundary

class axi_tx; 
  rand bit [31:0] awaddr; 
  rand bit [ 3:0] awsize; 
  rand bit [ 7:0] awlen; 

  constraint axi_4kb { 
    awaddr % 4096 + (2**awsize * (awlen + 1)) <= 4096; 
  }   
endclass 

module top; 
  axi_tx tx=new(); 
  
  initial begin 
    repeat (5) begin 
      assert(tx.randomize()); 
      $display("awaddr = %0d awsize = %0d awlen = 0d",tx.awaddr,tx.awsize,tx.awlen);
      $display("addr_offset = %0d Total_txn = %0d",tx.awaddr%4096,(2^tx.awsize*(tx.awlen+1)));   
      $display("offset + total_txn <= 4096"); 
      $display("    %0d   <= 4096 \n",(tx.awaddr%4096+(2**tx.awsize*(tx.awlen+1)))); 
    end 
  end            
endmodule

OUTPUT:

awaddr = 116162828 awsize = 4 awlen = 0d237
addr_offset = 268 Total_txn = 954
offset + total_txn <= 4096
    4076   <= 4096 

awaddr = 728494443 awsize = 7 awlen = 0d 17
addr_offset = 363 Total_txn = 124
offset + total_txn <= 4096
    2667   <= 4096 

awaddr = 625107975 awsize = 10 awlen = 0d  0
addr_offset = 1031 Total_txn = 8
offset + total_txn <= 4096
    2055   <= 4096 

awaddr = 3152666966 awsize = 7 awlen = 0d  6
addr_offset = 342 Total_txn = 51
offset + total_txn <= 4096
    1238   <= 4096 

awaddr = 2159126835 awsize = 3 awlen = 0d180
addr_offset = 2355 Total_txn = 541
offset + total_txn <= 4096
    3803   <= 4096 

           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
CPU Time:      0.530 seconds;       Data structure size:   0.2Mb
Wed Jul  9 12:55:11 2025
