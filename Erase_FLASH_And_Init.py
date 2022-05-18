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
print( "Usage>  python Erase_FLASH_And_Init.py COM11 115200 ")
print( "You will have to change the BAUD rate of the Control board manually.  ")
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


# Open up serial port and print the menu from the control board	
ser = serial.Serial(COM_Port, BaudRate, timeout=.5, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE, bytesize=serial.EIGHTBITS, rtscts=0)
sio = io.TextIOWrapper(io.BufferedRWPair(ser, ser))

# Disable the software watchdog
sio.write(str("x"))
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(500)
print(s)

# get to Image/FLASH Sub-menu
sio.write(str("p"))
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(1000)
print(s)

# Erase FLASH in blocks
sio.write(str("4"))
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(1000)
print(s)

# Enter in starting block and return
sio.write(str("0\r"))
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(1000)
print(s)

ser.timeout=1            # change the timeout to give the MCU time to get all the information
# Enter in ending block and return
sio.write(str("32\r"))
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(50000)
print(s)

# At this point the MCU is erasing the FLASH which takes several seconds, it prints out a bunch of messages

#get back to the main menu
ser.timeout=2
sio.write(str("8"))       #get back to the main menu
sio.flush() # it is buffering. required to get the data out *now*
s2 = sio.read(5000)


ser.timeout=1            # change the timeout to give the MCU time to get all the information
#Now that the FLASH has been erased, put in defaults for the LED EEPROM, these defaults are stored in the FLASH
#The defaults are programmed into the LED EEPROM at manufacture time (not done as part of this script.)
#The UART in the MCU has an 12 byte receiver buffer (4 bytes in hardware, 8 bytes in software driver for UART peripheral)
#Since we are sending data fast (2MBAUD) we will not want to send more than 12 bytes at a time, before introducing a wait statement
sio.write(str("n"))
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(1000)
print(s)

#The EEPROM menu takes a decent amount of time to print so we'll increase the wait time here significantly
ser.timeout=5            # change the timeout to give the MCU time to get all the information
sio.write(str("1"))
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(10000)
print(s)


# Send the string of data to the MCU one character at a time, reading the echo character back after each transmitted character
# Note that the Index limit has to be set to the amount of characters of the string you want to send
# The carriage return character is automatically sent - unless you want to comment it out
# For ref -->     ---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|
String_To_Send = "MuReva PT       MuReva          LED Board       123456          A               000001          12/07/2018      12:32 PM"
Index = 0
ser.timeout=.05            # change the timeout to give the MCU time to get all the information
while 1:
	sio.write(String_To_Send[Index])
	sio.flush() # it is buffering. required to get the data out *now*
	s = sio.read(10)
	print(s)
	Index = Index + 1
	if Index == 120 :
		break
# Now send the carriage return and read back the return string
ser.timeout=1            # change the timeout to give the MCU time to get all the information
sio.write(str("\r"))
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(500)
print(s)



# Send the string of data to the MCU one character at a time, reading the echo character back after each transmitted character
# Note that the Index limit has to be set to the amount of characters of the string you want to send
# The carriage return character is automatically sent - unless you want to comment it out
# For ref -->     ---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|
String_To_Send = "1350"
Index = 0
ser.timeout=.05            # change the timeout to give the MCU time to get all the information
while 1:
	sio.write(String_To_Send[Index])
	sio.flush() # it is buffering. required to get the data out *now*
	s = sio.read(10)
	print(s)
	Index = Index + 1
	if Index >= 4 :
		break
# Now send the carriage return and read back the return string
ser.timeout=.5            # change the timeout to give the MCU time to get all the information
sio.write(str("\r"))
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(100)
print(s)

#get back to the main menu
ser.timeout=2
sio.write(str("8"))       #get back to the main menu
sio.flush() # it is buffering. required to get the data out *now*
s2 = sio.read(5000)


#Now program the User Interface default settings.  The UI defaults are actually held in the MCU software
#This code here will just program the FLASH with those defaults.
#It is possible to change the FLASH-held UI settings after the defaults have been programmed
#That could also be done here if desired
ser.timeout=5            # change the timeout to give the MCU time to get all the information
sio.write(str("o"))
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(1000)
print(s)

sio.write(str("1"))		# Initialize a settings to their default
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(1000)
print(s)

sio.write(str("Y"))
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(5000)
print(s)

#get back to the main menu
ser.timeout=2
sio.write(str("5"))       #get back to the main menu
sio.flush() # it is buffering. required to get the data out *now*
s2 = sio.read(5000)

print( "the end" )
ser.close()

time.sleep(1)

sys.exit()    # terminates the python script

