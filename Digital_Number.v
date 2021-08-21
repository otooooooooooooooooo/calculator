module Digital_Number(
	/////////////////////////////////////////////
	input button, //button to control digit
	input reset, //reset signal for to set number to 0
	input set, //signal to set number to input value
	input [3:0] input_value, //input to set value manually
	
	output[6:0] displayed_value, //value to pass to 7-segment display 
	output[3:0] output_value //actual number value
	////////////////////////////////////////////
	
	);
	
///////////////////////////////////////////////
//mapping integer to displayable binary
//0 means lit on, 1 means lit off.
//7-segment display is indexed as followed:

// 0
//5 1
// 6
//4 2
// 3
function [6:0] map;
	input integer number;
	
	case (number)
		0: map = 7'b1000000;
		1: map = 7'b1111001;
		2: map = 7'b0100100;
		3: map = 7'b0110000;
		4: map = 7'b0011001;
		5: map = 7'b0010010;
		6: map = 7'b0000010;
		7: map = 7'b1111000;
		8: map = 7'b0000000;
		9: map = 7'b0010000;
	endcase
	
endfunction
////////////////////////////////////////////////

////////////////////////////////////////////////
integer number = 0;
assign output_value[3:0] = number; 
assign displayed_value[6:0] = map(number);
////////////////////////////////////////////////

////////////////////////////////////////////////
	
always @(negedge button or posedge reset or posedge set) 
begin
	if (reset == 1)
		number <= 0;
	else if(set == 1)
		number <= input_value[3:0];
	
	else
		number <= (number + 1)%10;
end

////////////////////////////////////////////////
	
endmodule
