module Light_Switcher#(parameter n = 10000000)(
	input clk, //CLOCK_50_B5B
	
	output reg[9:0] red_lights = 10'b1010101010,
	output reg[7:0] green_lights = 8'b10101010
);

reg clk_out;

integer counter = 0;
always @(posedge clk)
	begin
		if (counter == ((n>>1) - 1))
			begin
				counter <= 0;
				clk_out <= ~clk_out;
			end
		else
			counter <= counter + 1;
	end

	
	
always @(posedge clk_out) begin
	if (red_lights[9] == 1) begin
		red_lights[9:0] <= 10'b0101010101;
		green_lights[7:0] <= 8'b01010101;
	end
	
	else begin
		red_lights = 10'b1010101010;
		green_lights = 8'b10101010;
	end
end
	


endmodule

