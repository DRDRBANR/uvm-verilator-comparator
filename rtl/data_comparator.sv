module data_comparator(
    input  logic       clk,
    input  logic       rstn,
    input  logic [9:0] inp1_i,
    input  logic [9:0] inp2_i,
    input  logic       valid_i,
    output logic       outp_o,
    output logic       valid_o
);

    logic [5:0] res_internal;
    logic [5:0] valid_internal;

    always_ff @(posedge clk) begin
        if (!rstn) begin
            res_internal <= '0;
        end
        else begin
            if (valid_i) begin
                res_internal[0] <= (inp1_i == inp2_i);
            end
            res_internal[5:1] <= res_internal[4:0];
        end
    end

    always_ff @(posedge clk) begin
        if (!rstn) begin
            valid_internal <= '0;
        end
        else begin
            if (valid_i) begin
                valid_internal[0] <= '1;
            end
            valid_internal[5:1] <= valid_internal[4:0];
        end
    end

    assign outp_o  = res_internal[5];
    assign valid_o = valid_internal[5];

endmodule


