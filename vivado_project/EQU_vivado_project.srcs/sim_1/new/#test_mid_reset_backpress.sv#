class test_rand_coeff_backpress_mid_reset extends test_rand_coeff_backpress;
   
   `uvm_component_utils(test_rand_coeff_backpress_mid_reset)

   function new(string name = "test_rand_coeff_backpress_mid_reset", uvm_component parent = null);
      super.new(name, parent);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      factory.set_type_override_by_type(driver_backpress::get_type(), driver_mid_reset_backpress::get_type());
      
   endfunction // build_phase

endclass

