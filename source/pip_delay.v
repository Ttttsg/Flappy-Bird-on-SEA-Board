`timescale 1ns / 1ps

module pip_delay(
    input clk,
    input rst,
    output start_num0,
    output start_num1,
    output start_num2);
reg [31:0]count=0;
reg [31:0]count2=0;
reg [31:0]count3=0;
reg start_num0_r=0;
reg start_num1_r=0;
reg start_num2_r=0;

always@(posedge clk)
begin
    if(rst) begin start_num0_r<=0;start_num1_r<=0;start_num2_r<=0;count<=0;end
    else if(count==1'b0) begin start_num0_r<=1'b1; count<=count+1'b1; end
    else if(count==32'd148500000) begin start_num1_r<=1'b1; count<=count+1'b1; end
    else if(count==32'd297000000) begin start_num2_r<=1'b1; count<=count; end
    else count<=count+1'b1;
end

// always@(posedge clk)
// begin
//     if(rst) begin start_num0_r<=0;start_num1_r<=0;start_num2_r<=0;count<=0;end
//     else if(count==1'b0) begin start_num0_r<=1'b1; count<=count+1'b1; end
//     else if(count==32'd297000000) begin start_num1_r<=1'b1; count<=count+1'b1; end
//     else if(count==32'd594000000) begin start_num2_r<=1'b1; count<=count; end
//     else count<=count+1'b1;
// end

assign start_num0=start_num0_r;
assign start_num1=start_num1_r;
assign start_num2=start_num2_r;

endmodule
