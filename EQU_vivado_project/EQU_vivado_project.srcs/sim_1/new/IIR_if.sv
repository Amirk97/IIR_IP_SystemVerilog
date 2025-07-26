interface IIR_if # (
                    parameter INPUT_TAPS = 3,
                    parameter OUTPUT_TAPS = 2,
                    parameter DATA_WIDTH = 24,
                    parameter COEFF_WIDTH = 18)
   (
    input logic clk_i,
    input logic rst_i);

   logic [DATA_WIDTH-1:0]  x_i;
   logic [DATA_WIDTH-1:0]  y_o;

   logic [COEFF_WIDTH-1:0] coeff_x_i [0:INPUT_TAPS]; 
   logic [COEFF_WIDTH-1:0] coeff_y_i [0:OUTPUT_TAPS-1]; 

   logic                   data_READY;
   logic                   data_DONE;

   modport tb (
                 output  x_i,
                 input  y_o,

                 output  coeff_x_i , 
                 output  coeff_y_i , 
                
                 output  data_READY,
                 input data_DONE,

                 input clk_i,
                 input rst_i
              );

   modport dut (
                 input  x_i,
                 output y_o,

                 input  coeff_x_i , 
                 input  coeff_y_i , 
                
                 input  data_READY,
                 output data_DONE,

                 input clk_i,
                 input rst_i
                );

endinterface
