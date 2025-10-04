module IIR_sva(
                  input logic valid_i,
                  input logic ready_and_o,

                  input logic valid_o,
                  input logic ready_and_i,

                  input logic clk_i,
                  input logic rst_i);


   
   property latency_without_traffic;
      @(posedge clk_i) disable iff (~rst_i)
        (ready_and_o && valid_i) ##1 ~valid_o |=> ##1 valid_o;      
   endproperty

//   property latency_with_traffic;
//      @(posedge clk_i) disable iff (~rst_i)
//        (ready_and_o && valid_i) ##[1:$] ~valid_o |=> ##1 valid_o;      
//   endproperty

   assert property (latency_without_traffic)
     else `uvm_error("LATENCY_ASRT","Latency was not abided")

//   assert property (latency_with_traffic)
//     else `uvm_error("LATENCY_ASRT","Latency was not abided")

endmodule
