EESchema Schematic File Version 2  date Monday 15 April 2013 03:25:17 PM IST
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:example_2.8-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "15 apr 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 7200 2400
Connection ~ 7200 1800
Wire Wire Line
	6450 2400 7550 2400
Wire Wire Line
	6450 2400 6450 2250
Connection ~ 6850 2400
Wire Wire Line
	7550 2400 7550 2300
Wire Wire Line
	6850 2000 6850 1700
Wire Wire Line
	6850 1200 6450 1200
Wire Wire Line
	7550 1800 6850 1800
Connection ~ 6850 1800
Wire Wire Line
	6450 1200 6450 1350
Wire Wire Line
	7100 2400 7100 2600
Connection ~ 7100 2400
$Comp
L GND #PWR01
U 1 1 516BCDAC
P 7100 2600
F 0 "#PWR01" H 7100 2600 30  0001 C CNN
F 1 "GND" H 7100 2530 30  0001 C CNN
	1    7100 2600
	1    0    0    -1  
$EndComp
$Comp
L DC v1
U 1 1 516BCD76
P 6450 1800
F 0 "v1" H 6250 1900 60  0000 C CNN
F 1 "DC" H 6250 1750 60  0000 C CNN
F 2 "R1" H 6150 1800 60  0000 C CNN
	1    6450 1800
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8 U1
U 1 1 516BCD56
P 7200 2100
F 0 "U1" H 7050 2200 50  0000 C CNN
F 1 "VPLOT8" H 7350 2200 50  0000 C CNN
	1    7200 2100
	0    -1   -1   0   
$EndComp
$Comp
L R R2
U 1 1 516BCD26
P 7550 2050
F 0 "R2" V 7630 2050 50  0000 C CNN
F 1 "2000" V 7550 2050 50  0000 C CNN
	1    7550 2050
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 516BCCFA
P 6850 1450
F 0 "R1" V 6930 1450 50  0000 C CNN
F 1 "500" V 6850 1450 50  0000 C CNN
	1    6850 1450
	1    0    0    -1  
$EndComp
$Comp
L ZENER D1
U 1 1 516BCCC7
P 6850 2200
F 0 "D1" H 6850 2300 50  0000 C CNN
F 1 "ZENER" H 6850 2100 40  0000 C CNN
	1    6850 2200
	0    -1   -1   0   
$EndComp
$EndSCHEMATC
