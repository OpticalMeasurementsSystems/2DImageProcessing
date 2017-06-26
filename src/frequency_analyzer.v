`timescale 1ns / 1ps

module frequency_analyzer #
(
    // FREQUENCY_2 MUST ALWAYS BE GREATER THAN FREQUENCY_1
    parameter DEFAULT_FREQUENCY0 = 9000,                   // i.e. 9  kHz
    parameter DEFAULT_FREQUENCY1 = 11000,                  // i.e. 11 kHz
    parameter DEFAULT_FREQUENCY0_DEVIATION = 10,           // in percents
    parameter DEFAULT_FREQUENCY1_DEVIATION = 10,           // in percents
    parameter CLOCK_FREQUENCY = 50000000           // i.e. 50 MHz
)
(
    input wire sample_data,
    input wire clock,
    input wire enable,
    input wire clear,
    input wire[31:0] f0,             // this value must be already calculated
    input wire[31:0] f1,             // this value must be already calculated
    input wire[31:0] f0_deviation,   // this value must be already calculated
    input wire[31:0] f1_deviation,   // this value must be already calculated
    output wire[31:0] f0_value,
    output wire[31:0] f1_value,
    output wire [31:0] unknown
);

localparam integer frequency0_ticks = CLOCK_FREQUENCY / (2 * DEFAULT_FREQUENCY0);
localparam integer frequency1_ticks = CLOCK_FREQUENCY / (2 * DEFAULT_FREQUENCY1);

localparam integer frequency0_deviation = (frequency0_ticks * DEFAULT_FREQUENCY0_DEVIATION) / 100;
localparam integer frequency1_deviation = (frequency1_ticks * DEFAULT_FREQUENCY1_DEVIATION) / 100;

reg[31:0] using_frequency0;
reg[31:0] using_frequency0_deviation;
reg[31:0] using_frequency1;
reg[31:0] using_frequency1_deviation;

reg[31:0] frequency_counter = 0;
reg[31:0] frequency0_counter = 0;
reg[31:0] frequency1_counter = 0;
reg[31:0] unassigned_frequency = 0;

reg start_sample_value;
reg[1:0] check_result;

assign f0_value = frequency0_counter;
assign f1_value = frequency1_counter;
assign unknown = unassigned_frequency;

initial
begin
    frequency_counter = 0;
    frequency0_counter = 0;
    frequency1_counter = 0;
    unassigned_frequency = 0;
end

always @(posedge clock) 
begin
    if(!clear) 
    begin
        unassigned_frequency = 0;
        start_sample_value = 0;
        frequency0_counter = 0;
        frequency1_counter = 0;
        frequency_counter = 0;
        check_result = 0;
        using_frequency0 = frequency0_ticks;
        using_frequency0_deviation = frequency0_deviation;
        using_frequency1  = frequency1_ticks;
        using_frequency1_deviation = frequency1_deviation;
    end
    
    else
    begin
        if(enable) 
        begin
            // todo : umv: update using values
            if(frequency_counter == 0)// && start_sample_value != sample_data)
                start_sample_value = sample_data;
            if(sample_data != start_sample_value) 
            begin
                start_sample_value = sample_data;
                check_result = check_frequency(frequency_counter);          
                if(check_result == 2)
                    frequency1_counter = frequency1_counter + frequency_counter;
                else if(check_result == 1)
                    frequency0_counter = frequency0_counter + frequency_counter;
                else unassigned_frequency = unassigned_frequency + frequency_counter;          
                frequency_counter = 0;           
            end
            frequency_counter = frequency_counter + 1;
        end
        else 
        begin
            if(frequency_counter > 0)
            begin
                unassigned_frequency = unassigned_frequency + frequency_counter;;
                frequency_counter = 0;
            end
        end
    end
end

function[1:0] check_frequency(input reg[31:0] frequency);
    reg[1:0] result;    
    begin
        //todo: umv: first approach frequency could have deviation
        if(frequency >= frequency0_ticks - frequency0_deviation && frequency <= frequency0_ticks + frequency0_deviation)
            result = 1;
        else if(frequency >= frequency1_ticks - frequency1_deviation && frequency <= frequency1_ticks + frequency1_deviation)
            result = 2;
        else result = 0;
        
        check_frequency = result;
    end
endfunction

endmodule
