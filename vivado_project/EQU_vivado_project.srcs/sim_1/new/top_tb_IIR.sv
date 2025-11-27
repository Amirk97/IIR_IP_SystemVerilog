
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 07/15/2025 07:04:52 PM
// Design Name:
// Module Name: tb_IIR
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
import config_pkg::*;

module top_tb_IIR;

//   logic clk, rst;

   IIR #(
         .INPUT_TAPS  (config_pkg::INPUT_TAPS),
         .OUTPUT_TAPS (config_pkg::OUTPUT_TAPS),
         .DATA_WIDTH  (config_pkg::DATA_WIDTH),
         .COEFF_WIDTH (config_pkg::COEFF_WIDTH),
         .DATA_FRAC_WIDTH (config_pkg::DATA_FRAC_WIDTH), 
         .COEFF_FRAC_WIDTH (config_pkg::COEFF_FRAC_WIDTH),
         .PROCESS_DELAY(config_pkg::PROCESS_DELAY)
         )
   IIR_inst (
             .x_i(IIR_if_inst.dut.x_i),
             .y_o(IIR_if_inst.dut.y_o),
             .coeff_x_i(IIR_if_inst.dut.coeff_x_i),
             .coeff_y_i(IIR_if_inst.dut.coeff_y_i),
             .valid_i(IIR_if_inst.dut.valid_i),
             .ready_and_o(IIR_if_inst.dut.ready_and_o),
             .valid_o(IIR_if_inst.dut.valid_o),
             .ready_and_i(IIR_if_inst.dut.ready_and_i),
             .clk_i(IIR_if_inst.dut.clk_i),
             .rst_i(IIR_if_inst.dut.rst_i));

   
   IIR_if #(
            .INPUT_TAPS  (config_pkg::INPUT_TAPS),
            .OUTPUT_TAPS (config_pkg::OUTPUT_TAPS),
            .DATA_WIDTH  (config_pkg::DATA_WIDTH),
            .COEFF_WIDTH (config_pkg::COEFF_WIDTH),
            .DATA_FRAC_WIDTH (config_pkg::DATA_FRAC_WIDTH), 
            .COEFF_FRAC_WIDTH (config_pkg::COEFF_FRAC_WIDTH),
            .PROCESS_DELAY(config_pkg::PROCESS_DELAY)
            )
   IIR_if_inst();

   bind IIR IIR_sva #(
                      .PROCESS_DELAY(config_pkg::PROCESS_DELAY))
   IIR_sva_inst(
                .valid_i(IIR_if_inst.valid_i),
                .ready_and_o(IIR_if_inst.ready_and_o),
                .valid_o(IIR_if_inst.valid_o),
                .ready_and_i(IIR_if_inst.ready_and_i),
                .clk_i(IIR_if_inst.clk_i),
                .rst_i(IIR_if_inst.rst_i));

   initial IIR_if_inst.clk_i = '0;
   always #5 IIR_if_inst.clk_i = ~IIR_if_inst.clk_i;      

   initial begin
      uvm_config_db#(virtual IIR_if)::set(null, "*", "if", IIR_if_inst);
      run_test("my_test");
   end   

   initial begin
      IIR_if_inst.rst_i <= 1'b0;
      repeat(2) @(posedge IIR_if_inst.clk_i);
      IIR_if_inst.rst_i <= 1'b1;
      `uvm_info("RSTDRV","Reset was released here!", UVM_MEDIUM);    
   end

endmodule
