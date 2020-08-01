`timescale 1ns / 1ps

module Bird(input clk,input key1,input key2,output [11:0]bpos_x,output [11:0]bpos_y);
//reg ini_flag=1;
 reg [11:0]bpos_x0=12'd180;
 reg [11:0]bpos_y0=12'd350;
 reg [31:0]count;
 reg moveflag=0;

always@(posedge clk)
begin
  if(count==32'd1485000) begin moveflag<=1'b1;count<=1'b0;  end
  else begin moveflag<=1'b0;count<=count+1'b1; end
end
 
  always@(posedge clk)
   begin
     if(moveflag&&bpos_y0<=12'd700) bpos_y0<=bpos_y0+12'd3;
     //if(key1&&bpos_y0<=12'd700) bpos_y0<=bpos_y0+12'd8;
     else if(key2&&bpos_y0>=12'd20) bpos_y0<=bpos_y0-12'd8;
     //else if(moveflag) bpos_y0<=bpos_y0-12'd1;
     else  bpos_y0<=bpos_y0; 
   end

assign bpos_x=bpos_x0;
assign bpos_y=bpos_y0;
endmodule
