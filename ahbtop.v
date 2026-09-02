module ahbtop(HRESETn_tb,HCLK_tb,HREADY_tb,HWDATA_tb,HRDATA_tb,,HRESP_tb,data_tb,maddr_tb,wr_tb,size_tb,burst_tb,trans_tb);
  input HRESETn_tb,HCLK_tb;
  input [31:0] maddr_tb;
  input [31:0] data_tb;
  input [2:0] burst_tb;
  input [2:0] size_tb;
  input [1:0] trans_tb;
  input HRESP_tb;
  input wr_tb;
  input HREADY_tb;
  
  output [31:0] HWDATA_tb;
  output [31:0] HRDATA_tb;
  
  wire HWRITE_tb;
  wire [1:0]HTRANS_tb;
  wire [2:0]HBURST_tb;
  wire [2:0]HSIZE_tb;
  wire [31:0]HADDR_tb;
  wire HREADYOUT_tb;
  
  wire HSEL1_tb;
  wire HSEL2_tb;
  wire HSEL3_tb;
  
  wire resp1_tb;
  wire resp2_tb;
  wire resp3_tb;  
  
  wire readyout1_tb;
  wire readyout2_tb;
  wire readyout3_tb;
 
 wire [31:0]rddata1_tb;
 wire [31:0]rddata2_tb;
 wire [31:0]rddata3_tb;
 /*
 wire res_tb;
 assign res_tb=HRESP_tb||resp1_tb||resp2_tb||resp3_tb;
 
 wire ready_tb;
 assign ready_tb=readyout1_tb||readyout2_tb||readyout3_tb;
 
 wire [31:0]rdata_tb;
 assign rdata_tb=rddata1_tb||rddata2_tb||rddata3_tb;
 */
   ahbmas a1(.HCLK(HCLK_tb),.HRESETn(HRESETn_tb),.HREADY(HREADY_tb),.HRESP(HRESP_tb),.maddr(maddr_tb),
   .wr(wr_tb),.size(size_tb),.burst(burst_tb),.trans(trans_tb),.HRDATA(data_tb),.HWRITE(HWRITE_tb),
   .HTRANS(HTRANS_tb),.HSIZE(HSIZE_tb),.HWDATA(HWDATA_tb),.HADDR(HADDR_tb),.HBURST(HBURST_tb));
   
   decd a2(.HCLK(HCLK_tb),.HADDR(maddr_tb),.HSEL1(HSEL1_tb),.HSEL2(HSEL2_tb),.HSEL3(HSEL3_tb));
   
   ahbslav a3 (.HCLK(HCLK_tb),.HRESETn(HRESETn_tb),.HSEL(HSEL1_tb),.HADDR(maddr_tb),.HWRITE(HWRITE_tb),
   .HSIZE(HSIZE_tb),.HTRANS(HTRANS_tb),.HBURST(HBURST_tb),.HREADY(HREADY_tb),.HWDATA(data_tb),
   .HREADYOUT(readyout1_tb),.HRESP(resp1_tb),.HRDATA(rddata1_tb));
   
   ahbslav a4 (.HCLK(HCLK_tb),.HRESETn(HRESETn_tb),.HSEL(HSEL2_tb),.HADDR(maddr_tb),.HWRITE(HWRITE_tb),
   .HSIZE(HSIZE_tb),.HTRANS(HTRANS_tb),.HBURST(HBURST_tb),.HREADY(HREADY_tb),.HWDATA(data_tb),
   .HREADYOUT(readyout2_tb),.HRESP(resp2_tb),.HRDATA(rddata2_tb));
   
   ahbslav a5 (.HCLK(HCLK_tb),.HRESETn(HRESETn_tb),.HSEL(HSEL3_tb),.HADDR(maddr_tb),.HWRITE(HWRITE_tb),
   .HSIZE(HSIZE_tb),.HTRANS(HTRANS_tb),.HBURST(HBURST_tb),.HREADY(HREADY_tb),.HWDATA(data_tb),
   .HREADYOUT(readyout3_tb),.HRESP(resp3_tb),.HRDATA(rddata3_tb));
   
     muxs a6 (.HCLK(HCLK_tb),.HRESETn(HRESETn_tb),.HREADY(HREADY_tb),.HSEL1(HSEL1_tb),
   .HRDATA1(rddata1_tb),.HRESP1(resp1_tb),.HREADYOUT1(readyout1_tb),.HSEL2(HSEL2_tb),
   .HRDATA2(rddata2_tb),.HRESP2(resp2_tb),.HREADYOUT2(readyout2_tb),.HSEL3(HSEL3_tb),
   .HRDATA3(rddata3_tb),.HRESP3(resp3_tb),.HREADYOUT3(readyout3_tb),
   .HREADYOUT(HREADYOUT_tb),.HRDATA(HRDATA_tb),.HRESP(HRESP_tb));
endmodule