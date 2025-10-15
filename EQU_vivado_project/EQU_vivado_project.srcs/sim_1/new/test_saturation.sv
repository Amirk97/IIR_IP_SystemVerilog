class test_saturation extends my_test;

   `uvm_component_utils(test_saturation)


   function new(string name = "test_saturation", uvm_component parent = null);
      super.new(name, parent);
      NUMBER_OF_TESTS = 5;   
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      factory.set_type_override_by_type(basic_sequence_item#()::get_type(), item_saturation::get_type());

   endfunction // build_phase

endclass
