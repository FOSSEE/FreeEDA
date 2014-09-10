EESchema Schematic File Version 2  date Wednesday 15 May 2013 10:41:23 PM IST
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
LIBS:example_5.7-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "15 may 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L AC v1
U 1 1 5193C186
P 4050 3650
F 0 "v1" H 3850 3750 60  0000 C CNN
F 1 "AC" H 3850 3600 60  0000 C CNN
F 2 "R1" H 3750 3650 60  0000 C CNN
	1    4050 3650
	1    0    0    -1  
$EndComp
Wire Wire Line
	7050 3500 7050 2950
Connection ~ 6500 2950
Wire Wire Line
	6500 2950 6500 2550
Wire Wire Line
	6500 2550 6300 2550
Connection ~ 5300 2950
Wire Wire Line
	5300 2550 5300 3200
Wire Wire Line
	4750 3200 4650 3200
Wire Wire Line
	5350 4200 5350 3400
Connection ~ 5300 3200
Wire Wire Line
	5350 3200 5250 3200
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
	6350 3300 7050 3300
Wire Wire Line
	5800 2550 5900 2550
Wire Wire Line
	4050 4100 7050 4100
Wire Wire Line
	7050 4100 7050 4000
Connection ~ 7050 3400
$Comp
L R R3
U 1 1 516E71B7
P 7050 3750
F 0 "R3" V 7130 3750 50  0000 C CNN
F 1 "R" V 7050 3750 50  0000 C CNN
	1    7050 3750
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG01
U 1 1 516E6E61
P 5350 4100
F 0 "#FLG01" H 5350 4370 30  0001 C CNN
F 1 "PWR_FLAG" H 5350 4330 30  0000 C CNN
	1    5350 4100
	-1   0    0    1   
$EndComp
$Comp
L VPLOT8_1 U3
U 1 1 516E6E43
P 7350 3400
F 0 "U3" H 7200 3500 50  0000 C CNN
F 1 "VPLOT8_1" H 7500 3500 50  0000 C CNN
	1    7350 3400
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG02
U 1 1 516D1102
P 5300 3200
F 0 "#FLG02" H 5300 3470 30  0001 C CNN
F 1 "PWR_FLAG" H 5300 3430 30  0000 C CNN
	1    5300 3200
	-1   0    0    1   
$EndComp
$Comp
L C C1
U 1 1 516E6B62
P 6100 2550
F 0 "C1" H 6150 2650 50  0000 L CNN
F 1 "1.59n" H 6150 2450 50  0000 L CNN
	1    6100 2550
	0    1    1    0   
$EndComp
$Comp
L IPLOT U4
U 1 1 516E6B56
P 5550 2550
F 0 "U4" H 5400 2650 50  0000 C CNN
F 1 "IPLOT" H 5700 2650 50  0000 C CNN
	1    5550 2550
	1    0    0    -1  
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
F 1 "10000" V 6150 2950 50  0000 C CNN
	1    6150 2950
	0    1    1    0   
$EndComp
$Comp
L GND #PWR03
U 1 1 516D0F6B
P 5350 4200
F 0 "#PWR03" H 5350 4200 30  0001 C CNN
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
