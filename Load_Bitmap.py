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
print( "Usage>  python Load_Bitmap.py COM11 115200 Test_Image_40x40.bmp \"RGB Color Graphic\" 1234 10 20 30 ")
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
Filename = sys.argv[3]
Description = sys.argv[4]
Identifier = sys.argv[5]
Starting_Page = sys.argv[6]
XPOS = sys.argv[7]
YPOS = sys.argv[8]

# Notes on communicating to MuReva control board via python
# The UART in the MCU can only buffer 4 bytes so be careful to give the MCU time to consume the data by putting in delays between individual characters
# You must anticipate how many characters the MCU will send back to you AND how long it will take the MCU to send that data.
# Set the ser.timeout=X  where X = an appropriate amount of time in seconds to wait for all the data to be sent from the MCU
# This timeout value should be evaluated for each "transfer" between the python app and the MCU
# Make sure to read all the data sent by the MCU, you can even read more than what will be sent, it will just timeout wrt X
# Always follow this sequence:  write --> flush --> read()  without any time delays inserted between


DateStamp = datetime.datetime.now().strftime("%I:%M%p on %B %d, %Y")

	
	
Image_File = open(Filename, 'rb')   #open file for reading only, binary data

a = np.fromfile(Image_File, dtype=np.uint8, count=-1)   #loads the entire file into the array, this is an array of bytes


XDIM = a[18] + 256*a[19]
YDIM = a[22] + 256*a[23]

# Open up serial port and print the FLASH Image submenu from the control board	
ser = serial.Serial(COM_Port, BaudRate, timeout=.2, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE, bytesize=serial.EIGHTBITS, rtscts=0)
sio = io.TextIOWrapper(io.BufferedRWPair(ser, ser))

sio.write(str("x"))
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(500)
print(s)

sio.write(str("p"))
sio.flush() # it is buffering. required to get the data out *now*
s = sio.read(1000)
print(s)



sio.write(str("0")); sio.flush(); time.sleep(.2)    #select to write image to FLASH
s = sio.read(50)
if s == "SEND_IDENTIFIER" :
	sio.write(Identifier); sio.flush(); time.sleep(.2)   # send information
	s = sio.read(50)      #read out the echo characters so they do not interfere with the next message from the MCU
	sio.write("\r"); sio.flush(); time.sleep(.2)   # send return 
	print("sent Identifier")
else :
	print("not sending Identifier")

s = sio.read(50)    #note how this will read in a "new line" control character that will have to be part of the comparison
if s == "\nSEND_DESCRIPTION" :
	sio.write(Description); sio.flush(); time.sleep(.2)   # send information
	s = sio.read(500)      #read out the echo characters so they do not interfere with the next message from the MCU
	sio.write("\r"); sio.flush(); time.sleep(.2)   # send return 
	print("sent Description")
else :
	print("not sending Description")

s = sio.read(50)    #note how this will read in a "new line" control character that will have to be part of the comparison
if s == "\nSEND_STARTING_PAGE" :
	sio.write(Starting_Page); sio.flush(); time.sleep(.2)   # send information
	s = sio.read(50)      #read out the echo characters so they do not interfere with the next message from the MCU
	sio.write("\r"); sio.flush(); time.sleep(.2)   # send return 
	print("sent Starting_Page")
else :
	print("not sending Starting_Page")

s = sio.read(50)    #note how this will read in a "new line" control character that will have to be part of the comparison
if s == "\nSEND_XPOS" :
	sio.write(XPOS); sio.flush(); time.sleep(.2)   # send information
	s = sio.read(50)      #read out the echo characters so they do not interfere with the next message from the MCU
	sio.write("\r"); sio.flush(); time.sleep(.2)   # send return 
	print("sent XPOS")
else :
	print("not sending XPOS")

s = sio.read(50)    #note how this will read in a "new line" control character that will have to be part of the comparison
if s == "\nSEND_YPOS" :
	sio.write(YPOS); sio.flush(); time.sleep(.2)   # send information
	s = sio.read(50)      #read out the echo characters so they do not interfere with the next message from the MCU
	sio.write("\r"); sio.flush(); time.sleep(.2)   # send return 
	print("sent YPOS")
else :
	print("not sending YPOS")

s = sio.read(50)    #note how this will read in a "new line" control character that will have to be part of the comparison
if s == "\nSEND_XDIM" :
	sio.write(str(XDIM)); sio.flush(); time.sleep(.2)   # send information
	s = sio.read(50)      #read out the echo characters so they do not interfere with the next message from the MCU
	sio.write("\r"); sio.flush(); time.sleep(.2)   # send return 
	print("sent XDIM")
else :
	print("not sending XDIM")

s = sio.read(50)    #note how this will read in a "new line" control character that will have to be part of the comparison
if s == "\nSEND_YDIM" :
	sio.write(str(YDIM)); sio.flush(); time.sleep(.2)   # send information
	s = sio.read(50)      #read out the echo characters so they do not interfere with the next message from the MCU
	sio.write("\r"); sio.flush(); time.sleep(.2)   # send return 
	print("sent YDIM")
else :
	print("not sending YDIM")

s = sio.read(50)    #note how this will read in a "new line" control character that will have to be part of the comparison
if s == "\nSEND_DATESTAMP" :
	sio.write(DateStamp); sio.flush(); time.sleep(.2)   # send information
	s = sio.read(50)      #read out the echo characters so they do not interfere with the next message from the MCU
	sio.write("\r"); sio.flush(); time.sleep(.2)   # send return 
	print("sent DateStamp")
else :
	print("not sending DateStamp")

	
s = sio.read(1000)    #read a bunch of characters back from the MCU for status
print(s)


while 1:
	sio.write(str("N"))
	sio.flush() # it is buffering. required to get the data out *now*
	Request_String = sio.read(20)	     # make sure not to read more than necessary since more characters may be sent from the MCU
	print(Request_String)
	
	if Request_String == "Completed Image Load" :       #This exact string is sent by the MCU to indicate when we're done, note however that the MCU continues to send characters (menu update) and these should not be read in by this python utility
		break
		
	Index1 = Request_String.find("S")
	Index2 = Request_String.find("Q") 
	Index3 = Request_String.find("P")
	
	Offset = int(Request_String[Index1+1:Index2])
	Quantity = int(Request_String[Index2+1:Index3])

	# [Original] ser.write(a[Offset:Offset+Quantity]); sio.flush(); time.sleep(.06)   # send information, the sleep is a worst case amount of time to send one page (512 bytes worst case x 100uS/Byte)
	ser.write(a[Offset:Offset+Quantity]); sio.flush(); time.sleep(.01)   # send information, the sleep is a worst case amount of time to send one page (512 bytes worst case x 100uS/Byte)
	

ser.timeout=2
sio.write(str("8"))       #get back to the main menu
sio.flush() # it is buffering. required to get the data out *now*
s2 = sio.read(5000)	
	
	
print( "the end" )

ser.close()

Image_File.close()

time.sleep(1)

sys.exit()    # terminates the python script

