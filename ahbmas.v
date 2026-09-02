module ahbmas(wr,size,burst,trans,maddr,HRESETn,HCLK,HREADY,HRESP,HRDATA,
                  HWRITE,HTRANS,HSIZE,HWDATA,HADDR,HBURST);

input HREADY,HRESETn,HCLK,wr;
input HRESP;
input [31:0]HRDATA;
input [31:0]maddr;
input [2:0]burst;
input [2:0]size;
input [1:0]trans;

output reg HWRITE;
output reg [1:0]HTRANS;
output reg [2:0]HSIZE;
output reg [2:0]HBURST;
output reg [31:0]HWDATA;
output reg [31:0]HADDR;
reg [7:0]bytes;
reg [4:0]burstsize;
reg [7:0]ba;
reg [7:0]ba1;
reg [3:0]count=0;
reg [3:0]a;
reg [4:0]b;
reg [5:0]c;
reg [31:0]temp_addr;
reg [31:0]temp_data;
reg hburst;
 
always @(posedge HCLK) begin
case(HSIZE)
        3'b000:begin  bytes=8'd1;   end   // BYTE
        3'b001:begin  bytes=8'd2;   end   // HALFWORD
        3'b010:begin  bytes=8'd4;   end   // WORD
        3'b011:begin  bytes=8'd8;   end   // DOUBLEWORD 
        3'b100:begin  bytes=8'd16;  end   // 4-WORD LINE
        3'b101:begin  bytes=8'd32;  end   // 8-WORD LINE
        3'b110:begin  bytes=8'd64;  end    // 16-WORD LINE
        3'b111:begin  bytes=8'd128; end    // 32-WORD LINE
        default: bytes= 8'd0;
     endcase
end
always@(posedge HCLK) begin
case(HBURST)
  3'b000:burstsize=5'd0;//single
  3'b001:burstsize=5'd1;//increment
  3'b010:burstsize=5'h4;//wrap4
  3'b011:burstsize=5'd4;//incr4
  3'b100:burstsize=5'd8;//wrap8
  3'b101:burstsize=5'd8;//incr8
  3'b110:burstsize=5'd16;//wrap16
  3'b111:burstsize=5'd16;//incr16
  default:burstsize=5'd0;
endcase
end

always @(posedge HCLK) begin                         
        if(HRESETn==0)begin 
              HADDR=32'bz;     
              HWDATA=32'bz; 
              temp_addr=maddr;
        end
        else begin
            HBURST=burst;
            HSIZE=size;
            HTRANS=trans;
            temp_data=HRDATA; 
            HWDATA=temp_data;
            HWRITE=wr;
        end
end

