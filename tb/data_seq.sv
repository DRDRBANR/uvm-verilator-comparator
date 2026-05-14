import uvm_pkg::*;
`include "uvm_macros.svh"

class data_seq extends uvm_sequence #(data_item);
    `uvm_object_utils(data_seq)

    function new(string name = "data_seq");
        super.new(name);
    endfunction

    task body();
        data_item item;
        // GEN 50
        for (int i = 0; i < 50; i++) begin
            item = data_item::type_id::create("item");
            start_item(item);
            if (!item.randomize()) begin
                `uvm_error("SEQ", "Randomization failed")
            end
            finish_item(item);
        end
    endtask
endclass
