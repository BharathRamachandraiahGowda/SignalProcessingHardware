module IQ_mod_demod(
input logic clk,input logic reset_n,
input logic [7:0] freq_tuning_word,
output logic enable_out,
output logic [23:0] q_I_carrier,
output logic [23:0] q_Q_carrier,
output logic [23:0] q_gen_input1,
output logic [23:0] q_gen_input2,
output logic [47:0] q_I_mod,
output logic [47:0] q_Q_mod,
output logic [48:0] q_y_mod
);

	logic [10:0] time_base_carrier = 0;
	logic [15:0] time_base_input = 0;
	always_ff@(posedge clk)
		if(reset_n == 1'b0)
			begin
				time_base_carrier <= 11'd0;
				time_base_input <= 16'd0;
			end
		else
			begin
				time_base_carrier <= (time_base_carrier + 1'b1) % 1041;
				time_base_input <= (time_base_input + 1'b1) % 10401;
			end
			
	logic enable_carrier; 	assign enable_carrier = (time_base_carrier == 11'd1040) ? 1'b1 : 1'b0;
	logic enable_input; 		assign enable_input = (time_base_input == 16'd10400) ? 1'b1 : 1'b0;
	
	assign enable_out = enable_carrier;
	
	logic [7:0] phase_accumulator_carrier = 0, phase_accumulator_input = 0;
	
	always_ff@(posedge clk)
		if(reset_n == 1'b0)
			begin
				phase_accumulator_carrier <= 8'd0;
				phase_accumulator_input <= 8'd0;
			end
		else
			begin
				if(enable_carrier)
					phase_accumulator_carrier <= phase_accumulator_carrier + freq_tuning_word;
				if(enable_input)
					phase_accumulator_input <= phase_accumulator_input + freq_tuning_word;					
			end
				
	logic [23:0] lut_rom [0:2**8-1];
	
	initial 
		$readmemh("sine_0_360_24bit_256.txt",lut_rom);
		
	always_ff@(posedge clk)
		begin
			q_I_carrier 	<= lut_rom[phase_accumulator_carrier];
			q_Q_carrier 	<= 0;
			q_gen_input1 	<= lut_rom[phase_accumulator_input];
			q_gen_input2 	<= 0;
			q_I_mod			<= lut_rom[phase_accumulator_carrier] * lut_rom[phase_accumulator_input];
			q_Q_mod			<= q_gen_input2 * q_Q_carrier;
			q_y_mod			<= q_I_mod + q_Q_mod;
		end
	endmodule
			