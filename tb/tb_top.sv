import uvm_pkg::*;
`include "uvm_macros.svh"

`include "data_comparator_if.sv"
`include "data_item.sv"
`include "data_agent.sv"
`include "data_scoreboard.sv"
`include "data_env.sv"
`include "data_seq.sv"
`include "base_test.sv"

module tb_top;
    logic clk;
    logic rstn;

    // GEN CLK 10ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // rst
    initial begin
        rstn = 0;
        #15 rstn = 1;
    end

    data_comparator_if vif(clk, rstn);

    data_comparator dut(
        .clk    (clk),
        .rstn   (rstn),
        .inp1_i (vif.inp1_i),
        .inp2_i (vif.inp2_i),
        .valid_i(vif.valid_i),
        .outp_o (vif.outp_o),
        .valid_o(vif.valid_o)
    );

    initial begin
        uvm_config_db#(virtual data_comparator_if)::set(null, "*", "vif", vif);
        run_test();
    end
endmodule
