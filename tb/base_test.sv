import uvm_pkg::*;
`include "uvm_macros.svh"

class base_test extends uvm_test;
    `uvm_component_utils(base_test)
    
    data_env env;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = data_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        data_seq seq;
        // Flag up
        phase.raise_objection(this);
        
        seq = data_seq::type_id::create("seq");
        // data generation
        seq.start(env.agent.sequencer);
        
        // Timer
        #100; 
        
        // Flag down
        phase.drop_objection(this);
    endtask
endclass
