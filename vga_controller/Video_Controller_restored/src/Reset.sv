module Reset (
    input rst,
    input locked,
    input VGA_CLK,
    output logic a_reset
);
logic e_reset;
assign e_reset = rst & locked;
logic ff1,ff2;
always_ff @(posedge VGA_CLK,negedge e_reset) 
    if(e_reset == 1'b0) 
    begin
            ff1 <= 1'b0;
            ff2 <= 1'b0;
            a_reset <= 1'b0;
    end
    else 
    begin
        ff1 <= 1'b1;
        ff2 <= ff1;
        a_reset <= ff2;
    end

endmodule