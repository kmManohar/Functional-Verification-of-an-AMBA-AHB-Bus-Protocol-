`ifndef "AHB_BASE"
`define "AHB_BASE"
  class ahbbase;
  randc bit [31:0] data_tb;
  randc bit wr_tb;
  bit HRESETn_tb;
  bit HREADY_tb;
  bit HRESP_tb;
 // randc bit wr_tb;
  bit [31:0] maddr_tb;
  randc bit [2:0] burst_tb;
  randc bit [2:0] size_tb;
 randc bit [1:0] trans_tb;
  bit [31:0] HWDATA_tb;
  bit [31:0] HRDATA_tb;
  
endclass
`endif