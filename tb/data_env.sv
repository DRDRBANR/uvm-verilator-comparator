import uvm_pkg::*;
`include "uvm_macros.svh"

class data_env extends uvm_env;
    `uvm_component_utils(data_env)
    
    data_agent      agent;
    data_scoreboard scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent      = data_agent::type_id::create("agent", this);
        scoreboard = data_scoreboard::type_id::create("scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        agent.monitor.ap.connect(scoreboard.item_export);
    endfunction
endclass
