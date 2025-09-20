import basic_sequence_item::*;

class const_coeff_item extends basic_sequence_item#();

   `uvm_object_utils(const_coeff_item)

   constraint coeff_fixed {
      coeff_index == 0;
   }

   function new (string name = "basic_sequence_item");
      super.new(name);
   endfunction

endclass
