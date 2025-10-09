`include "uvm_macros.svh"
import uvm_pkg::*;
import config_pkg::*;

package basic_sequence_item;

import "DPI-C" function void dpi_get_coeff (int idx, output real arr[],  output real arr2[]);
   
   typedef struct {
      real input_coeff[INPUT_TAPS];
	    real output_coeff[OUTPUT_TAPS];
   } coeff_struct;
   
   class basic_sequence_item #(
                               parameter INPUT_TAPS = config_pkg::INPUT_TAPS,
                               parameter OUTPUT_TAPS = config_pkg::OUTPUT_TAPS,
                               parameter DATA_WIDTH = config_pkg::DATA_WIDTH,
                               parameter COEFF_WIDTH = config_pkg::COEFF_WIDTH,
                               parameter DATA_FRAC_WIDTH = config_pkg::DATA_FRAC_WIDTH, 
                               parameter COEFF_FRAC_WIDTH = config_pkg::COEFF_FRAC_WIDTH,
                               localparam logic unsigned [COEFF_FRAC_WIDTH:0] FXD_POINT_COEFF = 1 << COEFF_FRAC_WIDTH
                               )
      extends uvm_sequence_item;

      `uvm_object_utils(basic_sequence_item)

      typedef logic signed [COEFF_WIDTH-1:0]   coeff_t;
      
      rand logic signed [DATA_WIDTH-1:0] x_i;

      coeff_t coeff_x_i [0:INPUT_TAPS-1];
	    coeff_t coeff_y_i [0:OUTPUT_TAPS-1];

      coeff_struct coeff_double;
      
      rand int coeff_index = 0;
      int      prev_coeff_index = 0; //Used in child classes for randomizing the coeff_index
      rand bit enable_change;

      logic [DATA_WIDTH-1:0]          y_o;      

      function new (string name = "basic_sequence_item");
         super.new(name);
      endfunction

      function void post_randomize();

         prev_coeff_index = coeff_index;

         `uvm_info("ITEM",
                   $sformatf("Recieved Coeff_index: %d", coeff_index),
                   UVM_MEDIUM)

         dpi_get_coeff(coeff_index, coeff_double.input_coeff, coeff_double.output_coeff);

         for(int i=0; i< INPUT_TAPS; i++) begin 
            coeff_x_i[i] =  coeff_t'(coeff_double.input_coeff[i] * FXD_POINT_COEFF);
            `uvm_info("ITEM",
                      $sformatf("Recieved Input_coeff[%d]: %f", i, coeff_double.input_coeff[i]),
                      UVM_MEDIUM)

         end

         for(int i=0; i< OUTPUT_TAPS; i++) begin
            coeff_y_i[i] =  coeff_t'(coeff_double.output_coeff[i] * FXD_POINT_COEFF);
         end

      endfunction

   endclass

endpackage
