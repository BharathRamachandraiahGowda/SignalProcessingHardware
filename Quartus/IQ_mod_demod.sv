module IQ_mod_demod(
input logic clk,input logic reset_n,
input logic [7:0] freq_tuning_word,
output logic enable_out,
output logic [23:0] q
);

	logic [10:0] time_base = 0;
	always_ff@(posedge clk)
		if(reset_n == 1'b0)
			time_base <= 11'd0;
		else
			time_base <= (time_base + 1'b1) % 1041;
			
	logic enable; assign enable = (time_base == 11'd1040) ? 1'b1 : 1'b0;
	assign enable_out = enable;
	logic [7:0] phase_accumulator = 0;
	always_ff@(posedge clk)
		if(reset_n == 1'b0)
			phase_accumulator <= 8'd0;
		else
			if(enable)
				phase_accumulator <= phase_accumulator + freq_tuning_word;
				
	logic [23:0] lut_rom [0:2**8-1];
	
	initial 
		$readmemh("sine_0_360_24bit_256.txt",lut_rom);
		
	always_ff@(posedge clk)
		q <= lut_rom[phase_accumulator];
		
	endmodule
			