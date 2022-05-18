REM    06 October 2021

REM [chop] SET PORT=COM6
SET PORT=COM5	
SET SPEED=115200
REM [chop]SET PATH=images
SET IMAGE_PATH="images"
REM [chop]SET PYTHON_PATH="C:\Program Files\Python37\python.exe"
SET PYTHON_PATH=python.exe

SET /A OLD_IMAGES=1
SET /A DO_ALL_IMAGES=0

REM    This batch file initializes the FLASH with all settings and images
REM    Note that you should choose an appropriate com port and BAUD rate
REM    The MCCP2221 should only be used with 115.200 kBAUD but the FTDI can be used at 235.294 kBAUD
REM

REM    %PYTHON_PATH% Set_BAUD_115200.py %PORT% %SPEED%
REM    %PYTHON_PATH% Set_BAUD_235294.py %PORT% %SPEED%

REM    Show the previous images information before erase
IF /I "%OLD_IMAGES%" EQU "1" (
    %PYTHON_PATH% Table_Of_Images.py %PORT% %SPEED%
)

REM    Erase flash
REM    %PYTHON_PATH% Erase_FLASH_And_Init.py %PORT% %SPEED%

REM    Build the image file in the FLASH by writing images one at a time.  Note that you only specify the
REM    the starting page in FLASH where the image is stored, therefore you must calculate how many pages
REM    the image file will require and then calculate the next possible starting page for the next image.
REM    The ID is used by the software to select the image for writing to the screen at the position
REM    coordinates given in this batch file.
REM    
REM    The FLASH is partitioned to allow image data to be stored starting at page 1024 to 8191
REM    Full screen images require 600 pages of the FLASH:  320 * 240 * 2B/pix = 600 * 256B = 600 pages
REM    Medium screen images require 222 pages of the FLASH:  190 * 150 * 2B/pix = 222 * 256B = 222 pages
REM    Small error messages and user interface messages require 50 pages:  89 * 71 * 2B/pix = 50 pages  
REM
REM                            Com   BAUD          Filename                       Description       ID  Start XPOS YPOS
REM    
REM   -------------------------------------------------------------------------------------------------- Full screen images
REM %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_Full_0_0_Rev3.bmp "Clock Image Full" 4000 1100 0 0
REM %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/MuReva_Logo_Rev2.bmp "Mureva logo" 1000 2300 0 0

REM %PYTHON_PATH% Table_Of_Images.py %PORT% %SPEED%
