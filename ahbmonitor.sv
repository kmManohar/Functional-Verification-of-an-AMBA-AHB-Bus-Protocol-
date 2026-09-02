`ifndef "AHB_MONITORR"
`define "AHB_MONITORR"
`include "ahbbase.sv"
//`include "ahbcoverage.sv"
class ahbmonitor;
  ahbbase pkt;
  mailbox mon2sb;
  virtual ahb_inff intf;
  //ahbcoverage crg1;
  
  function new(ahbbase pkt,mailbox mon2sb,virtual ahb_inff intf);
  this.pkt=pkt;
  this.mon2sb=mon2sb;
  this.intf=intf;
  //crg1=new();
  endfunction
  
  task monrun();
    begin
      #10
      pkt.HWDATA_tb=intf.HWDATA_tb;
      pkt.HRDATA_tb=intf.HRDATA_tb;
      mon2sb.put(pkt);
      $display("MON2SCB=%p",pkt);
    end
    //crg1.sample(pkt);
  endtask
endclass
`endif