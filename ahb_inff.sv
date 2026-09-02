interface ahb_inff(input HCLK);

  logic HRESETn_tb;
  logic HREADY_tb;
  logic wr_tb;
  logic HRESP_tb;
  logic [31:0] maddr_tb;
  logic [31:0] data_tb;
  logic [2:0] burst_tb;
  logic [2:0] size_tb;
  logic [1:0] trans_tb;
  logic [31:0] HWDATA_tb;
  logic [31:0] HRDATA_tb;

clocking cb @(posedge HCLK);

default input #1 output #1;
  output HRESETn_tb;
  output HREADY_tb;
  output wr_tb;
  output HRESP_tb;
  output maddr_tb;
  output data_tb;
  output burst_tb;
  output size_tb;
  output trans_tb;
  input  HWDATA_tb;
  input  HRDATA_tb;
endclocking

modport dut(input HCLK,HRESETn_tb,HREADY_tb,wr_tb,HRESP_tb,maddr_tb,data_tb,burst_tb,size_tb,trans_tb, output HWDATA_tb,HRDATA_tb);
modport tb(output HRESETn_tb,HREADY_tb,wr_tb,HRESP_tb,maddr_tb,data_tb,burst_tb,size_tb,trans_tb, input HCLK, HWDATA_tb,HRDATA_tb, clocking cb);

endinterface