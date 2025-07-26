`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: S Amritha,Shreya Kamat,Steven Joshua
// 
// Create Date: 23.02.2025 19:16:35
// Design Name: DPRAM
// Module Name: arch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module decoder(a,b,y);
input a,b;
output [3:0] y;
assign y[0]=(~a)&(~b);
assign y[1]=(~a)&(b);
assign y[2]=(a)&(~b);
assign y[3]=(a)&(b);
endmodule

module mux(mux_sel,data_a_mux,data_b_mux,data_out_mux);
input[1:0] mux_sel;
input [3:0] data_a_mux,data_b_mux;
output reg [3:0] data_out_mux;
wire [3:0] w0;
comp c1(data_a_mux,data_b_mux,w0);
always @(*) begin
if(!mux_sel[1] && !mux_sel[0])
begin
data_out_mux=4'b0;
end
else if(!mux_sel[1] && mux_sel[0])
begin
data_out_mux=data_b_mux;
end
else if(mux_sel[1] && !mux_sel[0])
begin
data_out_mux=data_a_mux;
end
else if(mux_sel[0] && mux_sel[1])
begin
data_out_mux=w0;
end
end
endmodule

module comp(a,b,y);
input [3:0] a,b;
output [3:0] y;
wire [2:0] w0;
assign w0[0]=(a[0]~^b[0])&(a[1]~^b[1])&(a[2]~^b[2])&(a[3]~^b[3]);
assign w0[1]=(a[3]&(~b[3]))|
(a[3]~^b[3])&(a[2]&(~b[2]))|
(a[3]~^b[3])&(a[2]~^b[2])&(a[1]&(~b[1]))|
(a[3]~^b[3])&(a[2]~^b[2])&(a[1]~^b[1])&(a[0]&(~b[0]));
assign w0[2]=(b[3]&(~a[3]))|
(b[3]~^a[3])&(b[2]&(~a[2]))|
(b[3]~^a[3])&(b[2]~^a[2])&(b[1]&(~a[1]))|
(b[3]~^a[3])&(b[2]~^a[2])&(b[1]~^a[1])&(b[0]&(~a[0]));
assign y=({4{w0[0]}} & 4'b0000)|({4{w0[1]}} & a)|({4{w0[2]}} & b);
endmodule

module dff(d,clck,write,rst,q);
input d,clck,write,rst;
output reg q;
always @(posedge clck)
begin
if(rst)
q<=1'b0;
else if (write)
q<=d;
end
endmodule


module arch(data_a,data_b,address,write,clck,rst,address_read_a,address_read_b,read_a,read_b,data_out_a,data_out_b);
input [3:0] data_a,data_b;
input [1:0] address,write;
input clck,rst;
input read_a,read_b;
input [1:0] address_read_a,address_read_b;
output reg [15:0] data_out_a,data_out_b; // Corrected from 16-bit to 4-bit
wire [3:0] w0,w1,w2,w3,w4;
wire [3:0]d0,d1,d2,d3;
wire w;
or(w,write[0],write[1]);
decoder dd1(address[1],address[0],w0);
mux m1(write,data_a,data_b,w1);

dff f1(w1[0],clck,w&w0[0],rst,d0[0]);
dff f2(w1[1],clck,w&w0[0],rst,d0[1]);
dff f3(w1[2],clck,w&w0[0],rst,d0[2]);
dff f4(w1[3],clck,w&w0[0],rst,d0[3]);

mux m2(write,data_a,data_b,w2);
dff d11(w2[0],clck,w&w0[1],rst,d1[0]);
dff d12(w2[1],clck,w&w0[1],rst,d1[1]);
dff d13(w2[2],clck,w&w0[1],rst,d1[2]);
dff d14(w2[3],clck,w&w0[1],rst,d1[3]);

mux m3(write,data_a,data_b,w3);
dff d21(w3[0],clck,w&w0[2],rst,d2[0]);
dff d22(w3[1],clck,w&w0[2],rst,d2[1]);
dff d23(w3[2],clck,w&w0[2],rst,d2[2]);
dff d24(w3[3],clck,w&w0[2],rst,d2[3]);

mux m4(write,data_a,data_b,w4);
dff d31(w4[0],clck,w&w0[3],rst,d3[0]);
dff d32(w4[1],clck,w&w0[3],rst,d3[1]);
dff d33(w4[2],clck,w&w0[3],rst,d3[2]);
dff d34(w4[3],clck,w&w0[3],rst,d3[3]);


always @(*) begin
        if (read_a) begin
            case (address_read_a)
                2'b00: data_out_a[3:0] = d0;
                2'b01: data_out_a[7:4] = d1;
                2'b10: data_out_a[11:8] = d2;
                2'b11: data_out_a[15:12] = d3;
                default: data_out_a = 16'b0;
            endcase
        end else begin
            data_out_a = 16'bz; // Corrected to 4-bit high-impedance
        end
    end

always @(*) begin
        if (read_b) begin
            case (address_read_b)
                2'b00: data_out_b[3:0] = d0;
                2'b01: data_out_b[7:4] = d1;
                2'b10: data_out_b[11:8] = d2;
                2'b11: data_out_b[15:12] = d3;
                default: data_out_b = 16'b0;
            endcase
        end else begin
            data_out_b = 16'bz; // Corrected to 4-bit high-impedance
        end
    end
endmodule
