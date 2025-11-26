class my_agent extends uvm_agent;

   `uvm_component_utils(my_agent)

   my_sequencer sequencer;
   my_driver driver;
   my_monitor monitor;
   virtual IIR_if my_if;

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      sequencer = my_sequencer::type_id::create("sequencer", this);
      driver = my_driver::type_id::create("driver", this);
      monitor = my_monitor::type_id::create("monitor", this);

      if(!uvm_config_db#(virtual IIR_if)::get(this, "", "if", my_if)) begin
         `uvm_fatal("NOVIF",{"Virtual interface must be set for: ", get_full_name()})
      end

      driver.my_if = my_if;
      monitor.my_if = my_if;      

   endfunction // build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);    
   endfunction

endclass
