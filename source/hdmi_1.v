`timescale 1ns / 1ps
module hdmi_1(
    input clk_100MHz,
    input keyin1,
    input keyin2,
    output TMDS_Tx_Clk_N,
    output TMDS_Tx_Clk_P,
    output [2:0]TMDS_Tx_Data_N,
    output [2:0]TMDS_Tx_Data_P
    );
    wire clk_system;
    wire [23:0]RGB_Data;
    wire [23:0]RGB_In;
    wire RGB_HSync;
    wire RGB_VSync;
    wire RGB_VDE;
    wire [11:0]Set_X;
    wire [11:0]Set_Y;
    wire [11:0]bpos_x;
    wire [11:0]bpos_y;
    wire [11:0]pippos0_x1;
    wire [11:0]pippos0_y1;
    wire [11:0]pippos0_x2;
    wire [11:0]pippos0_y2;
    wire [11:0]pippos1_x1;
    wire [11:0]pippos1_y1;
    wire [11:0]pippos1_x2;
    wire [11:0]pippos1_y2;
    wire [11:0]pippos2_x1;
    wire [11:0]pippos2_y1;
    wire [11:0]pippos2_x2;
    wire [11:0]pippos2_y2;
    wire key1,key2;
    wire [9:0]rand_num;
    wire start_num0;
    wire start_num1;
    wire start_num2;
    wire [4:0]point1;
    wire [4:0]point2;
    wire [4:0]point3;
    wire game_over;
    reg rst0=1'b0;
  
    // wire pip_gen0;
    // wire pip_gen1;
    // wire pip_gen2;



    clk_wiz_0 clk_10(.clk_out1(clk_system),.clk_in1(clk_100MHz));
    //RGBToDvi instantiation
    rgb2dvi_0 rgb2dvi(
        .TMDS_Clk_p(TMDS_Tx_Clk_P),
        .TMDS_Clk_n(TMDS_Tx_Clk_N),
        .TMDS_Data_p(TMDS_Tx_Data_P),
        .TMDS_Data_n(TMDS_Tx_Data_N),
        .aRst_n(1),
        .vid_pData(RGB_Data),
        .vid_pVDE(RGB_VDE),
        .vid_pHSync(RGB_HSync),
        .vid_pVSync(RGB_VSync),
        .PixelClk(clk_system));
    //HDMI driver
    Driver_HDMI Driver_HDMI0(
        .clk(clk_system),        //Clock
        .Rst(1),                 //Reset signal, low reset
        .Video_Mode(1),          //Video format, 0 is 1920*1080@60Hz, 1 is 1280*720@60Hz
        .RGB_In(RGB_In),         //Input data
        .RGB_Data(RGB_Data),     //Output Data
        .RGB_HSync(RGB_HSync),   //Line signal
        .RGB_VSync(RGB_VSync),   //Field signal
        .RGB_VDE(RGB_VDE),       //Data valid signal
        .Set_X(Set_X),           //Image coordinate X
        .Set_Y(Set_Y)            //Image coordinate Y
        );
    Video_Generator Video_Generator0(
        .clk(clk_system),
        .bpos_x(bpos_x),
        .bpos_y(bpos_y),
        .pippos0_x1(pippos0_x1),
        .pippos0_y1(pippos0_y1),
        .pippos0_x2(pippos0_x2),
        .pippos0_y2(pippos0_y2),
        .pippos1_x1(pippos1_x1),
        .pippos1_y1(pippos1_y1),
        .pippos1_x2(pippos1_x2),
        .pippos1_y2(pippos1_y2),
        .pippos2_x1(pippos2_x1),
        .pippos2_y1(pippos2_y1),
        .pippos2_x2(pippos2_x2),
        .pippos2_y2(pippos2_y2),
        .start_num0(start_num0),
        .start_num1(start_num1),
        .start_num2(start_num2),
        .point1(point1),
        .point2(point2),
        .point3(point3),
        .game_over(game_over),
        .RGB_VDE(RGB_VDE),
        .Set_X(Set_X),
        .Set_Y(Set_Y),
        .RGB_Data(RGB_In)    //RBG
        );
        
     // Bird bird0(.clk(clk_system),.key1(key1),.key2(key2),.bpos_x(bpos_x),.bpos_y(bpos_y)); 
      Bird bird0(
          .clk(clk_system),
          .key1(key1),
          .key2(key2),
          .bpos_x(bpos_x),
          .bpos_y(bpos_y)
        );   
      
      key key0(
          .clk(clk_system),
          .keyin1(keyin1),
          .keyin2(keyin2),
          .key1(key1),
          .key2(key2)
        );
      
      pipe pipe0(
          .clk(clk_system),
          .rst(key1),
          .rand_num(rand_num),
          .start_num(start_num0),
          .pippos_x1(pippos0_x1),
          .pippos_y1(pippos0_y1),
          .pippos_x2(pippos0_x2),
          .pippos_y2(pippos0_y2)
        );   
      pipe pipe1(
          .clk(clk_system),
          .rst(key1),
          .rand_num(rand_num),
          .start_num(start_num1),
          .pippos_x1(pippos1_x1),
          .pippos_y1(pippos1_y1),
          .pippos_x2(pippos1_x2),
          .pippos_y2(pippos1_y2)
        );   
      pipe pipe2(
          .clk(clk_system),
          .rst(key1),
          .rand_num(rand_num),
          .start_num(start_num2),
          .pippos_x1(pippos2_x1),
          .pippos_y1(pippos2_y1),
          .pippos_x2(pippos2_x2),
          .pippos_y2(pippos2_y2)
        );   
      Random Random0(   
        .clk(clk_system), 
        .rst(key1),
        .game_over(game_over),      
        .rand_num(rand_num)  
        ); 

      pip_delay pip_delay0(
            .clk(clk_system),
            .rst(key1),
            .start_num0(start_num0),
            .start_num1(start_num1),
            .start_num2(start_num2)
            );
       Game_Control Game_Control0(
        .clk(clk_system),
        .rst(key1),
        .bpos_x(bpos_x),
        .bpos_y(bpos_y),
        .pippos0_x1(pippos0_x1),
        .pippos0_y1(pippos0_y1),
        .pippos0_x2(pippos0_x2),
        .pippos0_y2(pippos0_y2),
        .pippos1_x1(pippos1_x1),
        .pippos1_y1(pippos1_y1),
        .pippos1_x2(pippos1_x2),
        .pippos1_y2(pippos1_y2),
        .pippos2_x1(pippos2_x1),
        .pippos2_y1(pippos2_y1),
        .pippos2_x2(pippos2_x2),
        .pippos2_y2(pippos2_y2),
        .game_over(game_over),
        .point1w(point1),
        .point2w(point2),
        .point3w(point3)
    );
      
endmodule
