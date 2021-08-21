module Number_Displayer(

//////////////////////////////////////////
	input [3:0] buttons,
	//4 displayed digits from right to left
	
	input reset, //reset displayed numbers
	input next_op, //move to next operation and save current value
	input calculator_reset, //reset calculator
	input set,
	
	input clk,
	
	output [6:0] display0,
	output [6:0] display1,
	output [6:0] display2,
	output [6:0] display3,
	
	output [9:0] red_lights,
	output [7:0] green_lights
	
	//TODO keep actual value in bigger vector
	
	
);
////////////////////////////////////////

wire [3:0] digit_value0;
wire [3:0] digit_value1;
wire [3:0] digit_value2;
wire [3:0] digit_value3;

reg [3:0] digit_value_setter0 = 0;
reg [3:0] digit_value_setter1 = 0;
reg [3:0] digit_value_setter2 = 0;
reg [3:0] digit_value_setter3 = 0;

Digital_Number dn0(.button(buttons[0]), .reset(reset), .set(set), .input_value(digit_value_setter0[3:0]), .displayed_value(display0[6:0]), .output_value(digit_value0[3:0]));
Digital_Number dn1(.button(buttons[1]), .reset(reset), .set(set), .input_value(digit_value_setter1[3:0]), .displayed_value(display1[6:0]), .output_value(digit_value1[3:0]));
Digital_Number dn2(.button(buttons[2]), .reset(reset), .set(set), .input_value(digit_value_setter2[3:0]), .displayed_value(display2[6:0]), .output_value(digit_value2[3:0]));
Digital_Number dn3(.reset(reset), .set(set), .input_value(digit_value_setter3[3:0]), .displayed_value(display3[6:0]), .output_value(digit_value3[3:0]));


Light_Switcher ls0(.clk(clk), .red_lights(red_lights[9:0]), .green_lights(green_lights[7:0]));
////////////////////////////////////////


wire[15:0] displayed_full_value;
assign displayed_full_value[15:0] = digit_value0[3:0] + 10 * digit_value1[3:0] + 100 * digit_value2[3:0] + 1000 * digit_value3[3:0];
//assign displayed_value[9:0] = digit_value0[3:0] + 10 * digit_value1[3:0] + 100 * digit_value2[3:0] + 1000 * digit_value3[3:0];

////////////////////////////////////////

////////////////////////////////////////
integer step_number = 0;
integer operand1 = 0;
integer operand2 = 0;
integer result = 0;
////////////////////////////////////////

////////////////////////////////////////


always @(posedge calculator_reset or negedge next_op)
begin
	if (calculator_reset == 1) begin
		step_number <= 0;
		digit_value_setter0[3:0] <= 0;
		digit_value_setter1[3:0] <= 0;
		digit_value_setter2[3:0] <= 0; 
		digit_value_setter3[3:0] <= 0;
		operand1 = 0;
		operand2 = 0;
	end
	
	else begin

		
			if (step_number == 0) 
			begin
			operand1 <= displayed_full_value[15:0];
			end
			
			else if (step_number == 1) 
			begin
			operand2 <= displayed_full_value[15:0];
			end
			
			else if (step_number == 2)
			begin
			case (digit_value0[3:0])
				4'b0000: result = operand1 + operand2;
				4'b0001: result = operand1 - operand2;
				4'b0010: result = operand1 * operand2;
				default: result = 7777;
			endcase
			
				digit_value_setter0[3:0] = result % 10;
				digit_value_setter1[3:0] = (result % 100 - result % 10) / 10;
				digit_value_setter2[3:0] = (result % 1000 - result % 100) / 100; 
				digit_value_setter3[3:0] = (result - result % 1000) / 1000;
			end

		step_number <= (step_number + 4)%3;
		
		
		end
		
end
////////////////////////////////////////
	
endmodule
