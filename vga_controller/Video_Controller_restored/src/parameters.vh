
`ifdef HIGHRES
//Horizontal Timings
        parameter SWITCH   = 1'b1  ;
        parameter H_ACTIVE = 1919;
        parameter H_FRONT  = H_ACTIVE + 88;
        parameter H_SYNC   = H_FRONT + 44;
        parameter H_BACK   = H_SYNC + 148;

//Vertical Timings
        parameter V_ACTIVE = 1079;
        parameter V_FRONT  = V_ACTIVE + 4;
        parameter V_SYNC   = V_FRONT + 5;
        parameter V_BACK   = V_SYNC + 36;


`else
//Horizontal Timings
        parameter SWITCH   = 1'b0;    
        parameter H_ACTIVE = 1279;
        parameter H_FRONT  = H_ACTIVE + 110;
        parameter H_SYNC   = H_FRONT + 40;
        parameter H_BACK   = H_SYNC + 220;

//Vertical Timings
        parameter V_ACTIVE = 719;
        parameter V_FRONT  = V_ACTIVE + 5;
        parameter V_SYNC   = V_FRONT + 5;
        parameter V_BACK   = V_SYNC + 20;


`endif
        parameter  HIGH = 1'b1;
        parameter LOW  = 1'b0;