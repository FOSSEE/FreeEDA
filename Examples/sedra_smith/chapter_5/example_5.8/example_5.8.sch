EESchema Schematic File Version 2  date Thursday 18 April 2013 10:25:50 AM IST
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
LIBS:example_5.8-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "18 apr 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	4100 3200 4100 2950
Wire Wire Line
	4100 2950 4200 2950
Wire Wire Line
	4200 2950 4200 2850
Wire Wire Line
	4250 4300 3300 4300
Connection ~ 4250 4100
Wire Wire Line
	4250 4300 4250 4100
Connection ~ 4100 3200
Connection ~ 7050 2950
Wire Wire Line
	7050 2600 7050 3300
Wire Wire Line
	7050 2600 6300 2600
Connection ~ 5300 2950
Wire Wire Line
	5300 3200 5300 2600
Wire Wire Line
	4750 3200 4650 3200
Wire Wire Line
	5350 3400 5350 4200
Connection ~ 5300 3200
Wire Wire Line
	5250 3200 5350 3200
Wire Wire Line
	5900 2950 5800 2950
Wire Wire Line
	4150 3200 4050 3200
Connection ~ 5350 4100
Connection ~ 6350 3300
Connection ~ 7050 3300
Wire Wire Line
	7050 2950 6400 2950
Wire Wire Line
	7050 3300 6350 3300
Wire Wire Line
	4050 4100 5350 4100
Wire Wire Line
	5800 2600 5900 2600
Wire Wire Line
	3300 4300 3300 3700
Wire Wire Line
	3300 3100 3300 2850
Wire Wire Line
	3300 2850 4200 2850
$Comp
L VPLOT8 U5
U 1 1 516F6D28
P 3300 3400
F 0 "U5" H 3150 3500 50  0000 C CNN
F 1 "VPLOT8" H 3450 3500 50  0000 C CNN
	1    3300 3400
	0    1    1    0   
$EndComp
$Comp
L PULSE v1
U 1 1 516E8CD4
P 4050 3650
F 0 "v1" H 3850 3750 60  0000 C CNN
F 1 "PULSE" H 3850 3600 60  0000 C CNN
F 2 "R1" H 3750 3650 60  0000 C CNN
	1    4050 3650
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 516E8BE7
P 6100 2600
F 0 "C1" H 6150 2700 50  0000 L CNN
F 1 "10n" H 6150 2500 50  0000 L CNN
	1    6100 2600
	0    1    1    0   
$EndComp
$Comp
L IPLOT U4
U 1 1 516E8BCF
P 5550 2600
F 0 "U4" H 5400 2700 50  0000 C CNN
F 1 "IPLOT" H 5700 2700 50  0000 C CNN
	1    5550 2600
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U3
U 1 1 516D117B
P 7350 3300
F 0 "U3" H 7200 3400 50  0000 C CNN
F 1 "VPLOT8_1" H 7500 3400 50  0000 C CNN
	1    7350 3300
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG01
U 1 1 516D1102
P 5300 3200
F 0 "#FLG01" H 5300 3470 30  0001 C CNN
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
P 5550 2950
F 0 "U2" H 5400 3050 50  0000 C CNN
F 1 "IPLOT" H 5700 3050 50  0000 C CNN
	1    5550 2950
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 516D0FE2
P 6150 2950
F 0 "R2" V 6230 2950 50  0000 C CNN
F 1 "1000000" V 6150 2950 50  0000 C CNN
	1    6150 2950
	0    1    1    0   
$EndComp
$Comp
L GND #PWR02
U 1 1 516D0F6B
P 5350 4200
F 0 "#PWR02" H 5350 4200 30  0001 C CNN
F 1 "GND" H 5350 4130 30  0001 C CNN
	1    5350 4200
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 516D0F10
P 4400 3200
F 0 "R1" V 4480 3200 50  0000 C CNN
F 1 "10000" V 4400 3200 50  0000 C CNN
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
