`timescale 1ns / 1ps


module Game_Control(
    input clk,
    input rst,
    input [11:0]bpos_x,
    input [11:0]bpos_y,
    input [11:0]pippos0_x1,
    input [11:0]pippos0_y1,
    input [11:0]pippos0_x2,
    input [11:0]pippos0_y2,
    input [11:0]pippos1_x1,
    input [11:0]pippos1_y1,
    input [11:0]pippos1_x2,
    input [11:0]pippos1_y2,
    input [11:0]pippos2_x1,
    input [11:0]pippos2_y1,
    input [11:0]pippos2_x2,
    input [11:0]pippos2_y2,
    //output [9:0]point
    output reg game_over,
    output [4:0]point1w,
    output [4:0]point2w,
    output [4:0]point3w
    );

reg [9:0]bird_point=9'd0;
reg [9:0]pipe0_point=9'd0;
reg [9:0]pipe1_point=9'd1;
reg [9:0]pipe2_point=9'd2;

reg [4:0]point1=0;
reg [4:0]point2=0;
reg [4:0]point3=0;

reg game_over1=0;
reg game_over2=0;
reg game_over3=0;

//////////////////////////////////////////////point-print///////////////////////////////////
always@(posedge clk)
begin
    if(rst) begin bird_point<=1'b0;pipe0_point<=9'd0;pipe1_point<=9'd1;pipe2_point<=9'd2;  end
    else if( (bird_point==pipe0_point) && (pippos0_x1==bpos_x) ) begin bird_point<=bird_point+1'b1;pipe0_point<=pipe0_point+9'd3;end
    else if( (bird_point==pipe1_point) && (pippos1_x1==bpos_x) ) begin bird_point<=bird_point+1'b1;pipe1_point<=pipe1_point+9'd3;end
    else if( (bird_point==pipe2_point) && (pippos2_x1==bpos_x) ) begin bird_point<=bird_point+1'b1;pipe2_point<=pipe2_point+9'd3;end   
    else begin bird_point<=bird_point; pipe0_point<=pipe0_point;pipe1_point<=pipe1_point;pipe2_point<=pipe2_point; end
end

always@(posedge clk)
begin
    if(rst) point1<=1'b0;
    else if( ((bird_point==pipe0_point) && (pippos0_x1==bpos_x)) ||((bird_point==pipe1_point) && (pippos1_x1==bpos_x)) ||((bird_point==pipe2_point) && (pippos2_x1==bpos_x)) )
    begin
        if(point1==4'd9) point1<=1'b0;
        else point1<=point1+1'b1;
    end
    else point1<=point1;
end
always@(posedge clk)
begin
    if(rst) point2<=1'b0;
    else if( ((bird_point==pipe0_point) && (pippos0_x1==bpos_x)) ||((bird_point==pipe1_point) && (pippos1_x1==bpos_x)) ||((bird_point==pipe2_point) && (pippos2_x1==bpos_x)) )
    begin
        if(point1==4'd9) 
         begin
             if(point2==4'd9) point2<=1'b0;
             else point2<=point2+1'b1;
         end
    end
    else point2<=point2;
end

always@(posedge clk)
begin
    if(rst) point3<=1'b0;
    else if( ((bird_point==pipe0_point) && (pippos0_x1==bpos_x)) ||((bird_point==pipe1_point) && (pippos1_x1==bpos_x)) ||((bird_point==pipe2_point) && (pippos2_x1==bpos_x)) )
    begin
        if(point2==4'd9&&point1==4'd9) 
         begin
             if(point3==4'd9) point3<=1'b0;
             else point3<=point3+1'b1;
         end
    end
    else point3<=point3;
end
//////////////////////////////////////////////point-print///////////////////////////////////

/////////////////////////////////////////////crash-cheking//////////////////////////////////
always@(posedge clk)
begin
    // if(     ( (bpos_y-12'd20>=pippos0_y1+12'd10)||(bpos_y+12'd20<=pippos0_y2-12'd10)  )
    //       &&( (bpos_x+12'd30>=pippos0_x1-12'd25)||(bpos_x-12'd30>=pippos0_x1+12'd25)  )  
    //   )
    //    begin game_over1=1'b1; end 
    if(rst) game_over1=1'b0;
    else if(   (bpos_y+12'd20<=pippos0_y1-12'd10) &&(bpos_x+12'd30>=pippos0_x1-12'd25) &&(bpos_x-12'd30<=pippos0_x1+12'd25) )
        begin game_over1=1'b1; end 
    else if(   (bpos_y-12'd20>=pippos0_y2+12'd10) &&(bpos_x+12'd30>=pippos0_x1-12'd25)&&(bpos_x-12'd30<=pippos0_x1+12'd25) )
        begin game_over1=1'b1; end 
    else if(   (bpos_y+12'd20<pippos0_y1+12'd50)&&(bpos_y+12'd20>=pippos0_y1-12'd10) &&(bpos_x+12'd30>=pippos0_x1-12'd40) &&(bpos_x-12'd30<=pippos0_x1+12'd40) )
         begin game_over1=1'b1; end
    else if(   (bpos_y-12'd20>pippos0_y2-12'd50)&&(bpos_y-12'd20<=pippos0_y2-12'd10) &&(bpos_x+12'd30>=pippos0_x1-12'd40) &&(bpos_x-12'd30<=pippos0_x1+12'd40) )
         begin game_over1=1'b1; end
    else if(  ((bpos_y-12'd20<pippos0_y1+12'd10)||(bpos_y+12'd20>pippos0_y2-12'd10))&&(bpos_x+12'd30>=pippos0_x1-12'd40)&&(bpos_x-12'd30<=pippos0_x1+12'd40)  )
         begin game_over1=1'b1; end
    //else if(game_over1==1'b1) game_over1<=1'b1;
    else  game_over1=1'b0;
end

always@(posedge clk)
begin
    if(rst) game_over1=1'b0;
    else if(   (bpos_y+12'd20<=pippos1_y1-12'd10) &&(bpos_x+12'd30>=pippos1_x1-12'd25) &&(bpos_x-12'd30<=pippos1_x1+12'd25) )
        begin game_over2=1'b1; end 
    else if(   (bpos_y-12'd20>=pippos1_y2+12'd10) &&(bpos_x+12'd30>=pippos1_x1-12'd25)&&(bpos_x-12'd30<=pippos1_x1+12'd25) )
        begin game_over2=1'b1; end 
    else if(   (bpos_y+12'd20<pippos1_y1+12'd50)&&(bpos_y+12'd20>=pippos1_y1-12'd10) &&(bpos_x+12'd30>=pippos1_x1-12'd40) &&(bpos_x-12'd30<=pippos1_x1+12'd40) )
         begin game_over2=1'b1; end
    else if(   (bpos_y-12'd20>pippos1_y2-12'd50)&&(bpos_y-12'd20<=pippos1_y2-12'd10) &&(bpos_x+12'd30>=pippos1_x1-12'd40) &&(bpos_x-12'd30<=pippos1_x1+12'd40) )
         begin game_over2=1'b1; end
    else if(  ((bpos_y-12'd20<pippos1_y1+12'd10)||(bpos_y+12'd20>pippos1_y2-12'd10))&&(bpos_x+12'd30>=pippos1_x1-12'd40)&&(bpos_x-12'd30<=pippos1_x1+12'd40)  )
         begin game_over2=1'b1; end
   // else if(game_over2==1'b1) game_over2<=1'b1;
    else  game_over2=1'b0;
end

always@(posedge clk)
begin
    if(rst) game_over1=1'b0;
    else if(   (bpos_y+12'd20<=pippos2_y1-12'd10) &&(bpos_x+12'd30>=pippos2_x1-12'd25) &&(bpos_x-12'd30<=pippos2_x1+12'd25) )
        begin game_over3=1'b1; end 
    else if(   (bpos_y-12'd20>=pippos2_y2+12'd10) &&(bpos_x+12'd30>=pippos2_x1-12'd25)&&(bpos_x-12'd30<=pippos2_x1+12'd25) )
        begin game_over3=1'b1; end 
    else if(   (bpos_y+12'd20<pippos2_y1+12'd50)&&(bpos_y+12'd20>=pippos2_y1-12'd10) &&(bpos_x+12'd30>=pippos2_x1-12'd40) &&(bpos_x-12'd30<=pippos2_x1+12'd40) )
         begin game_over3=1'b1; end
    else if(   (bpos_y-12'd20>pippos2_y2-12'd50)&&(bpos_y-12'd20<=pippos2_y2-12'd10) &&(bpos_x+12'd30>=pippos2_x1-12'd40) &&(bpos_x-12'd30<=pippos2_x1+12'd40) )
         begin game_over3=1'b1; end
    else if(  ((bpos_y-12'd20<pippos2_y1+12'd10)||(bpos_y+12'd20>pippos2_y2-12'd10))&&(bpos_x+12'd30>=pippos2_x1-12'd40)&&(bpos_x-12'd30<=pippos2_x1+12'd40)  )
         begin game_over3=1'b1; end
   // else if(game_over3==1'b1) game_over3<=1'b1;
    else  game_over3=1'b0;
end

always@(posedge clk)
begin
    if(rst) game_over<=1'b0;
    else if(game_over1||game_over2||game_over3) game_over<=1'b1;
    else game_over<=game_over;
end
/////////////////////////////////////////////crash-cheking//////////////////////////////////

assign point1w=point1;
assign point2w=point2;
assign point3w=point3;
//assign point=bird_point;
//assign game_over=game_over1||game_over2||game_over3;

endmodule
