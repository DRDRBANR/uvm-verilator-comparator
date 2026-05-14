import uvm_pkg::*;
`include "uvm_macros.svh"

class data_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(data_scoreboard)
    uvm_analysis_imp #(data_item, data_scoreboard) item_export;

    bit exp_res_queue[$];
    bit exp_val_queue[$];

    function new(string name, uvm_component parent);
        super.new(name, parent);
        item_export = new("item_export", this);
    endfunction

    virtual function void write(data_item item);
        bit expected_outp;
        bit expected_valid;
        bit current_res = 1'b0;
        bit current_val = 1'b0;

        if (item.valid_i) begin
            current_res = (item.inp1_i == item.inp2_i);
            current_val = 1'b1;
        end

        exp_res_queue.push_back(current_res);
        exp_val_queue.push_back(current_val);

        if (exp_res_queue.size() > 6) begin
            expected_outp = exp_res_queue.pop_front();
            expected_valid = exp_val_queue.pop_front();

            if (item.valid_o !== expected_valid || item.outp_o !== expected_outp) begin
                `uvm_error("SCB_FAIL", $sformatf("Mismatch! Exp: val=%b out=%b | Act: val=%b out=%b", 
                           expected_valid, expected_outp, item.valid_o, item.outp_o))
            end
        end
    endfunction
endclass
