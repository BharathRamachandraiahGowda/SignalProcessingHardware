module lp_filter(
	input logic clk, input logic reset_n,
	input logic [15:0] d,
	output logic [15:0] q
);

	logic [15:0] delay = 0;

	always_ff@(posedge clk)
		if(reset_n == 0)
			delay <= 0;
		else
			delay <= d;

	logic [16:0] sum = 0;

	always_ff@(posedge clk)
		if(reset_n == 0)
			sum <= 0;
		else
			sum <= d + delay;

	assign q = sum[16:1];

endmodule