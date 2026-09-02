module ahbslav(HSEL,HADDR,HWRITE,HSIZE,HTRANS,HBURST,HREADY,HWDATA,HREADYOUT,HRESP,HRDATA,HRESETn,HCLK);
 
  input HSEL;
  input HWRITE,HREADY;
  input HRESETn,HCLK;
  input [31:0]HWDATA;
  input [31:0]HADDR;
  input [2:0]HBURST;
  input [2:0]HSIZE;
  input [1:0]HTRANS;
  
  output reg HREADYOUT,HRESP;
  output reg [31:0]HRDATA;

  reg hburst;
  reg[31:0]temp_addr;
  reg [31:0]c1[0:1023];
  
always @(posedge HCLK) begin 
   if(HRESETn==0 && HREADY==0) begin 
              HRESP=1'bx; 
              HREADYOUT=1'bx;
            end
   else begin 
      if(HRESETn==1 && HREADY==1 && HSEL==1)begin//write 
             if(HTRANS==2'b00) begin// Idle
                temp_addr=32'bz; 
                if(HWRITE==0)begin    
                 HRDATA=32'b0;  
                 HRESP=1; 
                 HREADYOUT=0;  
                 end 
              end
             else if(HTRANS==2'b01) begin//busy
                 temp_addr=HADDR;
                 if(HWRITE==0) begin
                  HRDATA=32'bz;
                  HRESP=0;
                  HREADYOUT=0;
              end
            end         
            else if(HTRANS==2'b10)begin//non sequential
                temp_addr=HADDR;
                 if(HWRITE==0)begin
                  c1[temp_addr]=HWDATA;
                  //else begin 
                  HRDATA=c1[temp_addr];
                  HRESP=0;
                  HREADYOUT=1;
               end
                end
            else begin
                  hburst=1;
                  if(HWRITE==0) begin
                  temp_addr=HADDR;
                  c1[temp_addr]=HWDATA; 
                 // else begin
                  HRDATA=c1[temp_addr];
                  HRESP=0;
                  HREADYOUT=1;
            end
           end
       end
      end
  end
endmodule