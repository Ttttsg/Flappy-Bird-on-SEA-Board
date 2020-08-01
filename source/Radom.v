`timescale 1ns / 1ps 
module Random(  
    input  clk,      /*clock signal*/  
    input rst,
    input game_over,
 //   input  load,     /*load seed to rand_num,active high */  
    output reg[9:0]rand_num  /*random number output*/  
);  

reg [9:0]seed = 10'd233; 
reg load=0;  
reg [15:0]count;
reg [9:0]count2;

always@(posedge clk)
begin
    if(game_over) count2<=count2+1'b1;
    else count2<=count2;
end

always@(posedge clk)
begin
    if(rst) seed<=count2;
    else seed<=seed;
end

always@(posedge clk)
begin
    if(rst) begin load<=1'b1;count<=16'd1200; end
    else if(count==16'd12500) begin load<=1'b1;count<=count+1'b1; end
    else if(count==16'd12510)begin load<=1'b0;count<=count; end
    else count<=count+1'b1;
end

always@(posedge clk)  
begin  
    if(load)  
       rand_num <=seed;    /*load the initial value when load is active*/  
    else  
        begin  
            rand_num[0] <= rand_num[9];  
            rand_num[1] <= rand_num[0];  
            rand_num[2] <= rand_num[1];  
            rand_num[3] <= rand_num[2];  
            rand_num[4] <= rand_num[3]^rand_num[9];  
            rand_num[5] <= rand_num[4]^rand_num[9];  
            rand_num[6] <= rand_num[5];  
            rand_num[7] <= rand_num[6];
            rand_num[8] <= rand_num[7];
            rand_num[9] <= rand_num[8];       
        end  
                
end 

endmodule  
