`include "uvm_macros.svh"
import uvm_pkg::*;

package basic_sequence_item;

`define  FXD_POINT_COEFF (1 << 15)

   class basic_sequence_item # (
                                parameter INPUT_TAPS = 3,
                                parameter OUTPUT_TAPS = 2,
                                parameter DATA_WIDTH = 24,
                                parameter COEFF_WIDTH = 18)
      extends uvm_sequence_item;

      `uvm_object_utils(basic_sequence_item)

      rand logic signed [DATA_WIDTH-1:0] x_i;
      typedef logic [COEFF_WIDTH-1:0]   coeff_t;

      logic [COEFF_WIDTH-1:0]            coeff_x_i [0:INPUT_TAPS-1] = '{coeff_t'(1.0 * `FXD_POINT_COEFF),
                                                                        coeff_t'(1.8836532429909993 * `FXD_POINT_COEFF),
                                                                        coeff_t'(0.8900591334898765 * `FXD_POINT_COEFF)};
      
	    logic [COEFF_WIDTH-1:0] coeff_y_i [0:OUTPUT_TAPS-1] = '{ coeff_t '(1.8836532429909993 * `FXD_POINT_COEFF),
                                                               coeff_t '(0.8900591334898765 * `FXD_POINT_COEFF)};
      
      logic [DATA_WIDTH-1:0]    y_o;

      function new (string name = "basic_sequence_item");
         super.new(name);
      endfunction

   endclass

endpackage
