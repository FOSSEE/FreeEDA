EESchema Schematic File Version 2  date Friday 24 May 2013 02:15:51 PM IST
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
Date "24 may 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L VPLOT8_1 U1
U 1 1 519F28A8
P 6100 2550
F 0 "U1" H 5950 2650 50  0000 C CNN
F 1 "VPLOT8_1" H 6250 2650 50  0000 C CNN
	1    6100 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 2850 6100 3250
Connection ~ 5600 4000
Wire Wire Line
	5600 3900 5600 4000
Connection ~ 6100 4000
Wire Wire Line
	6100 3750 6100 4000
Wire Wire Line
	7850 3900 7850 4000
Wire Wire Line
	7850 4000 4700 4000
Wire Wire Line
	4700 4000 4700 3950
Connection ~ 5250 3000
Wire Wire Line
	5250 3300 5250 3000
Wire Wire Line
	5850 3000 6350 3000
Wire Wire Line
	4700 3050 4700 3000
Wire Wire Line
	4700 3000 5350 3000
Wire Wire Line
	6850 3000 7850 3000
Wire Wire Line
	7100 3200 7100 3000
Connection ~ 7100 3000
Connection ~ 6100 3000
Wire Wire Line
	7100 3700 7100 4000
Connection ~ 7100 4000
Wire Wire Line
	5250 3800 5250 4000
Connection ~ 5250 4000
Wire Wire Line
	5450 4100 5450 4000
Connection ~ 5450 4000
$Comp
L GND #PWR1
U 1 1 50641423
P 5450 4100
F 0 "#PWR1" H 5450 4100 30  0001 C CNN
F 1 "GND" H 5450 4030 30  0001 C CNN
	1    5450 4100
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG1
U 1 1 506413F9
P 5600 3900
F 0 "#FLG1" H 5600 4170 30  0001 C CNN
F 1 "PWR_FLAG" H 5600 4130 30  0000 C CNN
	1    5600 3900
	1    0    0    -1  
$EndComp
$Comp
L DC i2
U 1 1 50641279
P 7850 3450
F 0 "i2" H 7650 3550 60  0000 C CNN
F 1 "1" H 7650 3400 60  0000 C CNN
F 2 "R3" H 7550 3450 60  0000 C CNN
	1    7850 3450
	1    0    0    -1  
$EndComp
$Comp
L R R5
U 1 1 50641261
P 7100 3450
F 0 "R5" V 7180 3450 50  0000 C CNN
F 1 "1" V 7100 3450 50  0000 C CNN
	1    7100 3450
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 50640DC3
P 5600 3000
F 0 "R2" V 5680 3000 50  0000 C CNN
F 1 "1" V 5600 3000 50  0000 C CNN
	1    5600 3000
	0    1    1    0   
$EndComp
$Comp
L R R4
U 1 1 50640DAA
P 6600 3000
F 0 "R4" V 6680 3000 50  0000 C CNN
F 1 "2" V 6600 3000 50  0000 C CNN
	1    6600 3000
	0    1    1    0   
$EndComp
$Comp
L R R3
U 1 1 50640DA8
P 6100 3500
F 0 "R3" V 6180 3500 50  0000 C CNN
F 1 "1" V 6100 3500 50  0000 C CNN
	1    6100 3500
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 50640DA0
P 5250 3550
F 0 "R1" V 5330 3550 50  0000 C CNN
F 1 "1" V 5250 3550 50  0000 C CNN
	1    5250 3550
	1    0    0    -1  
$EndComp
$Comp
L DC i1
U 1 1 5063F506
P 4700 3500
F 0 "i1" H 4500 3600 60  0000 C CNN
F 1 "1" H 4500 3450 60  0000 C CNN
F 2 "R3" H 4400 3500 60  0000 C CNN
	1    4700 3500
	1    0    0    -1  
$EndComp
$EndSCHEMATC
