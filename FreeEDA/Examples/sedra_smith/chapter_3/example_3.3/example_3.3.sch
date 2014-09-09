EESchema Schematic File Version 2  date Thursday 25 April 2013 02:05:06 PM IST
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
LIBS:example_3.3-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "25 apr 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 4000 3300
Wire Wire Line
	5450 4200 5450 5350
Wire Wire Line
	6650 5050 3500 5050
Connection ~ 5450 5050
Wire Wire Line
	6650 5050 6650 4450
Wire Wire Line
	3500 5050 3500 4450
Wire Wire Line
	4300 3300 3500 3300
Wire Wire Line
	5450 3700 5450 3500
Wire Wire Line
	5450 2950 5450 3100
Wire Wire Line
	5450 2300 5450 2450
Connection ~ 5450 3050
Connection ~ 5450 3600
Wire Wire Line
	3500 3300 3500 3550
Wire Wire Line
	5450 1800 6650 1800
Wire Wire Line
	6650 1800 6650 3550
Wire Wire Line
	4800 3300 5150 3300
Connection ~ 5100 3300
Connection ~ 6650 5050
Connection ~ 4950 3300
Connection ~ 5450 5200
Connection ~ 5450 4400
$Comp
L PWR_FLAG #FLG01
U 1 1 516CE235
P 4950 3300
F 0 "#FLG01" H 4950 3570 30  0001 C CNN
F 1 "PWR_FLAG" H 4950 3530 30  0000 C CNN
	1    4950 3300
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG02
U 1 1 516CE22C
P 5450 5200
F 0 "#FLG02" H 5450 5470 30  0001 C CNN
F 1 "PWR_FLAG" H 5450 5430 30  0000 C CNN
	1    5450 5200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 516CE20C
P 5450 5350
F 0 "#PWR03" H 5450 5350 30  0001 C CNN
F 1 "GND" H 5450 5280 30  0001 C CNN
	1    5450 5350
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U2
U 1 1 516CE1D8
P 5100 3000
F 0 "U2" H 4950 3100 50  0000 C CNN
F 1 "VPLOT8_1" H 5250 3100 50  0000 C CNN
	1    5100 3000
	1    0    0    -1  
$EndComp
$Comp
L IPLOT U1
U 1 1 516CE177
P 4550 3300
F 0 "U1" H 4400 3400 50  0000 C CNN
F 1 "IPLOT" H 4700 3400 50  0000 C CNN
	1    4550 3300
	-1   0    0    1   
$EndComp
$Comp
L DC v1
U 1 1 516CE159
P 3500 4000
F 0 "v1" H 3300 4100 60  0000 C CNN
F 1 "5V" H 3300 3950 60  0000 C CNN
F 2 "R1" H 3200 4000 60  0000 C CNN
	1    3500 4000
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 516CE13E
P 3750 3300
F 0 "R1" V 3830 3300 50  0000 C CNN
F 1 "2200" V 3750 3300 50  0000 C CNN
	1    3750 3300
	0    1    1    0   
$EndComp
$Comp
L VPLOT8_1 U2
U 2 1 516CE102
P 5750 3050
F 0 "U2" H 5600 3150 50  0000 C CNN
F 1 "VPLOT8_1" H 5900 3150 50  0000 C CNN
	2    5750 3050
	0    1    1    0   
$EndComp
$Comp
L R R2
U 1 1 516CE0C0
P 5450 2050
F 0 "R2" V 5530 2050 50  0000 C CNN
F 1 "1k" V 5450 2050 50  0000 C CNN
	1    5450 2050
	1    0    0    -1  
$EndComp
$Comp
L IPLOT U3
U 1 1 516CE0B6
P 5450 2700
F 0 "U3" H 5300 2800 50  0000 C CNN
F 1 "IPLOT" H 5600 2800 50  0000 C CNN
	1    5450 2700
	0    1    1    0   
$EndComp
$Comp
L DC v2
U 1 1 516CE08D
P 6650 4000
F 0 "v2" H 6450 4100 60  0000 C CNN
F 1 "10V" H 6450 3950 60  0000 C CNN
F 2 "R1" H 6350 4000 60  0000 C CNN
	1    6650 4000
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U2
U 3 1 516CE083
P 5750 3600
F 0 "U2" H 5600 3700 50  0000 C CNN
F 1 "VPLOT8_1" H 5900 3700 50  0000 C CNN
	3    5750 3600
	0    1    1    0   
$EndComp
$Comp
L IPLOT U4
U 1 1 516CE07C
P 5450 3950
F 0 "U4" H 5300 4050 50  0000 C CNN
F 1 "IPLOT" H 5600 4050 50  0000 C CNN
	1    5450 3950
	0    1    1    0   
$EndComp
$Comp
L NPN Q1
U 1 1 516CE055
P 5350 3300
F 0 "Q1" H 5350 3150 50  0000 R CNN
F 1 "NPN" H 5350 3450 50  0000 R CNN
	1    5350 3300
	1    0    0    -1  
$EndComp
$EndSCHEMATC
