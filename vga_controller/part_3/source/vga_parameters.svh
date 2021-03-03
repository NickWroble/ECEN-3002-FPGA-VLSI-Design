`define highres

`ifdef highres //1080p
    parameter   H_SYNC_PULSE_WIDTH      = 44; 
    parameter   H_ACTIVE_PIXEL_COUNT    = 1920;
    parameter   H_FRONT_PORCH           = 88;
    parameter   H_PIXEL_COUNT           = 2200;


    parameter   V_SYNC_PULSE_WIDTH      = 5;
    parameter   V_ACTIVE_LINE_COUNT     = 1080;
    parameter   V_FRONT_PORCH           = 4;
    parameter   V_LINE_COUNT            = 1125;

    parameter   BOX_WIDTH_1             = 75;
    parameter   BOX_HEIGHT_1            = 75;

    parameter   BOX_WIDTH_2             = 105;
    parameter   BOX_HEIGHT_2            = 105;

`else //720p
    parameter   H_SYNC_PULSE_WIDTH      = 40; 
    parameter   H_ACTIVE_PIXEL_COUNT    = 1280;
    parameter   H_FRONT_PORCH           = 110;
    parameter   H_PIXEL_COUNT           = 1650;


    parameter   V_SYNC_PULSE_WIDTH      = 5;
    parameter   V_ACTIVE_LINE_COUNT     = 720;
    parameter   V_FRONT_PORCH           = 5;
    parameter   V_LINE_COUNT            = 750;

    parameter   BOX_WIDTH_1             = 50;
    parameter   BOX_HEIGHT_1            = 50;

    parameter   BOX_WIDTH_2             = 70;
    parameter   BOX_HEIGHT_2            = 70;
`endif
    
