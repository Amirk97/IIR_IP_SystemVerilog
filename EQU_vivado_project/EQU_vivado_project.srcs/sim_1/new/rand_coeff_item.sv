import basic_sequence_item::*;

class rand_coeff_item extends basic_sequence_item#();

   `uvm_object_utils(rand_coeff_item)

   constraint change_rand {
      enable_change dist {1 :=10, 0 := 90};
   }

   constraint coeff_rand {
      if (!enable_change) coeff_index == prev_coeff_index;
      else coeff_index inside {[0:24]};
   }

   function new (string name = "rand_coeff_item");
      super.new(name);
   endfunction

endclass
