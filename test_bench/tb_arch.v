`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.02.2025 22:06:20
// Design Name: 
// Module Name: tb_arch
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




module tb_arch;
    
    // Testbench signals
    reg [3:0] data_a, data_b;
    reg [1:0] address, write;
    reg clck, rst;
    reg read_a, read_b;
    reg [1:0] address_read_a, address_read_b;
    wire [15:0] data_out_a, data_out_b;

    // Instantiate the RAM module
    arch uut (
        .data_a(data_a), 
        .data_b(data_b), 
        .address(address), 
        .write(write), 
        .clck(clck), 
        .rst(rst), 
        .read_a(read_a),
        .read_b(read_b),
        .address_read_a(address_read_a), 
        .address_read_b(address_read_b), 
        .data_out_a(data_out_a), 
        .data_out_b(data_out_b)
    );

    // Generate clock signal (50% duty cycle)
    always #5 clck = ~clck;

    // Test sequence
    initial begin
        // Initialize signals
        clck = 0;
        rst = 1;
        data_a = 4'b0000;
        data_b = 4'b0000;
        address = 2'b00;
        write = 2'b00;
        read_a = 0;
        read_b = 0;
        address_read_a = 2'b00;
        address_read_b = 2'b00;

        // Apply reset
        #10 rst = 0;
        
        // Write operations
        #10 write = 2'b10; address = 2'b00; data_a = 4'b1010; // Write A to Address 00
        #10 write = 2'b01; address = 2'b01; data_b = 4'b1100; // Write B to Address 01
        #10 write = 2'b10; address = 2'b10; data_a = 4'b0110; // Write A to Address 10
        #10 write = 2'b01; address = 2'b11; data_b = 4'b1111; // Write B to Address 11

        // Disable write (Enable Read)
        #10 write = 2'b00;
        
        // Read operations for Port A
        #10 read_a = 1; address_read_a = 2'b00;
        #10 address_read_a = 2'b01;
        #10 address_read_a = 2'b10;
        #10 address_read_a = 2'b11;
        
        // Read operations for Port B
        #10 read_b = 1; address_read_b = 2'b00;
        #10 address_read_b = 2'b01;
        #10 address_read_b = 2'b10;
        #10 address_read_b = 2'b11;

        // End simulation
        #20;
    end

    // Monitor output changes
    initial begin
        $monitor("Time=%0t | Write=%b | Addr=%b | DataA=%b | DataB=%b || Read_A=%b | Addr_A=%b | Out_A=%b || Read_B=%b | Addr_B=%b | Out_B=%b",
                 $time, write, address, data_a, data_b, 
                 read_a, address_read_a, data_out_a, 
                 read_b, address_read_b, data_out_b);
    end

endmodule
