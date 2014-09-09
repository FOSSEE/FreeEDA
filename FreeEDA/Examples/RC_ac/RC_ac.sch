EESchema Schematic File Version 2  date Friday 24 May 2013 01:59:22 PM IST
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
LIBS:RC_ac-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "24 may 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	5900 3300 5900 3550
Wire Wire Line
	5600 2650 5900 2650
Connection ~ 4900 2650
Connection ~ 5750 2650
Connection ~ 5400 3550
Wire Wire Line
	5400 3550 5400 3800
Wire Wire Line
	5900 3550 4650 3550
Wire Wire Line
	4650 2650 5100 2650
Wire Wire Line
	5900 2650 5900 2900
$Comp
L VPLOT8_1 U1
U 2 1 519F22B7
P 5750 2350
F 0 "U1" H 5600 2450 50  0000 C CNN
F 1 "VPLOT8_1" H 5900 2450 50  0000 C CNN
	2    5750 2350
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG01
U 1 1 519F229B
P 5400 3550
F 0 "#FLG01" H 5400 3820 30  0001 C CNN
F 1 "PWR_FLAG" H 5400 3780 30  0000 C CNN
	1    5400 3550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 519F2294
P 5400 3800
F 0 "#PWR02" H 5400 3800 30  0001 C CNN
F 1 "GND" H 5400 3730 30  0001 C CNN
	1    5400 3800
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U1
U 1 1 519F228E
P 4900 2350
F 0 "U1" H 4750 2450 50  0000 C CNN
F 1 "VPLOT8_1" H 5050 2450 50  0000 C CNN
	1    4900 2350
	1    0    0    -1  
$EndComp
$Comp
L AC v1
U 1 1 519F2287
P 4650 3100
F 0 "v1" H 4450 3200 60  0000 C CNN
F 1 "AC" H 4450 3050 60  0000 C CNN
F 2 "R1" H 4350 3100 60  0000 C CNN
	1    4650 3100
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 519F2283
P 5350 2650
F 0 "R1" V 5430 2650 50  0000 C CNN
F 1 "1k" V 5350 2650 50  0000 C CNN
	1    5350 2650
	0    1    1    0   
$EndComp
$Comp
L C C1
U 1 1 519F227E
P 5900 3100
F 0 "C1" H 5950 3200 50  0000 L CNN
F 1 "1u" H 5950 3000 50  0000 L CNN
	1    5900 3100
	-1   0    0    1   
$EndComp
$EndSCHEMATC
