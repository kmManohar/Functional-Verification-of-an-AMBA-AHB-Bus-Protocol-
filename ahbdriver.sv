`ifndef "AHB_DRIVERR"
`define "AHB_DRIVERR"
`include "ahbbase.sv"
//`include "ahbcoverage.sv"
  class ahbdriver;
    ahbbase pkt;
    mailbox tx2drv,drv2sb;
    virtual ahb_inff intf;
    //ahbcoverage crg2;
    
    function new(ahbbase pkt, mailbox tx2drv,drv2sb,virtual ahb_inff intf);
      this.pkt=pkt;
      this.tx2drv=tx2drv;
      this.drv2sb=drv2sb;
      this.intf=intf;
      //crg2=new();
    endfunction


function ajay(int a);
    $display("MASTERVLSI");
endfunction

task ajay(int b);
    $display("MASTERVLSI");
endtask

    task drvrun();
      begin
        tx2drv.get(pkt);
        $display("TX2DRVV PACKET=%p", pkt);
        
        intf.HRESETn_tb = pkt.HRESETn_tb;
        intf.HREADY_tb = pkt.HREADY_tb;
        intf.wr_tb = pkt.wr_tb;
        intf.HRESP_tb=pkt.HRESP_tb;
        intf.maddr_tb = pkt.maddr_tb;
        intf.data_tb = pkt.data_tb;
        intf.burst_tb = pkt.burst_tb;
        intf.size_tb = pkt.size_tb;
        intf.trans_tb = pkt.trans_tb;
      
        drv2sb.put(pkt);
        $display("DRVV2SB PACKET=%p", pkt);
      
      #100
      intf.HRESETn_tb =pkt.HRESETn_tb;
      intf.HREADY_tb = pkt.HREADY_tb;
      intf.wr_tb = pkt.wr_tb;
      intf.HRESP_tb=pkt.HRESP_tb;
      intf.maddr_tb = pkt.maddr_tb;
     intf.data_tb = pkt.data_tb;
     intf.burst_tb = pkt.burst_tb;
     intf.size_tb = pkt.size_tb;
     intf.trans_tb = pkt.trans_tb;
       
        drv2sb.put(pkt);
        $display("DRVV2SB PACKET=%p", pkt);
      
      #200
      intf.HRESETn_tb =pkt.HRESETn_tb;
      intf.HREADY_tb = pkt.HREADY_tb;
      intf.wr_tb = pkt.wr_tb;
      intf.HRESP_tb=pkt.HRESP_tb;
      intf.maddr_tb = pkt.maddr_tb;
     intf.data_tb = pkt.data_tb;
     intf.burst_tb = pkt.burst_tb;
     intf.size_tb = pkt.size_tb;
     intf.trans_tb = pkt.trans_tb;  
        drv2sb.put(pkt);
        $display("DRVV2SB PACKET=%p", pkt);
      end
      //crg2.sample(pkt);
  endtask  
  endclass
  `endif









/*`ifndef "AHB_DRIVERR"
`define "AHB_DRIVERR"
  `include "ahbbase.sv"
//  `include "ahb_coverage.sv"
  class ahbdriver;
    ahbbase pkt1;
    mailbox tx2drv,drv2sb;
    virtual ahb_inff intf;
    //coverag cg2;
    function new(ahbbase pkt1, mailbox tx2drv,drv2sb,virtual ahb_inff intf);
      this.pkt1=pkt1;  this.tx2drv=tx2drv;   this.drv2sb=drv2sb;  this.intf=intf;//cg2=new();
    endfunction
    
    task drvrun();
      begin
        
        tx2drv.get(pkt1);
        $display("TX2DRVV PACKET1=%p", pkt1);
        intf.HRESETn_tb =pkt1.HRESETn_tb;  intf.HREADY_tb = pkt1.HREADY_tb;  intf.wr_tb = pkt1.wr_tb;
        intf.HRESP_tb=pkt1.HRESP_tb;
        intf.maddr_tb = pkt1.maddr_tb;  intf.data_tb = pkt1.data_tb;
        intf.burst_tb = pkt1.burst_tb;  intf.size_tb = pkt1.size_tb;  intf.trans_tb = pkt1.trans_tb;
        drv2sb.put(pkt1);   $display("DRV pkt1 at initial_condition =%p", pkt1);
       // cg2.sample(pkt1);
