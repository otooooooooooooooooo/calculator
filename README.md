$Calculator

(c) Otar Kalandadze

Calculator program for FPGA board (cyclone V gx starter kit) with 7-segment display support.
Light switcher module is just for decoration (light flicking and transferring illusion), hence can be ommited.

Controls:

buttons[3:0] increase 4 digits of currently displayed number

calculation loop:
switch[0] first cycle (-> On -> Off) - save first operand (currently displayed on screen)
second cycle - save second operand
third cycle - save operation (0 -> +, 1 -> -, 2 -> x)
result is displayed




P.S.
language not worth to learn unless you want to specialize in hardware development
