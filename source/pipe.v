`timescale 1ns / 1ps

module pipe(input clk,input rst,input [9:0]rand_num,input start_num,
output [11:0]pippos_x1,output [11:0]pippos_y1,output pippos_x2,output [11:0]pippos_y2);

reg [11:0]pippos_x1r=12'd1280;
reg [11:0]pippos_y1r=12'd300;
reg [11:0]pippos_x2r=12'd1280;
reg [11:0]pippos_y2r=12'd460;
reg [31:0]count=0;
reg [31:0]count2=0;
reg moveflag=0;
reg [9:0]rand_num0;
//reg pip_gen_wire;

always@(posedge clk)
begin
    if(rand_num>=10'd500) rand_num0<=rand_num-10'd400;
    else if(rand_num<=10'd100) rand_num0<=rand_num+10'd100;
    else rand_num0<=rand_num;
end

always@(posedge clk)
begin
    if(rst) begin moveflag<=1'b0;count<=1'b0; end
    else if(start_num)
      begin
          if(count==32'd742500) begin moveflag<=1'b1;count<=1'b0;  end
          //if(count==32'd1485000) begin moveflag<=1'b1;count<=1'b0;  end
          else begin moveflag<=1'b0;count<=count+1'b1; end
      end
    else begin  moveflag<=1'b0;count<=1'b0;  end
end

always@(posedge clk)
begin
  if(rst) begin  pippos_x1r<=12'd1280;pippos_x2r<=12'd1280;pippos_y1r<=12'd300;pippos_y2r<=12'd460; end
  else if(pippos_x1r<=10) begin pippos_x1r<=12'd1280;pippos_x2r<=12'd1280;pippos_y1r<=rand_num0;pippos_y2r<=rand_num0+12'd160;end
  else if(moveflag) begin pippos_x1r<=pippos_x1r-12'd2;pippos_x2r<=pippos_x2r-12'd2; end
  else begin pippos_x1r<=pippos_x1r;pippos_x2r<=pippos_x2r;end
end



assign pippos_x1=pippos_x1r;
assign pippos_y1=pippos_y1r;
assign pippos_x2=pippos_x2r;
assign pippos_y2=pippos_y2r;



endmodule

// always@(posedge clk)
// begin
//   if(start_num==4'd0)
//     begin
//       pip_gen=1'b1;
//     end
//   else if(start_num==4'd1)
//     begin
//       if(count2==32'd148500000) begin count2<=count2;pip_gen=1'b1;end
//       else count2<=count2+1'b1;
//     end
//   else if(start_num==4'd2)
//     begin
//       if(count2==32'd297000000) begin count2<=count2;pip_gen=1'b1;end
//       else count2<=count2+1'b1;
//     end
//   else pip_gen<=1'b0;
// end