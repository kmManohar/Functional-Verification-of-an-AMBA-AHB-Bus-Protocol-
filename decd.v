module decd(HCLK,HADDR,HSEL1,HSEL2,HSEL3);
  input HCLK;
  input [31:0]HADDR;
   output reg HSEL1,HSEL2,HSEL3;
   
   
   
/*always @(posedge HCLK) begin
   if(HADDR>32'b00000000 || HADDR<32'b01000000)
    HSEL1=1;
   else if(HADDR>32'b01000000 || HADDR<32'b01100000)
    HSEL2=1;
   else if (HADDR>32'b01100000 || HADDR<32'b11000000)
      HSEL3=1;
   else begin
   HSEL1=1'bx;
   HSEL2=1'bx;  
   HSEL3=1'bx;
   end     
end
endmodule   
 */
always @(posedge HCLK) begin
       
       case(HADDR[15:0])
       16'h0034:begin
                 HSEL1=1;
                 end
       16'h0054: begin
                 HSEL2=1;
                 end
       16'h0094:begin
                 HSEL3=1;
                 end
       endcase
       end
endmodule