`timescale 1ns/1ps
`define FULL_CLOCK_PERIOD 20
`define HALF_CLOCK_PERIOD 10
`define RESET_PERIOD 4000
`define SIM_DURATION 2000000000

module IQ_mod_demod_tb();

	// ### clock generation process ...
	logic tb_local_clock = 0;
	initial
		begin: clock_generation_process
		tb_local_clock = 0;
		forever begin
		#`HALF_CLOCK_PERIOD tb_local_clock = ~tb_local_clock;
		end
	end

	logic tb_local_reset_n = 1'b0;
	logic [7:0] tb_test_sig = 8'b00000101;
	logic [23:0] tb_q;
	logic tb_enable;

//	logic [23:0] test_signal_rom [2**8-1:0];

	integer i;

	initial
		begin: reset_generation_process
		$display ("Simulation starts ...");
		reset_filter;
//		$readmemh("sine_0_360_24bit_256.txt", test_signal_rom);
//		
//		for (i = 0; i < 256; i = i+1) begin
//			#`FULL_CLOCK_PERIOD tb_test_sig = (test_signal_rom[i]);
//		end
	#`SIM_DURATION
	$display ("Simulation done ...");
	$stop();
	end

	IQ_mod_demod IQ_mod_demod_inst (.clk(tb_local_clock),
	.reset_n(tb_local_reset_n),
	.freq_tuning_word(tb_test_sig),
	.enable_out(tb_enable),
	.q(tb_q));

	task reset_filter; begin
	tb_local_reset_n = 1'b0;
	#`RESET_PERIOD
	tb_local_reset_n = 1'b1;
	end
	endtask

endmodule