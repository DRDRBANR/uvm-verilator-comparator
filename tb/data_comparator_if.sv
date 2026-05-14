interface data_comparator_if(input logic clk, input logic rstn);
    logic [9:0] inp1_i;
    logic [9:0] inp2_i;
    logic       valid_i;
    logic       outp_o;
    logic       valid_o;
endinterface
