`ifndef "COVERAGE_AHB"
`define "COVERAGE_AHB"
`include "ahbbase.sv"
class ahbcoverage;
  ahbbase pkt;
covergroup crg;
option.per_instance=1;



HRESETn_tb: coverpoint pkt.HRESETn_tb;
HREADY_tb: coverpoint pkt.HREADY_tb;
HRESP_tb: coverpoint pkt.HRESP_tb
  {
    bins d ={0};
//  bins b={1};
  }
wr_tb: coverpoint pkt.wr_tb
  {
    bins a ={0};
    bins b={1};
  }
maddr_tb: coverpoint pkt.maddr_tb
  {
     bins e={[0:100]};
  }
data_tb: coverpoint pkt.data_tb
  {
     bins c={[0:1023]};
     //bins LOW1={[1001 :2000]}; 
  } 
burst_tb: coverpoint pkt.burst_tb
  {
    bins f={[0:7]};
  }
size_tb: coverpoint pkt.size_tb
  {
     bins g={[0:7]};
  }
trans_tb: coverpoint pkt.trans_tb
  {
    bins h={[0:3]};
  }
HWDATA_tb: coverpoint pkt.HWDATA_tb
  {
    bins i={[0:1023]};
   //bins LOW122[100]={[1001 :2000]};
  }
HRDATA_tb: coverpoint pkt.HRDATA_tb
  {
     bins j={[0:1023]};
    // bins LOW2={[1001 :2000]};
  }
endgroup

function new();
  crg=new();
endfunction

task sample(ahbbase pkt);
  this.pkt=pkt;
  crg.sample();
endtask
endclass
`endif