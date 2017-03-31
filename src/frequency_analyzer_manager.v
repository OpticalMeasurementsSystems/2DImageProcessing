`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2017 05:12:24 PM
// Design Name: 
// Module Name: frequency_analyzer_manager
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


module frequency_analyzer_manager #
(
    // Parameters of Axi Slave Bus Interface S00_AXI
    parameter integer C_S00_AXI_DATA_WIDTH = 32,
    parameter integer C_S00_AXI_ADDR_WIDTH = 10,
    parameter integer PIXEL0_INDEX = 15,
    parameter integer PIXEL1_INDEX = 511,
    parameter integer PIXEL2_INDEX = 1023,
    parameter integer PIXEL0_FREQUENCY0 = 9000,
    parameter integer PIXEL0_FREQUENCY1 = 11000,
    parameter integer PIXEL1_FREQUENCY0 = 15000,
    parameter integer PIXEL1_FREQUENCY1 = 20000,
    parameter integer PIXEL2_FREQUENCY0 = 25000,
    parameter integer PIXEL2_FREQUENCY1 = 30000,
    parameter integer FREQUENCY_DEVIATION = 10,
    parameter integer CLOCK_FREQUENCY = 100000000
)
(
    input wire [7:0] data,
    input wire pixel_clock,
    input wire start,
    input wire stop,
    input wire clear,
    output wire irq,
    // Ports of Axi Slave Bus Interface S00_AXI
    input wire  s00_axi_aclk,
    input wire  s00_axi_aresetn,
    input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
    input wire [2 : 0] s00_axi_awprot,
    input wire  s00_axi_awvalid,
    output wire  s00_axi_awready,
    input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
    input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
    input wire  s00_axi_wvalid,
    output wire  s00_axi_wready,
    output wire [1 : 0] s00_axi_bresp,
    output wire  s00_axi_bvalid,
    input wire  s00_axi_bready,
    input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
    input wire [2 : 0] s00_axi_arprot,
    input wire  s00_axi_arvalid,
    output wire  s00_axi_arready,
    output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
    output wire [1 : 0] s00_axi_rresp,
    output wire  s00_axi_rvalid,
    input wire  s00_axi_rready
);
    
    // todo: set it from image_capture_manager
    //localparam integer pixel_0_index = 15;
    //localparam integer pixel_1_index = 511;
    //localparam integer pixel_2_index = 1023;
    localparam integer registers_number = 6;
    
    // frequency analyzer data
    reg pixel0_sample_data;
    reg pixel1_sample_data;
    reg pixel2_sample_data;
    reg [9:0] pixel_counter;
    wire enable;
    // axi register access
    reg[31:0] register_write;
    reg[1:0] register_operation;
    reg[7:0] register_number;
    wire[31:0] register_read;
    //reg[2:0] register_counter;
    reg write_completed;
    
    // frequency analyzer frequencies times
    reg [31:0] pixel0_f0_action_time;
    reg [31:0] pixel0_f1_action_time;
    reg [31:0] pixel1_f0_action_time;
    reg [31:0] pixel1_f1_action_time;
    reg [31:0] pixel2_f0_action_time;
    reg [31:0] pixel2_f1_action_time;    
    wire [31:0] pixel0_f0_action_time_net;
    wire [31:0] pixel0_f1_action_time_net;
    wire [31:0] pixel1_f0_action_time_net;
    wire [31:0] pixel1_f1_action_time_net;
    wire [31:0] pixel2_f0_action_time_net;
    wire [31:0] pixel2_f1_action_time_net;
    
    always @(*)
    begin
        pixel0_f0_action_time = pixel0_f0_action_time_net;
        pixel0_f1_action_time = pixel0_f1_action_time_net;
        pixel1_f0_action_time = pixel1_f0_action_time_net;
        pixel1_f1_action_time = pixel1_f1_action_time_net;
        pixel2_f0_action_time = pixel2_f0_action_time_net;
        pixel2_f1_action_time = pixel2_f1_action_time_net;
    end
    
    supply1 vcc;
    
    // enable generator
    FDCE #(.INIT(0)) enable_generator(.C(start), .CE(s00_axi_aresetn), .D(vcc), .Q(enable), .CLR(stop));
    //todo: umv: set proper frequencies
    frequency_analyzer #(.FREQUENCY0(PIXEL0_FREQUENCY0), .FREQUENCY1(PIXEL0_FREQUENCY1), 
                         .FREQUENCY0_DEVIATION(FREQUENCY_DEVIATION), .FREQUENCY1_DEVIATION(FREQUENCY_DEVIATION),
                         .CLOCK_FREQUENCY(CLOCK_FREQUENCY)) 
         pixel0_analyzer(.sample_data(pixel0_sample_data), .clock(s00_axi_aclk), .enable(enable), .clear(clear), 
                         .f0_value(pixel0_f0_action_time_net), .f1_value(pixel0_f1_action_time_net));
                         
    frequency_analyzer #(.FREQUENCY0(PIXEL1_FREQUENCY0), .FREQUENCY1(PIXEL1_FREQUENCY1), 
                         .FREQUENCY0_DEVIATION(FREQUENCY_DEVIATION), .FREQUENCY1_DEVIATION(FREQUENCY_DEVIATION),
                         .CLOCK_FREQUENCY(CLOCK_FREQUENCY))
         pixel1_analyzer(.sample_data(pixel1_sample_data), .clock(s00_axi_aclk), .enable(enable), .clear(clear),
                          .f0_value(pixel1_f0_action_time_net), .f1_value(pixel1_f1_action_time_net));
                          
    frequency_analyzer #(.FREQUENCY0(PIXEL2_FREQUENCY0), .FREQUENCY1(PIXEL2_FREQUENCY1), 
                         .FREQUENCY0_DEVIATION(FREQUENCY_DEVIATION), .FREQUENCY1_DEVIATION(FREQUENCY_DEVIATION),
                         .CLOCK_FREQUENCY(CLOCK_FREQUENCY)) 
         pixel2_analyzer(.sample_data(pixel2_sample_data), .clock(s00_axi_aclk), .enable(enable), .clear(clear),
                         .f0_value(pixel2_f0_action_time_net), .f1_value(pixel2_f1_action_time_net));
    assign irq = stop;
    // Instantiation of Axi Bus Interface S00_AXI
    axi_slave_impl # 
    ( 
        .C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH),
        .NUMBER_OF_REGISTERS(registers_number)
    ) 
    frequency_analyzer_manager_inst 
    (
        .S_AXI_ACLK(s00_axi_aclk),
        .S_AXI_ARESETN(s00_axi_aresetn),
        .S_AXI_AWADDR(s00_axi_awaddr),
        .S_AXI_AWPROT(s00_axi_awprot),
        .S_AXI_AWVALID(s00_axi_awvalid),
        .S_AXI_AWREADY(s00_axi_awready),
        .S_AXI_WDATA(s00_axi_wdata),
        .S_AXI_WSTRB(s00_axi_wstrb),
        .S_AXI_WVALID(s00_axi_wvalid),
        .S_AXI_WREADY(s00_axi_wready),
        .S_AXI_BRESP(s00_axi_bresp),
        .S_AXI_BVALID(s00_axi_bvalid),
        .S_AXI_BREADY(s00_axi_bready),
        .S_AXI_ARADDR(s00_axi_araddr),
        .S_AXI_ARPROT(s00_axi_arprot),
        .S_AXI_ARVALID(s00_axi_arvalid),
        .S_AXI_ARREADY(s00_axi_arready),
        .S_AXI_RDATA(s00_axi_rdata),
        .S_AXI_RRESP(s00_axi_rresp),
        .S_AXI_RVALID(s00_axi_rvalid),
        .S_AXI_RREADY(s00_axi_rready),
        .register_operation(register_operation),
        .register_number(register_number),
        .register_read(register_read),
        .register_write(register_write)
    );
    
    always @(posedge pixel_clock)
    begin
        if(~clear || ~s00_axi_aresetn)
        begin
            pixel0_sample_data <= 0;
            pixel1_sample_data <= 0;
            pixel2_sample_data <= 0;
            pixel_counter <= 0;
        end
        else
        begin
            if(enable)
            begin
                pixel_counter <= pixel_counter + 1;
                if(pixel_counter == PIXEL0_INDEX)
                    pixel0_sample_data <= data[7];
                else if (pixel_counter == PIXEL1_INDEX)
                    pixel1_sample_data = data[7];
                else if (pixel_counter == PIXEL2_INDEX)
                    pixel2_sample_data = data[7];
            end
            if(write_completed)
            begin
                pixel0_sample_data <= 0;
                pixel1_sample_data <= 0;
                pixel2_sample_data <= 0;
                pixel_counter <= 0;
            end
        end
    end
    
    always @(posedge s00_axi_aclk) begin
        if(stop && ~write_completed) begin
            register_operation <= 2;//`REGISTER_WRITE_OPERATION;
            register_number <= register_number + 1;
            register_write <= 200 + register_number; 
                         //get_frequency(register_counter);
            if(register_number == registers_number - 1)
                write_completed <= 1;
        end
        
        /*for(register_counter = 0; register_counter < registers_number; register_counter = register_counter + 1) begin
            register_operation <= 2;//`REGISTER_WRITE_OPERATION;
            register_number <= register_counter + 1;
            register_write <= 255; 
                             //get_frequency(register_counter);
            if(register_counter == registers_number - 1)
                write_completed <= 1;
        end*/
        
        if(stop && write_completed) begin
            register_operation <= 0;
            register_number <= 0;
            register_write <= 0;
        end
        
        if(~stop) begin
            register_operation <= 0;
            register_number <= 0;
            register_write <= 0;
            write_completed <= 0;
        end
    end
    
    function [31:0] get_frequency;
    input reg[2:0] index;
        case (index)
        0: get_frequency = pixel0_f0_action_time;
        1: get_frequency = pixel0_f1_action_time;
        2: get_frequency = pixel1_f0_action_time;
        3: get_frequency = pixel1_f1_action_time;
        4: get_frequency = pixel2_f0_action_time;
        5: get_frequency = pixel2_f1_action_time;
        default: get_frequency = 0;
        endcase
    endfunction
    
endmodule
