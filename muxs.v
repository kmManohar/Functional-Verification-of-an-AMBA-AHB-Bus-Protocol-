module muxs(HCLK,HRESETn,HREADY,HRDATA1,HRDATA2,HRDATA3,HSEL1,HSEL2,HSEL3,
        HRESP1,HRESP2,HRESP3,HREADYOUT1,HREADYOUT2,HREADYOUT3,HREADYOUT,HRDATA,HRESP);
  
  input HCLK,HRESETn,HREADY;
  input HSEL1;
  input HSEL2;
  input HSEL3;
  input HREADYOUT1,HREADYOUT2,HREADYOUT3;
  input HRESP1,HRESP2,HRESP3;
  input [31:0]HRDATA1;
  input [31:0]HRDATA2;
  input [31:0]HRDATA3;
 
  output reg [31:0]HRDATA;
  output reg HREADYOUT;
  output reg HRESP;
  
always @(posedge HCLK) begin
       if(HRESETn==1 && HREADY==1) begin
             if(HSEL1==1) begin
                   HRESP=HRESP1;
                   HREADYOUT=HREADYOUT1;
                   HRDATA=HRDATA1;
              end
              else if(HSEL2==1) begin
                   HRESP=HRESP2;
                   HREADYOUT=HREADYOUT2;
                   HRDATA=HRDATA2;
              end
              else if(HSEL3==1) begin
                   HRESP=HRESP3;
                   HREADYOUT=HREADYOUT3;
                   HRDATA=HRDATA3;
              end
              else begin
                  HRDATA=32'bz;
                  HRESP=1'bz;
                  HREADYOUT=1'bz;
              end
            end
          else begin
                  HRDATA=32'bz;
                  HRESP=1'bz;
                  HREADYOUT=1'bz;
          end
      end
endmodule