always@(posedge HCLK) begin 
   if(HREADY==0&&HWRITE==0) //begin 
              HWDATA=32'b0; 
   else begin 
        HWDATA=HRDATA;
        if(HTRANS==2'b00) begin// Idle
             if(HRESP==0) begin
                HADDR=32'bz;   
           //@(posedge HCLK)
               HWDATA=32'b0;
             end
        end      
        else if(HTRANS==2'b01) begin//busy
             if (HRESP==0) begin       
               HADDR=maddr; 
               HWDATA=32'bz;
              end
        end
        else if(HTRANS==2'b10)begin//non sequential
            if (HRESP==0) begin
            temp_addr=maddr;
            HADDR=temp_addr;           
            HWDATA=HRDATA;
            end
          end
        else if(HTRANS==2'b11)begin//sequential
                  if(HRESP==0)
                  hburst=1;
        end
      end
  end
  
always @(posedge HCLK) begin
  if(hburst==1 && HREADY==1)begin
     ba=(bytes*burstsize);
     ba1=(ba-bytes);

 $display($time,"ba=%d,ba1=%d,burstsize=%d,bytes=%d,HADDR=%h,maddr=%h,HSIZE=%d,HBURST=%d,count =%d,temp_addr is %h,HRDATA=%h,HWDATA=%h",
 ba,ba1,burstsize,bytes,HADDR,maddr,HSIZE,HBURST,count,temp_addr,HRDATA,HWDATA);

  case(HBURST)
    3'b000:begin   // fixed
      HADDR=temp_addr;
      if(HWRITE==1)
      HWDATA=HRDATA;
    end
    3'b001:begin   //incr
      HADDR=temp_addr+maddr;
      temp_data=temp_data+bytes;
     if(HWRITE==1)
     HWDATA=temp_data;
    end
    3'b010:begin   // wrap4
            if(count<burstsize) begin
                if(temp_addr[3:0]==4'hc) begin                         
                     temp_addr={temp_addr[31:4],4'b0};
                     HADDR=temp_addr;
                     if(HWRITE==1)
                     HWDATA=temp_data;
                     count=count+1;
                     $display($time," temp_data is %h",temp_addr);
                     $display($time,"in compare state HADDR is %h,count=%d",HADDR,count);
                end
               else begin
                      a=temp_addr[3:0]+bytes;
                      temp_addr={temp_addr[31:4],a};
                      HADDR=temp_addr;
                       if(HWRITE==1)
                      HWDATA=HRDATA;
                      count=count+1;
                end
 	 	      end
          else begin
              a=temp_addr[3:0]+bytes;
              temp_addr={temp_addr[31:4],a};
              HADDR=temp_addr;
              if(HWRITE==1)
              HWDATA=HRDATA;
              count=4'b0;
              end
          end
    3'b011: begin// incr4
            if(count<burstsize)begin
               temp_addr=temp_addr+bytes;
               HADDR=temp_addr; 
               temp_data=temp_data+bytes;
               if(HWRITE==1)
               HWDATA=temp_data; 
               count=count+1;
               $display($time," temp_addr is  temp_addr=%h",temp_addr);
               $display($time," HADDR is %h",HADDR);
           end  
           else begin
                count=0;
                temp_addr=temp_addr+bytes;
                HADDR=temp_addr;
                temp_data=temp_data+bytes;
                if(HWRITE==1)
                HWDATA=temp_data; 
              end
          end
    3'b100: begin   // wrap8
            if(count<burstsize)begin
                 if(temp_addr[4:0]==5'h1c)begin
                     temp_addr={temp_addr[31:5],5'b0};
                     HADDR=temp_addr;
                     if(HWRITE==1)
                       HWDATA=HRDATA;
                     count=count+1;
                      $display($time,"in compare state ,HADDR is %h,count=%d",HADDR,count);
                    end
                  else begin
                      b=temp_addr[4:0]+bytes;
                      temp_addr={temp_addr[31:5],b};
                      HADDR=temp_addr;
                      if(HWRITE==1)
                      HWDATA=HRDATA;
                      count=count+1;
                     end
   	 	            end
            else begin
                b=temp_addr[4:0]+bytes;
                temp_addr={temp_addr[31:5],b};
                HADDR=temp_addr;
                if(HWRITE==1)
                HWDATA=HRDATA;
                count=4'b0;
                end
           end
      3'b101: begin// incr8
              if(count<burstsize)begin
                  temp_addr=temp_addr+bytes;
                  HADDR=temp_addr;
                  temp_data=temp_data+bytes;
                  if(HWRITE==1)
                  HWDATA=temp_data;
                  count=count+1;
                  $display($time," temp_addr is temp_addr=%h",temp_addr);
                  $display($time," HADDR is %h",HADDR);
                end  
               else begin
                  temp_addr=temp_addr+bytes;
                  HADDR=temp_addr;
                  temp_data=temp_data+bytes;
                  if(HWRITE==1)
                  HWDATA=temp_data;
                  count=4'b0;
                  end 
               end
      3'b110:begin   // wrap16
             if(count<burstsize)begin
                  if(temp_addr[5:0]==6'h3c)begin
                        temp_addr={temp_addr[31:6],6'b0};
                        HADDR=temp_addr;
                        if(HWRITE==1)
                        HWDATA=HRDATA;
                        count=count+1;
                       $display($time,"in compare state HADDR is %h,count=%d",HADDR,count);
                    end
                  else begin
                        c=temp_addr[5:0]+bytes;
                        temp_addr={temp_addr[31:6],c};
                        HADDR=temp_addr;
                        if(HWRITE==1)
                        HWDATA=HRDATA;
                        count=count+1;
                        $display($time," temp_addr=%h ,c is %h",temp_addr,c);
                        $display($time,"HADDR is %h",HADDR);
                        end
   	 	            end
              else begin
                    c=temp_addr[4:0]+bytes;
                    temp_addr={temp_addr[31:6],c};
                    HADDR=temp_addr;
                    HWDATA=HRDATA;
                    count=4'b0;
                  end
              end
      3'b111:begin // incr16
             if(count<burstsize)begin
                temp_addr=temp_addr+bytes;
                HADDR=temp_addr;
                temp_data=temp_data+bytes;
                if(HWRITE==1)
                HWDATA=temp_data;
                count=count+1;
                $display($time," temp_addr=%h",temp_addr);
                $display($time," HADDR is %h",HADDR);
                end  
              else begin
                  temp_addr=temp_addr+bytes;
                  HADDR=temp_addr;
                  temp_data=temp_data+bytes;
                  if(HWRITE==1)
                  HWDATA=temp_data;
                  count=0;
                  end
            end        
endcase
end 
end
endmodule