//////  #15
        intf.HRESETn =pkt1.HRESETn;  intf.HREADY = pkt1.HREADY;   intf.wr = pkt1.wr;  intf.HRESP=pkt1.HRESP;
        intf.maddr = pkt1.maddr;   intf.data = pkt1.data;
        intf.burst = pkt1.burst;   intf.size = pkt1.size;   intf.trans = pkt1.trans;
        drv2sb.put(pkt1);   $display("DRV idle write single transfer =%p", pkt1);
  #15
        intf.HRESETn =pkt1.HRESETn;  intf.HREADY = pkt1.HREADY;   intf.wr = pkt1.wr;  intf.HRESP=pkt1.HRESP;
        intf.maddr = pkt1.maddr;   intf.data = pkt1.data;
        intf.burst = pkt1.burst;   intf.size = pkt1.size;    intf.trans = pkt1.trans;
        drv2sb.put(pkt1);   $display("DRV idle read single transfer =%p", pkt1);
  #15
        intf.HRESETn =pkt1.HRESETn;  intf.HREADY = pkt1.HREADY;   intf.wr = pkt1.wr;  intf.HRESP=pkt1.HRESP;
        intf.maddr = pkt1.maddr;   intf.data = pkt1.data;
        intf.burst = pkt1.burst;   intf.size = pkt1.size;    intf.trans = pkt1.trans;
        drv2sb.put(pkt1);   $display("DRV busy write single transfer =%p", pkt1);
        
  #15
        intf.HRESETn =pkt1.HRESETn;  intf.HREADY = pkt1.HREADY;   intf.wr = pkt1.wr;  intf.HRESP=pkt1.HRESP;
        intf.maddr = pkt1.maddr;   intf.data = pkt1.data;
        intf.burst = pkt1.burst;   intf.size = pkt1.size;    intf.trans = pkt1.trans;
        drv2sb.put(pkt1);   $display("DRV busy read single transfer =%p", pkt1);
        //////////////
      
  #15
        intf.HRESETn_tb =pkt1.HRESETn_tb;  intf.HREADY_tb = pkt1.HREADY_tb;   intf.wr_tb = pkt1.wr_tb;
        intf.HRESP_tb=pkt1.HRESP_tb;
        intf.maddr_tb = pkt1.maddr_tb;   intf.data_tb = pkt1.data_tb;
        intf.burst_tb = pkt1.burst_tb;   intf.size_tb = pkt1.size_tb;    intf.trans_tb = pkt1.trans_tb;
        drv2sb.put(pkt1);   $display("DRV non sequential write single transfer =%p", pkt1);
      //  cg2.sample(pkt1);
        
  #15
        intf.HRESETn_tb =pkt1.HRESETn_tb;  intf.HREADY_tb = pkt1.HREADY_tb;   intf.wr_tb = pkt1.wr_tb;
        intf.HRESP_tb=pkt1.HRESP_tb;
        intf.maddr_tb = pkt1.maddr_tb;   intf.data_tb = pkt1.data_tb;
        intf.burst_tb = pkt1.burst_tb;   intf.size_tb = pkt1.size_tb;    intf.trans_tb = pkt1.trans_tb;
        drv2sb.put(pkt1);   $display("DRV non sequential read single transfer =%p", pkt1);
       // cg2.sample(pkt1);
        
  #15
        intf.HRESETn_tb =pkt1.HRESETn_tb;  intf.HREADY_tb = pkt1.HREADY_tb;   intf.wr_tb = pkt1.wr_tb;
        intf.HRESP_tb=pkt1.HRESP_tb;
        intf.maddr_tb = pkt1.maddr_tb;   intf.data_tb = pkt1.data_tb;
        intf.burst_tb = pkt1.burst_tb;   intf.size_tb = pkt1.size_tb;    intf.trans_tb = pkt1.trans_tb;
        drv2sb.put(pkt1);   $display("DRV sequential write single transfer =%p", pkt1);
        //cg2.sample(pkt1);
        
  #15
        intf.HRESETn_tb =pkt1.HRESETn_tb;  intf.HREADY_tb = pkt1.HREADY_tb;   intf.wr_tb = pkt1.wr_tb;
        intf.HRESP_tb=pkt1.HRESP_tb;
        intf.maddr_tb = pkt1.maddr_tb;   intf.data_tb = pkt1.data_tb;
        intf.burst_tb = pkt1.burst_tb;   intf.size_tb = pkt1.size_tb;    intf.trans_tb = pkt1.trans_tb;
        drv2sb.put(pkt1);   $display("DRV sequential read single transfer =%p", pkt1);
         
      end
     // cg2.sample(pkt1);
//cg2.sample(pkt1);
  endtask  
  endclass
  `endif
*/
