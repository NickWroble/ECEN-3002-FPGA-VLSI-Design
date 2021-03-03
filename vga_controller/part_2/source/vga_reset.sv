module vga_reset (clock, ext_reset, lock, reset_out);
input clock, ext_reset, lock;
output logic reset_out;

logic reset;

logic q0, q1;
logic asynch_reset;

assign reset_out = reset;

assign asynch_reset  = ext_reset | ~lock;


always_ff @ (posedge clock, negedge asynch_reset)
    if (asynch_reset == 1'b0) begin
            q0 <= 1'b0;
            q1 <= 1'b0;
            reset <= 1'b0;
        end
    else
        begin
            q0 <= 1'b1;
            q1 <= q0;
            reset <= q1;
        end 

endmodule