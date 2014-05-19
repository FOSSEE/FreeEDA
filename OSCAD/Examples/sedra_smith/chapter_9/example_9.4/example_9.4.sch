EESchema Schematic File Version 2  date Thursday 16 May 2013 11:24:57 AM IST
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
LIBS:example_9.4-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "16 may 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 5750 3600
Wire Wire Line
	6050 3450 6400 3450
Connection ~ 6050 4300
Wire Wire Line
	6050 4050 6050 4350
Wire Wire Line
	6050 4350 5100 4350
Wire Wire Line
	6650 3900 6650 4300
Wire Wire Line
	6050 2850 6050 2700
Wire Wire Line
	6050 3250 6050 3650
Wire Wire Line
	5750 3050 5750 3850
Connection ~ 6050 3450
Wire Wire Line
	6400 3450 6400 3750
Connection ~ 6400 4300
Wire Wire Line
	6050 2700 6650 2700
Wire Wire Line
	6650 2700 6650 3000
Wire Wire Line
	5750 3450 5100 3450
Connection ~ 5750 3450
Wire Wire Line
	5100 3450 5100 3550
Wire Wire Line
	6400 4400 6400 4150
Connection ~ 5500 3450
Wire Wire Line
	6650 4300 6050 4300
Connection ~ 6200 3450
$Comp
L MOS_P M1
U 1 1 5188E486
P 5950 3050
F 0 "M1" H 5950 3240 60  0000 R CNN
F 1 "MOS_P" H 5950 2870 60  0000 R CNN
	1    5950 3050
	1    0    0    1   
$EndComp
$Comp
L MOS_N M2
U 1 1 5188E477
P 5950 3850
F 0 "M2" H 5960 4020 60  0000 R CNN
F 1 "MOS_N" H 5960 3700 60  0000 R CNN
	1    5950 3850
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U2
U 2 1 5188E0A2
P 6200 3150
F 0 "U2" H 6050 3250 50  0000 C CNN
F 1 "VPLOT8_1" H 6350 3250 50  0000 C CNN
	2    6200 3150
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG01
U 1 1 5188E094
P 6400 4300
F 0 "#FLG01" H 6400 4570 30  0001 C CNN
F 1 "PWR_FLAG" H 6400 4530 30  0000 C CNN
	1    6400 4300
	1    0    0    -1  
$EndComp
$Comp
L DC v2
U 1 1 517F5425
P 6650 3450
F 0 "v2" H 6450 3550 60  0000 C CNN
F 1 "10" H 6450 3400 60  0000 C CNN
F 2 "R1" H 6350 3450 60  0000 C CNN
	1    6650 3450
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U2
U 1 1 517F5879
P 5500 3150
F 0 "U2" H 5350 3250 50  0000 C CNN
F 1 "VPLOT8_1" H 5650 3250 50  0000 C CNN
	1    5500 3150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 517F5470
P 6400 4400
F 0 "#PWR02" H 6400 4400 30  0001 C CNN
F 1 "GND" H 6400 4330 30  0001 C CNN
	1    6400 4400
	1    0    0    -1  
$EndComp
$Comp
L DC v1
U 1 1 517F544C
P 5100 3900
F 0 "v1" H 4900 4000 60  0000 C CNN
F 1 "DC" H 4900 3850 60  0000 C CNN
F 2 "R1" H 4800 3900 60  0000 C CNN
	1    5100 3900
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 517F53E7
P 6400 3950
F 0 "C1" H 6450 4050 50  0000 L CNN
F 1 ".5p" H 6450 3850 50  0000 L CNN
	1    6400 3950
	1    0    0    -1  
$EndComp
$EndSCHEMATC
