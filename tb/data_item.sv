import uvm_pkg::*;
`include "uvm_macros.svh"

class data_item extends uvm_sequence_item;

    rand logic [9:0] inp1_i;
    rand logic [9:0] inp2_i;
    rand logic       valid_i;

    logic outp_o;
    logic valid_o;

    `uvm_object_utils_begin(data_item)
        `uvm_field_int(inp1_i, UVM_ALL_ON)
        `uvm_field_int(inp2_i, UVM_ALL_ON)
        `uvm_field_int(valid_i, UVM_ALL_ON)
        `uvm_field_int(outp_o, UVM_ALL_ON)
        `uvm_field_int(valid_o, UVM_ALL_ON)
    `uvm_object_utils_end

	// Field registration	

     function new(string name = "data_item");
        super.new(name);
    endfunction
endclass
