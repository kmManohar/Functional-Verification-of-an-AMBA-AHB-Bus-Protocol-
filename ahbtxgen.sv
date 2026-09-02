`ifndef "AHB_TXGENE"
`define "AHB_TXGENE"
`include "ahbbase.sv" 
 class ahbtxgen;
   ahbbase pkt;
   mailbox tx2drv;
   
   function new(ahbbase pkt,mailbox tx2drv);
     this.pkt=pkt;
     this.tx2drv=tx2drv;
   endfunction
   
   task txrun();
     begin
      pkt.randomize(); //with {data_tb inside{[0:2000]};};
      pkt.HRESETn_tb=1;
      pkt.HREADY_tb=1;
//      pkt.wr_tb=1;
      pkt.HRESP_tb=0;
  // pkt.maddr_tb=32'b0110100;
   //  pkt.maddr_tb=32'b01010100;
   pkt.maddr_tb=32'b10010100;
  // pkt.data_tb=32'b10101010;
   //   pkt.burst_tb=3'b010;
    // pkt.size_tb=3'b010;
     // pkt.trans_tb=2'b11;
      tx2drv.put(pkt);
      $display("TXGENE PACKET = %p", pkt);

      #100
      //  pkt.HRESETn_tb=1;
       // pkt.HREADY_tb=1;
     //   pkt.wr_tb=0;
       // pkt.HRESP_tb=0;
     //  pkt.maddr_tb=32'b01010100;
  //  pkt.maddr_tb=32'b01010100;
      pkt.maddr_tb=32'b10010100;
  //  pkt.data_tb=32'b10101010;
      // pkt.burst_tb=3'b010;
      // pkt.size_tb=3'b010;
      //pkt.trans_tb=2'b11;
      
      tx2drv.put(pkt);
      $display("TXGENE PACKET = %p", pkt);
      
      #200
      pkt.maddr_tb=32'b10010100;
      tx2drv.put(pkt);
      $display("TXGENE PACKET = %p", pkt);
     end
   endtask
 endclass
  `endif
  
  
  
  
  
  
  
  
  
  
  
  
  
  /*`ifndef "AHB_TXGENE"
`define "AHB_TXGENE"
 `include "ahbbase.sv" 
 class ahbtxgen;
   ahbbase pkt1;
   mailbox tx2drv;
   
  function new(ahbbase pkt1,mailbox tx2drv);
     this.pkt1=pkt1;
     this.tx2drv=tx2drv;
   endfunction
   
   task txrun();
     begin
       pkt1.randomize();
       
       pkt1.HRESETn_tb = 1'b0;  pkt1.HREADY_tb = 1'b0;   pkt1.wr_tb= 1'b0;
       pkt1.maddr_tb = 32'b00000000;   
       pkt1.burst_tb = 3'b000;    pkt1.size_tb = 3'b000;   pkt1.trans_tb= 2'b00;
       tx2drv.put(pkt1);   $display("TXGENE PACKET1 at initial_condition = %p", pkt1);
// #10 
       pkt1.HRESETn = 1'b1;  pkt1.HREADY = 1'b1;   pkt1.wr = 1'b1;
       pkt1.maddr = 32'h34;  
       pkt1.burst = 3'b000;  pkt1.size = 3'b000;   pkt1.trans= 2'b00; 
       tx2drv.put(pkt1);     $display("Tx idle write single transfer = %p", pkt1);
 #10  
       pkt1.wr = 1'b0
       tx2drv.put(pkt1);   $display("Tx idle read single transfer = %p", pkt1);     
 #10 
       pkt1.wr = 1'b1;   pkt1.trans= 2'b01; 
       tx2drv.put(pkt1);     $display("Tx busy write single transfer = %p", pkt1);
 #10  
       pkt1.wr = 1'b0
       tx2drv.put(pkt1);   $display("Tx busy read single transfer = %p", pkt1);///
 #10   pkt1.randomize();
       pkt1.HRESETn_tb = 1'b1;  pkt1.HREADY_tb = 1'b1;  pkt1.maddr_tb = 32'h34;  pkt1.burst_tb = 3'b000;
       pkt1.size_tb = 3'b000;
       pkt1.wr_tb = 1'b1;    pkt1.trans_tb= 2'b10; 
       tx2drv.put(pkt1);     $display("Tx non sequential single tranfer write operation = %p", pkt1);
 #10 
       pkt1.wr_tb = 1'b0;     
       tx2drv.put(pkt1);     $display("Tx non sequential single tranfer read operation = %p", pkt1);
 #10 
       pkt1.wr_tb = 1'b1;    pkt1.trans_tb= 2'b11; 
       tx2drv.put(pkt1);     $display("Tx sequential single tranfer write operation = %p", pkt1);
 #10 
       pkt1.wr_tb = 1'b0;    
       tx2drv.put(pkt1);     $display("Tx sequential single tranfer read operation = %p", pkt1);
     end
   endtask
 endclass
  `endif
*/

  