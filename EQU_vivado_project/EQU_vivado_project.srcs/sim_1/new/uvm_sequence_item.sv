`include "uvm_macros.svh"
import uvm_pkg::*;
import config_pkg::*;

package basic_sequence_item;

`define  FXD_POINT_COEFF (1 << 20)

   class basic_sequence_item # (
                                parameter INPUT_TAPS  = config_pkg::INPUT_TAPS,
                                parameter OUTPUT_TAPS = config_pkg::OUTPUT_TAPS,
                                parameter DATA_WIDTH  = config_pkg::DATA_WIDTH,
                                parameter COEFF_WIDTH = config_pkg::COEFF_WIDTH)
      extends uvm_sequence_item;

      `uvm_object_utils(basic_sequence_item)

      typedef logic [COEFF_WIDTH-1:0]   coeff_t;

      rand logic signed [DATA_WIDTH-1:0] x_i;

      rand coeff_t coeff_x_i [0:INPUT_TAPS-1];
	    rand coeff_t coeff_y_i [0:OUTPUT_TAPS-1];
      
      logic [DATA_WIDTH-1:0]          y_o;      

      constraint coeff_x_fixed {
         coeff_x_i[0] == coeff_t'(1.0 * `FXD_POINT_COEFF);
         coeff_x_i[1] == coeff_t'(-1.8836532429909993 * `FXD_POINT_COEFF);
         coeff_x_i[2] == coeff_t'(0.8900591334898765 * `FXD_POINT_COEFF); 
      }

      constraint coeff_y_fixed {
         coeff_y_i[0] ==  coeff_t '(-1.8836532429909993 * `FXD_POINT_COEFF);
         coeff_y_i[1] ==    coeff_t '(0.8900591334898765 * `FXD_POINT_COEFF);
      }


      function new (string name = "basic_sequence_item");
         super.new(name);
      endfunction

   endclass

endpackage
