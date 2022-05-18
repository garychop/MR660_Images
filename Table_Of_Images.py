#! /usr/bin/python3


import time     # needed for the sleep command
import datetime # needed to get the date and time stamp for the image file upload
import sys      # needed for the exit
import io
import serial   # needed for serial port, can be installed:  DOS>> python -m pip install pyserial
import numpy as  np    # for common math routines
#import collections

# Note that in python3, the print is now a function and requires parenthesis

print( "--------------------------------------------------------------")
print( " inside of a DOS command shell                                ")
print( "  ")
print( "Usage>  python Table_Of_Images.py COM11 115200 ")
print( "Make sure control board BAUD rate matches with the argument.  ")
print( "Make sure COM port is open for use (putty window closed).     ")
print( "Make sure control board is in menu mode - not hung up somewhere in a submenu task. ")
print( "Watchdog should be turned off.                                ")
print( "  ")
print( "You can also get a simple terminal by typing  ")
print( "python -m serial.tools.miniterm COM11 115200  \n\r")
print( "ctrl-] to escape terminal mode  \n\r")

	
COM_Port = sys.argv[1]
BaudRate = sys.argv[2]

# Notes on communicating to MuReva control board via python
# The UART in the MCU can only buffer 4 bytes so be careful to give the MCU time to consume the data by putting in delays between individual characters
# You must anticipate how many characters the MCU will send back to you AND how long it will take the MCU to send that data.
# Set the ser.timeout=X  where X = an appropriate amount of time in seconds to wait for all the data to be sent from the MCU
# This timeout value should be evaluated for each "transfer" between the python app and the MCU
# Make sure to read all the data sent by the MCU, you can even read more than what will be sent, it will just timeout wrt X
# Always follow this sequence:  write --> flush --> read()  without any time delays inserted between

# Open up serial port and print the FLASH Image submenu from the control board	
ser = serial.Serial(COM_Port, BaudRate, timeout=.1, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE, bytesize=serial.EIGHTBITS, rtscts=0)
sio = io.TextIOWrapper(io.BufferedRWPair(ser, ser))

ser.timeout=0.5            # change the timeout to a little longer to give the MCU time to get all the information
sio.write(str("x"))       #turn off the software watchdog
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(500)
print(s)

sio.write(str("p"))       # get to the FLASH submenu
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(1000)
print(s)

ser.timeout=2            # change the timeout to a little longer to give the MCU time to get all the information
sio.write(str("2")); sio.flush();    #select to get the table of stored images
s = sio.read(20000)
print(s)  #debug only

ser.timeout=2
sio.write(str("8"))       #get back to the main menu
sio.flush() # it is buffering. required to get the data out *now*
s2 = sio.read(5000)


ser.close()
sys.exit()    # terminates the python script




