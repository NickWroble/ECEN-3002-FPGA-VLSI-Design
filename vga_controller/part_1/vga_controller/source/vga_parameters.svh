`ifdef resolution_720
    parameter   H_SYNC_PULSE_WIDTH      = 40; 
    parameter   H_ACTIVE_PIXEL_COUNT    = 1280;
    parameter   H_FRONT_PORCH           = 110;
    parameter   H_PIXEL_COUNT           = 1650;


    parameter   V_SYNC_PULSE_WIDTH      = 5;
    parameter   V_ACTIVE_LINE_COUNT     = 720;
    parameter   V_FRONT_PORCH           = 5;
    parameter   V_LINE_COUNT            = 750;
`endif

`define resolution_720