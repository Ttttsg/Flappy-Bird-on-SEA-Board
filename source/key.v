`timescale 1ns / 1ps

module key(input clk,input keyin1,input keyin2,output reg key1,output reg key2);
 reg [22:0]count1;
 reg [22:0]count2;
   always@(posedge clk)
    begin
        if(count1>=23'd2000000&&(!keyin1)) count1<=1'b0;
        else if(!keyin1) count1<=count1+1'b1;
        else count1<=1'b0;
    end
    
    always@(posedge clk)
    begin
        if(count1==23'd1485000) key1<=1'b1;
        else key1<=0;
    end
 ///////////////////////////////////////////   
 always@(posedge clk)
    begin
        if(count2>=23'd2000000&&(!keyin2)) count2<=1'b0;
        else if(!keyin2) count2<=count2+1'b1;
        else count2<=1'b0;
    end
    
    always@(posedge clk)
    begin
        if(count2==23'd1485000) key2<=1'b1;
        else key2<=0;
    end
  
    
endmodule
