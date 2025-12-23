module IIR_sva #(
                 parameter PROCESS_DELAY)
   (
    input logic valid_i,
    input logic ready_and_o,

    input logic valid_o,
    input logic ready_and_i,

    input logic clk_i,
    input logic reset_i);

   property latency_without_traffic;
      @(posedge clk_i) disable iff (reset_i)
        (ready_and_o && valid_i) ##(PROCESS_DELAY-1) ~valid_o |=> ##1 valid_o;      
   endproperty

   assert property (latency_without_traffic)
     else `uvm_error("LATENCY_ASRT","Latency was not abided")

endmodule
