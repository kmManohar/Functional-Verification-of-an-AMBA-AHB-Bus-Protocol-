module ahblin;
  reg HRESETn_tb,HCLK_tb;
  reg HREADY_tb;
  reg wr_tb;
  reg HRESP_tb;
  reg [31:0] maddr_tb;
  reg [31:0] data_tb;
  reg [2:0] burst_tb;
  reg [2:0] size_tb;
  reg [1:0] trans_tb;
  
  wire [31:0]HWDATA_tb;
  wire [31:0] HRDATA_tb;
  
  parameter st=10;
  parameter ht=10;
  parameter tp=100;

ahbtop dut(.HCLK_tb(HCLK_tb),.HRESETn_tb(HRESETn_tb),.HREADY_tb(HREADY_tb),.data_tb(data_tb),
.HRESP_tb(HRESP_tb),.maddr_tb(maddr_tb),.wr_tb(wr_tb),.size_tb(size_tb),.burst_tb(burst_tb),
.trans_tb(trans_tb),.HWDATA_tb(HWDATA_tb),.HRDATA_tb(HRDATA_tb));


initial begin
stimuli_gen(1'b0,1'b0,1'b0,1'b0,32'b0,32'b0,3'b0,3'b0,2'b0,32'b0,32'b0);
stimuli_gen(1'b1,1'b1,1'b0,1'b1,32'b00110100,32'b10101010,3'b010,3'b010,2'b00,32'b10101010,32'b10101010);
//stimuli_gen(1'b1,1'b1,1'b0,1'b1,32'b00110100,32'b10101010,3'b010,3'b010,2'b01,32'b10101010,32'b10101010);
//stimuli_gen(1'b1,1'b1,1'b0,1'b1,32'b00110100,32'b10101010,3'b010,3'b010,2'b10,32'b10101010,32'b10101010);
//stimuli_gen(1'b1,1'b1,1'b0,1'b1,32'b00110100,32'b10101010,3'b010,3'b010,2'b11,32'b10101010,32'b10101010);
//stimuli_gen(1'b1,1'b1,1'b0,1'b0,32'b01010100,32'b10101010,3'b010,3'b010,2'b11,32'b10101010,32'b10101010);
//stimuli_gen(1'b1,1'b1,1'b0,1'b0,32'b10010100,32'b10101010,3'b010,3'b010,2'b11,32'b10101010,32'b10101010);
end

initial begin 
  HCLK_tb=1'b0;
  forever #5 HCLK_tb=~HCLK_tb;
end
task stimuli_gen;
  input HRESETn_tb_t;
  input HREADY_tb_t;
  input HRESP_tb_t;
  input wr_tb_t;
  input [31:0] maddr_tb_t;
  input [31:0] data_tb_t;
  input [2:0] burst_tb_t;
  input [2:0] size_tb_t;
  input [1:0] trans_tb_t;
  input [31:0]HWDATA_tb_exp;
  input [31:0]HRDATA_tb_exp;
  
  begin
    #((tp/2)-st)
    
  HRESETn_tb = HRESETn_tb_t;
  HREADY_tb = HREADY_tb_t;
  HRESP_tb= HRESP_tb_t;
  wr_tb = wr_tb_t;
  maddr_tb = maddr_tb_t;
  data_tb = data_tb_t;
  burst_tb = burst_tb_t;
  size_tb = size_tb_t;
  trans_tb = trans_tb_t;
  
  //@(posedge HCLK_tb)
  
    /*#(ht)
  
  HRESETn_tb = 1'b0;
  HREADY_tb = 1'b0;
  wr_tb = 1'b0;
  maddr_tb = 32'b00000000;
  data_tb = 32'b00000000;
  burst_tb = 3'b000;
  size_tb = 3'b000;
  trans_tb = 2'b00;
  */
  //
  #(ht)
  
  HRESETn_tb = 1'b1;
  HREADY_tb = 1'b1;
  HRESP_tb=1'b0;
  wr_tb = 1'b1;
  maddr_tb = 32'b00110100;
  data_tb = 32'b10101010;
  burst_tb = 3'b010;
  size_tb = 3'b010;
  trans_tb = 2'b00;
  
   #(ht)
  HRESETn_tb = 1'b1;
  HREADY_tb = 1'b1;
  HRESP_tb=1'b0;
  wr_tb = 1'b1;
  maddr_tb = 32'b00110100;
  data_tb = 32'b10101010;
  burst_tb = 3'b010;
  size_tb = 3'b010;
  trans_tb = 2'b01;
   
   
  #(ht)
  
  HRESETn_tb = 1'b1;
  HREADY_tb = 1'b1;
  HRESP_tb=1'b0;
  wr_tb = 1'b1;
  maddr_tb = 32'b00110100;
  data_tb = 32'b10101010;
  burst_tb = 3'b010;
  size_tb = 3'b010;
  trans_tb = 2'b11;
  
  #(ht)
  
  HRESETn_tb = 1'b1;
  HREADY_tb = 1'b1;
  HRESP_tb=1'b0;
  wr_tb = 1'b0;
  maddr_tb = 32'b00110100;
  data_tb = 32'b10101010;
  burst_tb = 3'b010;
  size_tb = 3'b010;
  trans_tb = 2'b11;
  
  #(ht)
  
  HRESETn_tb = 1'b1;
  HREADY_tb = 1'b1;
  HRESP_tb=1'b0;
  wr_tb = 1'b1;
  maddr_tb = 32'b00110100;
  data_tb = 32'b10101010;
  burst_tb = 3'b010;
  size_tb = 3'b010;
  trans_tb = 2'b11;
  
   #(ht)
  
  HRESETn_tb = 1'b1;
  HREADY_tb = 1'b1;
  HRESP_tb=1'b0;
  wr_tb = 1'b0;
  maddr_tb = 32'b00110100;
  data_tb = 32'b10101010;
  burst_tb = 3'b010;
  size_tb = 3'b010;
  trans_tb = 2'b11;
  
  #(ht)
  
  HRESETn_tb = 1'b1;
  HREADY_tb = 1'b1;
  HRESP_tb=1'b0;
  wr_tb = 1'b1;
  maddr_tb = 32'b01010100;
  data_tb = 32'b10101010;
  burst_tb = 3'b010;
  size_tb = 3'b010;
  trans_tb = 2'b11;
  
  #(ht)
  
  HRESETn_tb = 1'b1;
  HREADY_tb = 1'b1;
  HRESP_tb=1'b0;
  wr_tb = 1'b0;
  maddr_tb = 32'b01010100;
  data_tb = 32'b10101010;
  burst_tb = 3'b010;
  size_tb = 3'b010;
  trans_tb = 2'b11;
  
   #(ht)
  
  HRESETn_tb = 1'b1;
  HREADY_tb = 1'b1;
  HRESP_tb=1'b0;
  wr_tb = 1'b1;
  maddr_tb = 32'b10010100;
  data_tb = 32'b10101010;
  burst_tb = 3'b010;
  size_tb = 3'b010;
  trans_tb = 2'b11;
  
   #(ht)
  
  HRESETn_tb = 1'b1;
  HREADY_tb = 1'b1;
  HRESP_tb=1'b0;
  wr_tb = 1'b0;
  maddr_tb = 32'b10010100;
  data_tb = 32'b10101010;
  burst_tb = 3'b010;
  size_tb = 3'b010;
  trans_tb = 2'b11;
  
     if(HWDATA_tb_exp==HWDATA_tb && HRDATA_tb_exp==HRDATA_tb)
       $display("HWDATA EXP=%b HWDATA TB=%b and HRDATA_tb_exp=%b HRDATA_tb=%b   MATCHED ",HWDATA_tb_exp,HWDATA_tb,HRDATA_tb_exp,HRDATA_tb);
     else
     $display("HWDATA EXP=%b HWDATA TB=%b and HRDATA_tb_exp=%b HRDATA_tb=%b    NOT MATCHED ",HWDATA_tb_exp,HWDATA_tb,HRDATA_tb_exp,HRDATA_tb);
end
endtask
endmodule