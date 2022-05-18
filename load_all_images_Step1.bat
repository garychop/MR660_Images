REM    06 October 2021

REM [chop] SET PORT=COM6
SET PORT=COM5	
SET SPEED=115200
REM [chop]SET PATH=images
SET IMAGE_PATH=images
REM [chop]SET PYTHON_PATH="C:\Program Files\Python37\python.exe"
SET PYTHON_PATH=python.exe

SET /A OLD_IMAGES=0
SET /A DO_ALL_IMAGES=0

REM    This batch file initializes the FLASH with all settings and images
REM    Note that you should choose an appropriate com port and BAUD rate
REM    The MCCP2221 should only be used with 115.200 kBAUD but the FTDI can be used at 235.294 kBAUD
REM

REM    %PYTHON_PATH% Set_BAUD_115200.py %PORT% %SPEED%
REM    %PYTHON_PATH% Set_BAUD_235294.py %PORT% %SPEED%

REM    Show the previous images information before erase
%PYTHON_PATH% Table_Of_Images.py %PORT% %SPEED%

