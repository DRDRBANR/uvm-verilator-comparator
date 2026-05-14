import uvm_pkg::*;
`include "uvm_macros.svh"

typedef uvm_sequencer #(data_item) data_sequencer;

// --- DRIVER ---
class data_driver extends uvm_driver #(data_item);
    `uvm_component_utils(data_driver)
    virtual data_comparator_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual data_comparator_if)::get(this, "", "vif", vif))
            `uvm_fatal("DRV", "Could not get vif")
    endfunction

    task run_phase(uvm_phase phase);
        vif.inp1_i <= 0;
        vif.inp2_i <= 0;
        vif.valid_i <= 0;
        @(posedge vif.rstn);

        forever begin
            seq_item_port.get_next_item(req);
            @(posedge vif.clk);
            vif.inp1_i  <= req.inp1_i;
            vif.inp2_i  <= req.inp2_i;
            vif.valid_i <= req.valid_i;
            seq_item_port.item_done();
        end
    endtask
endclass

// --- MONITOR ---
class data_monitor extends uvm_monitor;
    `uvm_component_utils(data_monitor)
    virtual data_comparator_if vif;
    uvm_analysis_port #(data_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual data_comparator_if)::get(this, "", "vif", vif))
            `uvm_fatal("MON", "Could not get vif")
    endfunction

    task run_phase(uvm_phase phase);
        data_item item;
        forever begin
            @(posedge vif.clk);
            item = data_item::type_id::create("item");
            item.inp1_i  = vif.inp1_i;
            item.inp2_i  = vif.inp2_i;
            item.valid_i = vif.valid_i;
            item.outp_o  = vif.outp_o;
            item.valid_o = vif.valid_o;
            ap.write(item);
        end
    endtask
endclass

// --- AGENT ---
class data_agent extends uvm_agent;
    `uvm_component_utils(data_agent)
    data_driver    driver;
    data_monitor   monitor;
    data_sequencer sequencer;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        monitor = data_monitor::type_id::create("monitor", this);
        if (get_is_active() == UVM_ACTIVE) begin
            driver    = data_driver::type_id::create("driver", this);
            sequencer = data_sequencer::type_id::create("sequencer", this);
        end
    endfunction

    function void connect_phase(uvm_phase phase);
        if (get_is_active() == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end
    endfunction
endclass
