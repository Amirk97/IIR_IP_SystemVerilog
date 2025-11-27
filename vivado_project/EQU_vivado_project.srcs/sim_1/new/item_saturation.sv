
class item_saturation extends basic_sequence_item#();

   `uvm_object_utils(item_saturation)

   constraint coeff_fixed {
      coeff_index == 1;
   }

   constraint input_saturated {
      x_i dist {-(1<<(DATA_WIDTH-1)) := 50 , ((1<<(DATA_WIDTH-1))-1) := 50};
   }

   function new (string name = "item_saturation");
      super.new(name);
   endfunction

endclass
