EESchema Schematic File Version 2  date Tuesday 16 April 2013 03:05:48 PM IST
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
LIBS:analogSpice
LIBS:analogXSpice
LIBS:convergenceAidSpice
LIBS:converterSpice
LIBS:digitalSpice
LIBS:digitalXSpice
LIBS:linearSpice
LIBS:measurementSpice
LIBS:portSpice
LIBS:sourcesSpice
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "16 apr 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	7000 3000 7000 3350
Connection ~ 7000 2400
Connection ~ 6450 2500
Connection ~ 6450 2400
Wire Wire Line
	6350 3300 7000 3300
Wire Wire Line
	6450 2900 6450 3000
Connection ~ 7000 3350
Connection ~ 6350 3300
Connection ~ 5350 4100
Wire Wire Line
	4150 3200 4050 3200
Wire Wire Line
	5900 2400 5800 2400
Connection ~ 7000 3300
Wire Wire Line
	5350 3200 5250 3200
Connection ~ 5300 3200
Wire Wire Line
	5350 4200 5350 3400
Wire Wire Line
	4750 3200 4650 3200
Wire Wire Line
	5350 4100 4050 4100
Wire Wire Line
	6400 2400 6500 2400
Wire Wire Line
	5300 2400 5300 3200
Wire Wire Line
	7000 2400 7000 2500
$Comp
L IPLOT U5
U 1 1 516D1AB3
P 7000 2750
F 0 "U5" H 6850 2850 50  0000 C CNN
F 1 "IPLOT" H 7150 2850 50  0000 C CNN
	1    7000 2750
	0    1    1    0   
$EndComp
$Comp
L VPLOT8_1 U4
U 1 1 516D1A8F
P 6450 2100
F 0 "U4" H 6300 2200 50  0000 C CNN
F 1 "VPLOT8_1" H 6600 2200 50  0000 C CNN
	1    6450 2100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 516D1A5C
P 6450 3000
F 0 "#PWR01" H 6450 3000 30  0001 C CNN
F 1 "GND" H 6450 2930 30  0001 C CNN
	1    6450 3000
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 516D1A47
P 6450 2650
F 0 "R3" V 6530 2650 50  0000 C CNN
F 1 "100000" V 6450 2650 50  0000 C CNN
	1    6450 2650
	-1   0    0    1   
$EndComp
$Comp
L R R4
U 1 1 516D1A3E
P 6750 2400
F 0 "R4" V 6830 2400 50  0000 C CNN
F 1 "100000" V 6750 2400 50  0000 C CNN
	1    6750 2400
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG02
U 1 1 516D11A2
P 5350 4100
F 0 "#FLG02" H 5350 4370 30  0001 C CNN
F 1 "PWR_FLAG" H 5350 4330 30  0000 C CNN
	1    5350 4100
	0    -1   -1   0   
$EndComp
$Comp
L VPLOT8_1 U3
U 1 1 516D117B
P 7300 3350
F 0 "U3" H 7150 3450 50  0000 C CNN
F 1 "VPLOT8_1" H 7450 3450 50  0000 C CNN
	1    7300 3350
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG03
U 1 1 516D1102
P 5300 3200
F 0 "#FLG03" H 5300 3470 30  0001 C CNN
F 1 "PWR_FLAG" H 5300 3430 30  0000 C CNN
	1    5300 3200
	-1   0    0    1   
$EndComp
$Comp
L IPLOT U1
U 1 1 516D1019
P 5000 3200
F 0 "U1" H 4850 3300 50  0000 C CNN
F 1 "IPLOT" H 5150 3300 50  0000 C CNN
	1    5000 3200
	1    0    0    -1  
$EndComp
$Comp
L IPLOT U2
U 1 1 516D0FEC
P 5550 2400
F 0 "U2" H 5400 2500 50  0000 C CNN
F 1 "IPLOT" H 5700 2500 50  0000 C CNN
	1    5550 2400
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 516D0FE2
P 6150 2400
F 0 "R2" V 6230 2400 50  0000 C CNN
F 1 "100000" V 6150 2400 50  0000 C CNN
	1    6150 2400
	0    1    1    0   
$EndComp
$Comp
L DC v1
U 1 1 516D0FD3
P 4050 3650
F 0 "v1" H 3850 3750 60  0000 C CNN
F 1 "100m" H 3850 3600 60  0000 C CNN
F 2 "R1" H 3750 3650 60  0000 C CNN
	1    4050 3650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 516D0F6B
P 5350 4200
F 0 "#PWR04" H 5350 4200 30  0001 C CNN
F 1 "GND" H 5350 4130 30  0001 C CNN
	1    5350 4200
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 516D0F10
P 4400 3200
F 0 "R1" V 4480 3200 50  0000 C CNN
F 1 "1000" V 4400 3200 50  0000 C CNN
	1    4400 3200
	0    1    1    0   
$EndComp
$Comp
L UA741 X1
U 1 1 516D0E60
P 5850 3300
F 0 "X1" H 6000 3450 60  0000 C CNN
F 1 "UA741" H 6000 3550 60  0000 C CNN
	1    5850 3300
	1    0    0    1   
$EndComp
$EndSCHEMATC
