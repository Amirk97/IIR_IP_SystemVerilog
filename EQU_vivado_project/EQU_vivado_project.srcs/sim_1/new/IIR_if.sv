interface IIR_if # (
                    parameter INPUT_TAPS = config_pkg::INPUT_TAPS,
                    parameter OUTPUT_TAPS = config_pkg::OUTPUT_TAPS,
                    parameter DATA_WIDTH = config_pkg::DATA_WIDTH,
                    parameter COEFF_WIDTH = config_pkg::COEFF_WIDTH,
                    parameter DATA_FRAC_WIDTH = config_pkg::DATA_FRAC_WIDTH, 
                    parameter COEFF_FRAC_WIDTH = config_pkg::COEFF_FRAC_WIDTH,
                    parameter PROCESS_DELAY = config_pkg::PROCESS_DELAY);

   logic [DATA_WIDTH-1:0]  x_i;
   logic [DATA_WIDTH-1:0]  y_o;

   int coeff_index;   
   logic signed [COEFF_WIDTH-1:0] coeff_x_i [0:INPUT_TAPS-1]; 
   logic signed [COEFF_WIDTH-1:0] coeff_y_i [0:OUTPUT_TAPS-1]; 

   logic                   valid_i;
   logic                   ready_and_o;

   logic                   valid_o;   
   logic                   ready_and_i;

   logic                   clk_i;   
   logic                   rst_i;
   
   modport tb (
               output x_i,
               input  y_o,

               output coeff_x_i , 
               output coeff_y_i , 
   
               output valid_i,
               input  ready_and_o,

               input  valid_o,
               output ready_and_i,

               output  clk_i,
               output  rst_i
               );

   modport dut (
                 input  x_i,
                 output y_o,

                 input  coeff_x_i , 
                 input  coeff_y_i , 
                
                 input  valid_i,
                 output ready_and_o,

                 output valid_o,
                 input  ready_and_i,

                 input  clk_i,
                 input  rst_i
                );

endinterface
