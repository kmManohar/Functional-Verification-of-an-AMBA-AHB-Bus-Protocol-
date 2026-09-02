module ahb_topp();
  bit HCLK;

  initial begin
    forever #5 HCLK=~HCLK;
  end

  ahb_inff inf(HCLK);
  ahb_dutt dut(inf);
  ahb_tbb tb(inf);
  
endmodule