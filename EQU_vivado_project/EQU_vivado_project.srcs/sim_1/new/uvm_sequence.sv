import basic_sequence_item::*;

class my_sequence extends uvm_sequence #(basic_sequence_item#());

   `uvm_object_utils(my_sequence)

   int NUMBER_OF_TESTS;
   
   function new (string name = "my_sequence");
      super.new(name);
   endfunction

   task body();
      basic_sequence_item#() item;

      assert(uvm_config_db#(int)::get(null, "*", "NUMBER_OF_TESTS", NUMBER_OF_TESTS));
      item = basic_sequence_item#()::type_id::create("item");
      for(int i=0; i<NUMBER_OF_TESTS; i++) begin

         if (!item.randomize()) begin
            `uvm_fatal("RANDOM_FAIL","Failed to randomize the sequence");
         end

         start_item(item);
         finish_item(item);
      end
   endtask // body
   
endclass // my_sequence
