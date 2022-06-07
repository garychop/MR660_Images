REM    06 October 2021
REM G. Chop, Changed the starting position of the "White Text Box" and "Big Paused" bitmaps because
REM          it was overwritting other bitmaps.

REM [chop] SET PORT=COM6
SET PORT=COM5
SET SPEED=115200
REM [chop]SET PATH=images
SET IMAGE_PATH=images
REM [chop]SET PYTHON_PATH="C:\Program Files\Python37\python.exe"
SET PYTHON_PATH=python.exe

SET /A OLD_IMAGES=0
SET /A DO_ALL_IMAGES=1

REM    This batch file initializes the FLASH with all settings and images
REM    Note that you should choose an appropriate com port and BAUD rate
REM    The MCCP2221 should only be used with 115.200 kBAUD but the FTDI can be used at 235.294 kBAUD
REM

REM    %PYTHON_PATH% Set_BAUD_115200.py %PORT% %SPEED%
REM    %PYTHON_PATH% Set_BAUD_235294.py %PORT% %SPEED%

REM    Show the previous images information before erase
%PYTHON_PATH% Table_Of_Images.py %PORT% %SPEED%


REM    Erase flash
%PYTHON_PATH% Erase_FLASH_And_Init.py %PORT% %SPEED%

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
IF /I "%DO_ALL_IMAGES%" EQU "1" (
    REM   -------------------------------------------------------------------------------------------------- Full screen images
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/MuReva_Logo_Rev2.bmp "Mureva logo" 1000 2300 0 0
    REM %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_Full_0_0_Rev3.bmp "Clock Image Full" 4000 1100 0 0
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_Full_Small.bmp "Clock Image Full" 4000 1100 43 0
    REM   --------------------------------------------------------------------------------------------------
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/InsertMouthpiece_Text.bmp "Insert MCA Text" 2000 1700 76 88
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Reading_Text.bmp "Reading Text" 2001 1780 76 92
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Display_SerialNumber_Text.bmp "Show SN" 2002 1860 78 53
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/PressToStartTherapy_Text.bmp "Press Start" 2003 2026 78 53
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/MCA_ReadingError_Text.bmp "Read Error" 2004 2900 96 68
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Red_Text_Box.bmp "Red Box" 2005 3006 66 46
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/MouthpieceExpired_Text.bmp "MCA Expired" 2006 3230 76 92
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/MouthpieceDetached_Text.bmp "MCA Unplugged" 2007 3305 96 68
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Paused_Text.bmp "Paused" 2008 3412 126 72
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Blank_60x16.bmp "Blank 60x16" 2009 3420 125 70
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/TherapyComplete_Text.bmp "Therapy Complete" 2010 3430 104 88
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/MouthpieceDailyLimit_Text.bmp "Daily Limit" 2011 3480 76 78
    REM   --------------------------------------------------------------------------------------------------Clock images
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_60_152_3_Rev3.bmp "Clock Image 60" 4060 4700 152 3
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_59_153_3_Rev3.bmp "Clock Image 59" 4059 4708 153 3
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_58_156_4_Rev3.bmp "Clock Image 58" 4058 4720 156 4
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_57_166_6_Rev3.bmp "Clock Image 57" 4057 4736 166 6
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_56_175_8_Rev3.bmp "Clock Image 56" 4056 4752 175 8
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_55_179_13_Rev3.bmp "Clock Image 55" 4055 4772 179 13
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_54_177_18_Rev3.bmp "Clock Image 54" 4054 4790 177 18
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_53_191_25_Rev3.bmp "Clock Image 53" 4053 4814 191 25
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_52_197_32_Rev3.bmp "Clock Image 52" 4052 4838 197 32
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_51_199_40_Rev3.bmp "Clock Image 51" 4051 4858 199 40
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_50_202_48_Rev3.bmp "Clock Image 50" 4050 4878 202 48
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_49_202_57_Rev3.bmp "Clock Image 49" 4049 4898 202 57
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_48_209_69_Rev3.bmp "Clock Image 48" 4048 4918 209 69
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_47_211_80_Rev3.bmp "Clock Image 47" 4047 4935 211 80
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_46_211_90_Rev3.bmp "Clock Image 46" 4046 4950 211 90
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_45_213_104_Rev3.bmp "Clock Image 45" 4045 5005 213 104
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_44_214_112_Rev3.bmp "Clock Image 44" 4044 5020 214 112
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_43_215_121_Rev3.bmp "Clock Image 43" 4043 5040 215 121
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_42_212_127_Rev3.bmp "Clock Image 42" 4042 5060 212 127
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_41_209_136_Rev3.bmp "Clock Image 41" 4041 5080 209 136
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_40_207_142_Rev3.bmp "Clock Image 40" 4040 5098 207 142
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_39_203_149_Rev3.bmp "Clock Image 39" 4039 5118 203 149
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_38_200_152_Rev3.bmp "Clock Image 38" 4038 5138 200 152
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_37_197_158_Rev3.bmp "Clock Image 37" 4037 5159 197 158
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_36_192_162_Rev3.bmp "Clock Image 36" 4036 5179 192 162
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_35_188_166_Rev3.bmp "Clock Image 35" 4035 5200 188 166
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_34_181_171_Rev3.bmp "Clock Image 34" 4034 5220 181 171
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_33_175_175_Rev3.bmp "Clock Image 33" 4033 5240 175 175
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_32_167_178_Rev3.bmp "Clock Image 32" 4032 5260 167 178
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_31_162_178_Rev3.bmp "Clock Image 31" 4031 5280 162 178
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_30_154_180_Rev3.bmp "Clock Image 30" 4030 5300 154 180
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_29_145_180_Rev3.bmp "Clock Image 29" 4029 5310 145 180
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_28_133_179_Rev3.bmp "Clock Image 28" 4028 5322 133 179
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_27_120_176_Rev3.bmp "Clock Image 27" 4027 5335 120 176
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_26_109_174_Rev3.bmp "Clock Image 26" 4026 5351 109 174
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_25_100_170_Rev3.bmp "Clock Image 25" 4025 5370 100 170
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_24_90_166_Rev3.bmp "Clock Image 24" 4024 5390 90 166
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_23_82_162_Rev3.bmp "Clock Image 23" 4023 5410 82 162
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_22_74_157_Rev3.bmp "Clock Image 22" 4022 5430 74 157
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_21_66_152_Rev3.bmp "Clock Image 21" 4021 5451 66 152
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_20_60_147_Rev3.bmp "Clock Image 20" 4020 5472 60 147
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_19_55_141_Rev3.bmp "Clock Image 19" 4019 5493 55 141
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_18_51_133_Rev3.bmp "Clock Image 18" 4018 5513 51 133
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_17_48_129_Rev3.bmp "Clock Image 17" 4017 5531 48 129
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_16_46_121_Rev3.bmp "Clock Image 16" 4016 5546 46 121
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_15_45_114_Rev3.bmp "Clock Image 15" 4015 5561 45 114
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_14_45_104_Rev3.bmp "Clock Image 14" 4014 5575 45 104
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_13_46_92_Rev3.bmp "Clock Image 13" 4013 5585 46 92
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_12_47_80_Rev3.bmp "Clock Image 12" 4012 5605 47 80
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_11_50_69_Rev3.bmp "Clock Image 11" 4011 5625 50 69
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_10_54_59_Rev3.bmp "Clock Image 10" 4010 5645 54 59
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_9_59_49_Rev3.bmp "Clock Image 9" 4009 5665 59 49
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_8_65_40_Rev3.bmp "Clock Image 8" 4008 5685 65 40
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_7_72_31_Rev3.bmp "Clock Image 7" 4007 5705 72 31
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_6_80_24_Rev3.bmp "Clock Image 6" 4006 5725 80 24
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_5_89_18_Rev3.bmp "Clock Image 5" 4005 5745 89 18
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_4_99_13_Rev3.bmp "Clock Image 4" 4004 5765 99 13
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_3_109_8_Rev3.bmp "Clock Image 3" 4003 5785 109 8
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_2_119_5_Rev3.bmp "Clock Image 2" 4002 5805 119 5
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_1_131_3_Rev3.bmp "Clock Image 1" 4001 5825 131 3
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Clock_Image_0.bmp "Clock Image 0" 4061 5900 139 2
)

