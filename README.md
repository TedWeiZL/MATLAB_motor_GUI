# MATLAB_motor_GUI

### Project Overview
  In this project, a bipolar stepper motor, A4988 motor driver, and Arduino UNO board are assembled such that the ***motor can be controlled
  via this MATLAB GUI***. This GUI is also responsible for controlling a webcam together with the Arduino board.
  
### Hardware needed
  * a bipolar stepper motor
  * A4988 motor driver
  * Arduino UNO board
  * Arduino UNO prototyping board (optional)
  * Logitech C170 Webcam
  * 16-24V DC power supply
  * Abundant amount of wires
  
### To use GUI
  1. Make sure both ***Arduino UNO board*** and the ***webcam*** are ***plugged in***, otherwise MATLAB will not be able to launch the GUI.
  
  2. The Arduino board can exist as *USB serial Ports(COM3)* or *USB serial Ports(COM4)* depending on the pc. This GUI is designed assuming the Arduino board is detected as *USB serial Ports(COM3)*.
     The port name can be found in *Device Manager* in window system.
     If the port name is other than 'com3', change .m file accordingly: 
                        at line 66 : a=arduino('com3','uno');
