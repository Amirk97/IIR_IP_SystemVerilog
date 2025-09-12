
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

   logic clk, rst;

   initial clk = '0;   
   always #5 clk = ~clk;      

   IIR #(
         .INPUT_TAPS  (config_pkg::INPUT_TAPS),
         .OUTPUT_TAPS (config_pkg::OUTPUT_TAPS),
         .DATA_WIDTH  (config_pkg::DATA_WIDTH),
         .COEFF_WIDTH (config_pkg::COEFF_WIDTH),
         .DATA_FRAC_WIDTH (config_pkg::DATA_FRAC_WIDTH), 
         .COEFF_FRAC_WIDTH (config_pkg::COEFF_FRAC_WIDTH)
         )
   IIR_inst (
             .x_i(IIR_if_inst.dut.x_i),
             .y_o(IIR_if_inst.dut.y_o),
             .coeff_x_i(IIR_if_inst.dut.coeff_x_i),
             .coeff_y_i(IIR_if_inst.dut.coeff_y_i),
             .data_READY(IIR_if_inst.dut.data_READY),
             .data_DONE(IIR_if_inst.dut.data_DONE),
             .clk_i(IIR_if_inst.dut.clk_i),
             .rst_i(IIR_if_inst.dut.rst_i)
             );

   
   IIR_if #(
            .INPUT_TAPS  (config_pkg::INPUT_TAPS),
            .OUTPUT_TAPS (config_pkg::OUTPUT_TAPS),
            .DATA_WIDTH  (config_pkg::DATA_WIDTH),
            .COEFF_WIDTH (config_pkg::COEFF_WIDTH),
            .DATA_FRAC_WIDTH (config_pkg::DATA_FRAC_WIDTH), 
            .COEFF_FRAC_WIDTH (config_pkg::COEFF_FRAC_WIDTH)
            )
   IIR_if_inst (
                .clk_i(clk),
                .rst_i(rst));

   initial begin
      uvm_config_db#(virtual IIR_if)::set(null, "*", "if", IIR_if_inst);
      run_test("my_test");
   end

   initial begin
      rst <= 1'b0;
      repeat(2) @(posedge clk);
      rst <= 1'b1;
      `uvm_info("RSTDRV","Reset was released here!", UVM_MEDIUM);    
   end

endmodule