IF /I "%OLD_IMAGES%" EQU "1" (
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/unknown_error.bmp "Unknown error" 7000 3500 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/mca_detached.bmp "MCA detached" 7001 3550 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/temp_too_high.bmp "Temp too high" 7002 3600 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/current_too_high.bmp "Current too high" 7003 3650 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/current_too_low.bmp "Current too low" 7004 3700 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/current_source_error.bmp "Current source error" 7005 3750 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/software_watchdog_timeout.bmp "Software watchdog timeout" 7006 3800 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/hardware_watchdog_timeout.bmp "Hardware watchdog timeout" 7007 3850 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/error_watchdog_enable.bmp "Hardware watchdog enable error" 7008 3900 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/error_therapy_on.bmp "Therapy on error" 7009 3950 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/error_start_wdog.bmp "Start watchdog error" 7010 4000 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/error_24VDC.bmp "24VDC error" 7011 4050 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/error_5VDC.bmp "5VDC error" 7012 4100 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/error_33VDC.bmp "3.3VDC error" 7013 4150 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/alarm_error.bmp "Alarm error" 7014 4200 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/rgb_led_error.bmp "RGB LED error" 7015 4250 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/lcd_error.bmp "LCD error" 7016 4300 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/fan_error.bmp "Fan error" 7017 4350 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/flash_mem_error.bmp "Flash memory error" 7018 4400 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/led_board_eeprom_error.bmp "LED board EEPROM error" 7019 4450 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/pushbutton_error.bmp "Pushbutton error" 7020 4500 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/current_level_error.bmp "Current level error" 7021 4550 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/i2c_error.bmp "I2C error" 7022 4600 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/battery_error.bmp "Battery Error" 7023 4650 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/MCA_reading_error.bmp "MCA Reading Error" 7024 4700 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/mca_expired.bmp "MCA Expired" 7025 4750 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/mca_period_error.bmp "MCA Period Error" 7026 4800 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/Reading_MCA.bmp "Reading MCA" 2500 5000 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/paused_overlay.bmp "Paused" 6000 5050 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/insert_MCA.bmp "Insert MCA Prompt" 2000 5100 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/ready.bmp "Ready Prompt" 3000 5150 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/therapy_complete.bmp "Therapy complete" 5000 5200 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/startup_error.bmp "startup error" 1100 5250 115 84
)

