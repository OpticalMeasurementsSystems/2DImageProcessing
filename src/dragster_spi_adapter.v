`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2017 12:07:19
// Design Name: 
// Module Name: dragster_spi_adapter
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


module dragster_spi_adapter #
(
    parameter number_of_slaves = 2
)
(
    input wire reset,
    input wire clock,
    
    input wire mosi_int,
    output wire miso_int,
    input wire sck_int,
    input wire[number_of_slaves - 1:0] ss_int,
    
    output wire mosi_ext,
    input wire miso_ext,
    output wire sck_ext,
    output wire [number_of_slaves - 1:0] ss_ext);
    
/* ������ ��������� �� MOSI � �������� ������ �����
   ����� ���� �� slave select ������ (=0). */

/* 8-�� ������ ������� ��������������� ��� �������� ������
  (�������� 2-�� �����). */
reg[7:0] address;

/* ������� �������� � ������� 16. */
reg[5:0] bit_count;

/* ������������ �������� ��������� ���������� � ss_maximum_value. */
localparam ss_maximum_value = 2 ** number_of_slaves - 1;

/* �������� ������� SPI �� ������� �����.*/
assign mosi_ext = mosi_int;
assign miso_ext = miso_int;

assign sck_ext = sck_int;
assign ss_ext = ss_int;

/* ������� �������� ������� ��������� ������. */
reg[2:0] state;

localparam WAIT_FOR_OPERATION = 0;

/* ������� �������� ��� �������� ���������� ����� �������� 8-������� ������ �� ������� ����� 15. */ 
reg operation;

/* ��������� �������������� ����� ���� ��������. */
localparam READ = 0 , WRITE = 1;

reg sm2_state;
reg sm1_finished;

always @(posedge clock or negedge reset) begin
    case(sm2_state)
        0: begin
            if(sm1_finished) begin
            
            end
        end
   endcase
end

always @(posedge sck_int or negedge reset) begin
    if(!reset) begin
        state = WAIT_FOR_OPERATION;
    end
    
    else 
        case(state)
            WAIT_FOR_OPERATION: begin
                if(ss_int != ss_maximum_value) begin       
                    if(bit_count > 7) begin
                        /* � 9-��� ���� �� ����� ������������������. */
                        address[bit_count] <= mosi_int;
                    end
                
                    /* ����������� �������. */
                    if(bit_count < 15) begin
                        bit_count <= bit_count + 1;
                    end
                
                    /* ������������ ��������� ��� 16-������ ������������������. */
                    else begin
                        state <= 1;
                        bit_count <= 0;
                        
                        /* ���� �������� ����� 15, ������ ���������� ������. */
                        if(address == 240)
                            operation <= READ;
                        else
                            operation <= WRITE;
                    end
                end
            end
            
            1: begin
                
            end
            
            2:;
        endcase 
end

endmodule
