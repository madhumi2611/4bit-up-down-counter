`timescale 1ns / 1ps
module up_down_counter (
    input clk,
    input reset,
    input load,
    input up,
    input down,
    input [3:0] data_in,
    output reg [3:0] count
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 4'b0000;
    end
    else if (load) begin
        count <= data_in;
    end
    else if (up) begin
        count <= count + 1;
    end
    else if (down) begin
        count <= count - 1;
    end
end

endmodule