import basic_sequence_item::*;

class my_monitor extends uvm_monitor;
   
   `uvm_component_utils(my_monitor)

   basic_sequence_item#() item1;   
   basic_sequence_item#() item2;   

   uvm_analysis_port#(basic_sequence_item#()) monitor_port;   
   virtual IIR_if my_if;

   function new ( string name, uvm_component parent);
      super.new(name, parent);
   endfunction // new

   virtual function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      item1 = basic_sequence_item#()::type_id::create("item1");
      item2 = basic_sequence_item#()::type_id::create("item2");
      monitor_port = new("monitor_port", this);
   endfunction

   virtual task run_phase(uvm_phase phase);

//      forever begin
//         @(posedge((my_if.valid_i === 1'b1) && (my_if.ready_and_o === '1)));
//         item1.x_i = my_if.x_i;
//         `uvm_info("MONITOR",
//                   $sformatf("Recieved input: %d", $signed(item1.x_i)),
//                   UVM_MEDIUM)
//
//
//         @(posedge my_if.valid_o);
//         item1.y_o = my_if.y_o;
//         `uvm_info("MONITOR",
//                   $sformatf("Sent input: %d", $signed(item1.x_i)),
//                   UVM_MEDIUM)
//         monitor_port.write(item1);
//      end

      fork
         begin : monitor_inputs
            forever begin
               @(posedge((my_if.valid_i === 1'b1) && (my_if.ready_and_o === '1)));
               item1.x_i = my_if.x_i;
               `uvm_info("MONITOR",
                         $sformatf("Recieved input: %d", $signed(item1.x_i)),
                         UVM_MEDIUM)

               @(posedge((my_if.valid_i === 1'b1) && (my_if.ready_and_o === '1)));
               item2.x_i = my_if.x_i;
               `uvm_info("MONITOR",
                         $sformatf("Recieved input: %d", $signed(item2.x_i)),
                         UVM_MEDIUM)

            end
         end

       begin : monitor_outputs
          forever begin
               @(posedge my_if.valid_o);
               item1.y_o = my_if.y_o;
               `uvm_info("MONITOR",
                         $sformatf("Sent input: %d", $signed(item1.x_i)),
                         UVM_MEDIUM)
               monitor_port.write(item1);
               @(posedge my_if.valid_o);
               item2.y_o = my_if.y_o;
               `uvm_info("MONITOR",
                         $sformatf("Sent input: %d", $signed(item2.x_i)),
                         UVM_MEDIUM)
               monitor_port.write(item2);
          end
       end
    join_none
   endtask

endclass
