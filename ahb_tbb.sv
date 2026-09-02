`include "ahbbase.sv"
`include "ahbtxgen.sv"
`include "ahbdriver.sv"
`include "ahbmonitor.sv"
`include "ahbscoreboard.sv"
program ahb_tbb(ahb_inff.tb intf);
ahbbase pkt1,pkt2;
ahbtxgen tx;
ahbdriver drv;
ahbmonitor mon;
ahbscoreboard sb;
mailbox tx2drv,drv2sb,mon2sb;

initial begin
  pkt1=new();
  pkt2=new();
  tx2drv=new();
  drv2sb=new();
  mon2sb=new();
  tx=new(pkt1,tx2drv);
  drv=new(pkt1,tx2drv,drv2sb,intf);
  mon=new(pkt2,mon2sb,intf);
  sb=new(pkt1,pkt2,mon2sb,drv2sb);
end

initial 
repeat(10)
begin
   //fork
      tx.txrun();
      drv.drvrun();
      mon.monrun();
      sb.sbrun();
  //join
end
endprogram 