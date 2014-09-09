EESchema Schematic File Version 2  date Tuesday 16 April 2013 11:31:21 AM IST
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
$Comp
L R R1
U 1 1 516CE8DE
P 4200 2450
F 0 "R1" V 4280 2450 50  0000 C CNN
F 1 "80000" V 4200 2450 50  0000 C CNN
	1    4200 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 3350 4200 3350
Wire Wire Line
	6850 2850 6850 1300
Wire Wire Line
	6850 1300 4200 1300
Wire Wire Line
	4200 1300 4200 2200
Connection ~ 4200 3350
Wire Wire Line
	4200 2700 4200 3800
Wire Wire Line
	6850 3750 6850 5150
Wire Wire Line
	5350 3550 5350 3750
Wire Wire Line
	5350 2050 5350 2250
Wire Wire Line
	5350 1550 5350 1300
Wire Wire Line
	5350 2750 5350 3150
Wire Wire Line
	5350 4250 5350 4400
Wire Wire Line
	4200 4300 4200 5150
Wire Wire Line
	4200 5150 6850 5150
Connection ~ 5350 5150
Connection ~ 5350 1300
Wire Wire Line
	5350 5650 5350 4900
Connection ~ 5350 5500
Connection ~ 5350 3650
Connection ~ 5350 2900
Connection ~ 5000 3350
$Comp
L VPLOT8_1 U2
U 3 1 516C2B0C
P 5650 3650
F 0 "U2" H 5500 3750 50  0000 C CNN
F 1 "VPLOT8_1" H 5800 3750 50  0000 C CNN
	3    5650 3650
	0    1    1    0   
$EndComp
$Comp
L VPLOT8_1 U2
U 2 1 516C2B05
P 5650 2900
F 0 "U2" H 5500 3000 50  0000 C CNN
F 1 "VPLOT8_1" H 5800 3000 50  0000 C CNN
	2    5650 2900
	0    1    1    0   
$EndComp
$Comp
L VPLOT8_1 U2
U 1 1 516C2AFE
P 5000 3050
F 0 "U2" H 4850 3150 50  0000 C CNN
F 1 "VPLOT8_1" H 5150 3150 50  0000 C CNN
	1    5000 3050
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG01
U 1 1 516C2AB7
P 5350 5500
F 0 "#FLG01" H 5350 5770 30  0001 C CNN
F 1 "PWR_FLAG" H 5350 5730 30  0000 C CNN
	1    5350 5500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 516C2AAB
P 5350 5650
F 0 "#PWR02" H 5350 5650 30  0001 C CNN
F 1 "GND" H 5350 5580 30  0001 C CNN
	1    5350 5650
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 516C2A3E
P 4200 4050
F 0 "R2" V 4280 4050 50  0000 C CNN
F 1 "40000" V 4200 4050 50  0000 C CNN
	1    4200 4050
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 516C29D9
P 5350 4650
F 0 "R4" V 5430 4650 50  0000 C CNN
F 1 "3300" V 5350 4650 50  0000 C CNN
	1    5350 4650
	1    0    0    -1  
$EndComp
$Comp
L IPLOT U4
U 1 1 516C29CD
P 5350 4000
F 0 "U4" H 5200 4100 50  0000 C CNN
F 1 "IPLOT" H 5500 4100 50  0000 C CNN
	1    5350 4000
	0    1    1    0   
$EndComp
$Comp
L DC v1
U 1 1 516C296E
P 6850 3300
F 0 "v1" H 6650 3400 60  0000 C CNN
F 1 "12V" H 6650 3250 60  0000 C CNN
F 2 "R1" H 6550 3300 60  0000 C CNN
	1    6850 3300
	1    0    0    -1  
$EndComp
$Comp
L IPLOT U3
U 1 1 516C2958
P 5350 2500
F 0 "U3" H 5200 2600 50  0000 C CNN
F 1 "IPLOT" H 5500 2600 50  0000 C CNN
	1    5350 2500
	0    1    1    0   
$EndComp
$Comp
L R R3
U 1 1 516C293A
P 5350 1800
F 0 "R3" V 5430 1800 50  0000 C CNN
F 1 "4000" V 5350 1800 50  0000 C CNN
	1    5350 1800
	1    0    0    -1  
$EndComp
$Comp
L NPN Q1
U 1 1 516C2934
P 5250 3350
F 0 "Q1" H 5250 3200 50  0000 R CNN
F 1 "NPN" H 5250 3500 50  0000 R CNN
	1    5250 3350
	1    0    0    -1  
$EndComp
$EndSCHEMATC
