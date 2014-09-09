EESchema Schematic File Version 2  date Monday 13 May 2013 02:05:36 PM IST
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
LIBS:example_12.8-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "13 may 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L GND #PWR01
U 1 1 5190A5AD
P 9250 2600
F 0 "#PWR01" H 9250 2600 30  0001 C CNN
F 1 "GND" H 9250 2530 30  0001 C CNN
	1    9250 2600
	1    0    0    -1  
$EndComp
Connection ~ 8950 2600
Wire Wire Line
	8950 2600 9250 2600
Wire Wire Line
	8950 3600 8600 3600
Wire Wire Line
	8600 3600 8600 3450
Wire Wire Line
	8250 2800 8400 2800
Connection ~ 7000 2750
Wire Wire Line
	7500 2000 8600 2000
Wire Wire Line
	6900 3650 7900 3650
Wire Wire Line
	7750 3650 7750 3300
Wire Wire Line
	7500 2000 7500 2200
Connection ~ 7200 2750
Wire Wire Line
	7200 2750 6900 2750
Wire Wire Line
	7750 2800 7750 2750
Connection ~ 7500 2750
Wire Wire Line
	7750 2750 7500 2750
Wire Wire Line
	7500 2600 7500 2850
Wire Wire Line
	7200 2400 7200 3050
Connection ~ 7750 2750
Wire Wire Line
	7500 3250 7500 3450
Connection ~ 7750 3650
Wire Wire Line
	7500 3450 8600 3450
Wire Wire Line
	7750 3300 8400 3300
Wire Wire Line
	8600 2000 8600 1600
Wire Wire Line
	8600 1600 8950 1600
Wire Wire Line
	8950 2500 8950 2700
$Comp
L DC v3
U 1 1 5190A59B
P 8950 3150
F 0 "v3" H 8750 3250 60  0000 C CNN
F 1 "23" H 8750 3100 60  0000 C CNN
F 2 "R1" H 8650 3150 60  0000 C CNN
	1    8950 3150
	-1   0    0    -1  
$EndComp
$Comp
L IPLOT U1
U 1 1 5188A5F5
P 8000 2800
F 0 "U1" H 7850 2900 50  0000 C CNN
F 1 "IPLOT" H 8150 2900 50  0000 C CNN
	1    8000 2800
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U2
U 2 1 5188A185
P 7750 2450
F 0 "U2" H 7600 2550 50  0000 C CNN
F 1 "VPLOT8_1" H 7900 2550 50  0000 C CNN
	2    7750 2450
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U2
U 1 1 51889CD8
P 7000 2450
F 0 "U2" H 6850 2550 50  0000 C CNN
F 1 "VPLOT8_1" H 7150 2550 50  0000 C CNN
	1    7000 2450
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG02
U 1 1 518897EF
P 7200 2750
F 0 "#FLG02" H 7200 3020 30  0001 C CNN
F 1 "PWR_FLAG" H 7200 2980 30  0000 C CNN
	1    7200 2750
	1    0    0    -1  
$EndComp
$Comp
L SINE v1
U 1 1 51889574
P 6900 3200
F 0 "v1" H 6700 3300 60  0000 C CNN
F 1 "SINE" H 6700 3150 60  0000 C CNN
F 2 "R1" H 6600 3200 60  0000 C CNN
	1    6900 3200
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG03
U 1 1 51889502
P 7750 3650
F 0 "#FLG03" H 7750 3920 30  0001 C CNN
F 1 "PWR_FLAG" H 7750 3880 30  0000 C CNN
	1    7750 3650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 518894F5
P 7900 3650
F 0 "#PWR04" H 7900 3650 30  0001 C CNN
F 1 "GND" H 7900 3580 30  0001 C CNN
	1    7900 3650
	1    0    0    -1  
$EndComp
$Comp
L DC v2
U 1 1 518894AB
P 8950 2050
F 0 "v2" H 8750 2150 60  0000 C CNN
F 1 "23" H 8750 2000 60  0000 C CNN
F 2 "R1" H 8650 2050 60  0000 C CNN
	1    8950 2050
	-1   0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5188943C
P 8400 3050
F 0 "R1" V 8480 3050 50  0000 C CNN
F 1 "8" V 8400 3050 50  0000 C CNN
	1    8400 3050
	1    0    0    -1  
$EndComp
$Comp
L PNP Q2
U 1 1 518893FC
P 7400 3050
F 0 "Q2" H 7400 2900 60  0000 R CNN
F 1 "PNP" H 7400 3200 60  0000 R CNN
	1    7400 3050
	1    0    0    1   
$EndComp
$Comp
L NPN Q1
U 1 1 518893F7
P 7400 2400
F 0 "Q1" H 7400 2250 50  0000 R CNN
F 1 "NPN" H 7400 2550 50  0000 R CNN
	1    7400 2400
	1    0    0    -1  
$EndComp
$EndSCHEMATC