IF /I "%DO_ALL_IMAGES%" EQU "1" (
    REM   --------------------------------------------------------------------------------------------------Medium messages for User Interface (New)
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/White_Text_Box.bmp "White Text Box" 2700 5910 66 46
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/big_paused_overlay.bmp "Big Paused" 2800 6133 66 46
    REM   --------------------------------------------------------------------------------------------------Smaller messages numbers
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_9.bmp "9 min" 4109 7120 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_8.bmp "8 min" 4108 7170 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_7.bmp "7 min" 4107 7220 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_6.bmp "6 min" 4106 7270 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_5.bmp "5 min" 4105 7320 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_4.bmp "4 min" 4104 7370 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_3.bmp "3 min" 4103 7420 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_2.bmp "2 min" 4102 7470 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_1.bmp "1 min" 4101 7520 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_0.bmp "0 min" 4100 7570 115 84
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_9_small.bmp "9 min small" 6109 7620 110 156
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_8_small.bmp "8 min small" 6108 7640 110 156
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_7_small.bmp "7 min small" 6107 7660 110 156
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_6_small.bmp "6 min small" 6106 7680 110 156
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_5_small.bmp "5 min small" 6105 7700 110 156
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_4_small.bmp "4 min small" 6104 7720 110 156
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_3_small.bmp "3 min small" 6103 7740 110 156
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_2_small.bmp "2 min small" 6102 7760 110 156
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_1_small.bmp "1 min small" 6101 7780 110 156
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_0_small.bmp "0 min small" 6100 7800 110 156
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/min_empty_small.bmp "erase small minutes" 6110 7820 110 156
    %PYTHON_PATH% Load_Bitmap.py %PORT% %SPEED% %IMAGE_PATH%/screensaver.bmp "screensaver" 2100 7840 170 156
)

REM    Show the current images information after initialization
%PYTHON_PATH% Table_Of_Images.py %PORT% %SPEED%
