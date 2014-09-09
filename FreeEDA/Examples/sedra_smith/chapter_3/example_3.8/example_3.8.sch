EESchema Schematic File Version 2  date Monday 15 April 2013 08:58:27 PM IST
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
EELAYER 43  0
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
Connection ~ 5500 4450
$Comp
L PWR_FLAG #FLG01
U 1 1 516C1C70
P 5500 4450
F 0 "#FLG01" H 5500 4720 30  0001 C CNN
F 1 "PWR_FLAG" H 5500 4680 30  0000 C CNN
	1    5500 4450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 516C1C57
P 5500 4500
F 0 "#PWR02" H 5500 4500 30  0001 C CNN
F 1 "GND" H 5500 4430 30  0001 C CNN
	1    5500 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 4500 5500 4000
Connection ~ 5500 4350
Wire Wire Line
	4600 4350 6400 4350
Wire Wire Line
	6400 2150 6400 1800
Wire Wire Line
	6400 1800 5500 1800
Connection ~ 5500 3450
Connection ~ 5500 2950
Wire Wire Line
	5500 2300 5500 2400
Wire Wire Line
	5500 3000 5500 2900
Wire Wire Line
	5500 3400 5500 3500
Wire Wire Line
	5200 3200 5100 3200
Wire Wire Line
	4600 4350 4600 4100
Wire Wire Line
	6400 4350 6400 3050
$Comp
L DC v1
U 1 1 516C1BAA
P 4600 3650
F 0 "v1" H 4400 3750 60  0000 C CNN
F 1 "5V" H 4400 3600 60  0000 C CNN
F 2 "R1" H 4300 3650 60  0000 C CNN
	1    4600 3650
	1    0    0    -1  
$EndComp
$Comp
L DC v2
U 1 1 516C1B93
P 6400 2600
F 0 "v2" H 6200 2700 60  0000 C CNN
F 1 "10V" H 6200 2550 60  0000 C CNN
F 2 "R1" H 6100 2600 60  0000 C CNN
	1    6400 2600
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 516C130D
P 4850 3200
F 0 "R1" V 4930 3200 50  0000 C CNN
F 1 "100" V 4850 3200 50  0000 C CNN
	1    4850 3200
	0    1    1    0   
$EndComp
$Comp
L VPLOT8_1 U3
U 2 1 516C12F0
P 5800 3450
F 0 "U3" H 5650 3550 50  0000 C CNN
F 1 "VPLOT8_1" H 5950 3550 50  0000 C CNN
	2    5800 3450
	0    1    1    0   
$EndComp
$Comp
L IPLOT U2
U 1 1 516C12D2
P 5500 3750
F 0 "U2" H 5350 3850 50  0000 C CNN
F 1 "IPLOT" H 5650 3850 50  0000 C CNN
	1    5500 3750
	0    -1   -1   0   
$EndComp
$Comp
L VPLOT8_1 U3
U 1 1 516C128C
P 5800 2950
F 0 "U3" H 5650 3050 50  0000 C CNN
F 1 "VPLOT8_1" H 5950 3050 50  0000 C CNN
	1    5800 2950
	0    1    1    0   
$EndComp
$Comp
L IPLOT U1
U 1 1 516C1282
P 5500 2650
F 0 "U1" H 5350 2750 50  0000 C CNN
F 1 "IPLOT" H 5650 2750 50  0000 C CNN
	1    5500 2650
	0    -1   -1   0   
$EndComp
$Comp
L R R2
U 1 1 516C125F
P 5500 2050
F 0 "R2" V 5580 2050 50  0000 C CNN
F 1 "2000" V 5500 2050 50  0000 C CNN
	1    5500 2050
	1    0    0    -1  
$EndComp
$Comp
L NPN Q1
U 1 1 516C1252
P 5400 3200
F 0 "Q1" H 5400 3050 50  0000 R CNN
F 1 "NPN" H 5400 3350 50  0000 R CNN
	1    5400 3200
	1    0    0    -1  
$EndComp
$EndSCHEMATC
