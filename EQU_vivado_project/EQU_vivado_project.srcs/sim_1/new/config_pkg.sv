`define  FXD_POINT_COEFF (1 << COEFF_FRAC_WIDTH)

package config_pkg;

   localparam INPUT_TAPS = 3;
   localparam OUTPUT_TAPS = 2;
   localparam DATA_WIDTH = 24;
   localparam COEFF_FRAC_WIDTH = 30;
   localparam COEFF_WIDTH = COEFF_FRAC_WIDTH + 3;
   localparam DATA_FRAC_WIDTH = 0;   
   
endpackage
