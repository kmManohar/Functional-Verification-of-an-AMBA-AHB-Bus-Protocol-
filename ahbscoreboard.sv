`ifndef "AHB_SCOREBOARD"
`define "AHB_SCOREBOARD"
`include "ahbbase.sv"
`include "ahbcoverage.sv"
class ahbscoreboard;
ahbbase pkt1,pkt2;
mailbox mon2sb,drv2sb;
ahbcoverage crg3;

function new(ahbbase pkt1,pkt2, mailbox mon2sb,drv2sb);
  this.pkt1=pkt1;
  this.pkt2=pkt2;
  this.mon2sb=mon2sb;
  this.drv2sb=drv2sb;
  crg3=new();
endfunction

task sbrun();
begin
  drv2sb.get(pkt1);
  mon2sb.get(pkt2);
  if((pkt2.HWDATA_tb==pkt1.data_tb) && (pkt2.HRDATA_tb==pkt1.data_tb))
    $display("%t data=%b HWDATA=%b HRDATA=%b MATCHED",$time, pkt1.data_tb,pkt2.HWDATA_tb,pkt2.HRDATA_tb);
  else
    $display("%t data=%b HWDATA=%b HRDATA=%b NOT MATCHED",$time, pkt1.data_tb,pkt2.HWDATA_tb,pkt2.HRDATA_tb);

/*if(pkt2.HRDATA_tb==pkt1.data_tb)
    $display("data=%b HRDATA=%b MATCHED", pkt1.data_tb,pkt2.HRDATA_tb);
  else
    $display("data=%b HRDATA=%b NOT MATCHED", pkt1.data_tb,pkt2.HRDATA_tb);*/
    /*if(pkt2.HWDATA_tb==pkt1.data_tb)
   $display("data=%b HWDATA=%b MATCHED", pkt1.data_tb,pkt2.HWDATA_tb);
  else
    $display("data=%b HWDATA=%b NOT MATCHED", pkt1.data_tb,pkt2.HWDATA_tb);*/
end
crg3.sample(pkt1);
crg3.sample(pkt2);
endtask
endclass
`endif