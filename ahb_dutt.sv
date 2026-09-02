module ahb_dutt(ahb_inff.dut intf);
  ahbtop dut (.HRESETn_tb(intf.HRESETn_tb),.HCLK_tb(intf.HCLK),.HREADY_tb(intf.HREADY_tb),.wr_tb(intf.wr_tb),
  .HRESP_tb(intf.HRESP_tb),.maddr_tb(intf.maddr_tb),.data_tb(intf.data_tb),.burst_tb(intf.burst_tb),
  .size_tb(intf.size_tb),.trans_tb(intf.trans_tb),.HWDATA_tb(intf.HWDATA_tb),.HRDATA_tb(intf.HRDATA_tb));

/*
property p1;
  @(posedge intf.HCLK) intf.wr_tb ##60 !intf.wr_tb;
  endproperty
  L1: assert property (p1) else $error("FAILED");
  
  property p2; 
  @(posedge intf.HCLK) disable iff((intf.burst_tb==3'b000) && (intf.size_tb==3'b000) && (intf.trans_tb=2'b00))
  $rose(intf.wr_tb);
  endproperty
  L2: assert property (p2) else $error("FAILED2");

  property p3;
  @(posedge intf.HCLK) intf.wr_tb |->(intf.HWDATA_tb==intf.HRDATA_tb);
  endproperty
  L3: assert property (p3) else $error("FAILED3");
  */
endmodule