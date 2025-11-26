class test_const_coeff extends my_test;

   `uvm_component_utils(test_const_coeff)

   function new(string name = "test_const_coeff", uvm_component parent = null);
      super.new(name, parent);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      factory.set_type_override_by_type(basic_sequence_item#()::get_type(), const_coeff_item::get_type());

   endfunction // build_phase

endclass
