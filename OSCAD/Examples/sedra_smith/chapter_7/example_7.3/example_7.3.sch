EESchema Schematic File Version 2  date Monday 22 April 2013 02:21:52 PM IST
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
Date "22 apr 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L VPLOT8_1 U1
U 1 1 5174FA0E
P 3850 3350
F 0 "U1" H 3700 3450 50  0000 C CNN
F 1 "VPLOT8_1" H 4000 3450 50  0000 C CNN
	1    3850 3350
	1    0    0    -1  
$EndComp
Connection ~ 3850 3650
Wire Wire Line
	3850 3650 3800 3650
Connection ~ 4350 3650
Connection ~ 5300 3350
Wire Wire Line
	4950 4650 4950 3850
Wire Wire Line
	5800 3200 5800 2800
Wire Wire Line
	5800 2800 4950 2800
Wire Wire Line
	4350 3350 4350 3650
Wire Wire Line
	4350 3350 4450 3350
Wire Wire Line
	4950 3450 4950 3300
Wire Wire Line
	4350 3650 4650 3650
Wire Wire Line
	4950 3350 5300 3350
Connection ~ 4950 3350
Wire Wire Line
	5800 4100 5800 4550
Wire Wire Line
	5800 4550 3800 4550
Connection ~ 4950 4550
$Comp
L VPLOT8_1 U1
U 2 1 5174F9F2
P 5300 3050
F 0 "U1" H 5150 3150 50  0000 C CNN
F 1 "VPLOT8_1" H 5450 3150 50  0000 C CNN
	2    5300 3050
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG01
U 1 1 5174F9DF
P 4950 4550
F 0 "#FLG01" H 4950 4820 30  0001 C CNN
F 1 "PWR_FLAG" H 4950 4780 30  0000 C CNN
	1    4950 4550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 5174F9D4
P 4950 4650
F 0 "#PWR02" H 4950 4650 30  0001 C CNN
F 1 "GND" H 4950 4580 30  0001 C CNN
	1    4950 4650
	1    0    0    -1  
$EndComp
$Comp
L DC v2
U 1 1 5174F994
P 5800 3650
F 0 "v2" H 5600 3750 60  0000 C CNN
F 1 "12" H 5600 3600 60  0000 C CNN
F 2 "R1" H 5500 3650 60  0000 C CNN
	1    5800 3650
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 5174F959
P 4700 3350
F 0 "R2" V 4780 3350 50  0000 C CNN
F 1 "47000" V 4700 3350 50  0000 C CNN
	1    4700 3350
	0    1    1    0   
$EndComp
$Comp
L R R1
U 1 1 5174F943
P 4100 3650
F 0 "R1" V 4180 3650 50  0000 C CNN
F 1 "10000" V 4100 3650 50  0000 C CNN
	1    4100 3650
	0    1    1    0   
$EndComp
$Comp
L SINE v1
U 1 1 5174F939
P 3800 4100
F 0 "v1" H 3600 4200 60  0000 C CNN
F 1 "SINE" H 3600 4050 60  0000 C CNN
F 2 "R1" H 3500 4100 60  0000 C CNN
	1    3800 4100
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 5174F90B
P 4950 3050
F 0 "R3" V 5030 3050 50  0000 C CNN
F 1 "4700" V 4950 3050 50  0000 C CNN
	1    4950 3050
	1    0    0    -1  
$EndComp
$Comp
L NPN Q1
U 1 1 5174F8FA
P 4850 3650
F 0 "Q1" H 4850 3500 50  0000 R CNN
F 1 "NPN" H 4850 3800 50  0000 R CNN
	1    4850 3650
	1    0    0    -1  
$EndComp
$EndSCHEMATC
