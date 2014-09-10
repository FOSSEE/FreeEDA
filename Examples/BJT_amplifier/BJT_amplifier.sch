EESchema Schematic File Version 2  date Thursday 06 June 2013 05:14:30 PM IST
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
LIBS:BJT_amplifier-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "6 jun 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 7050 4450
Wire Wire Line
	7600 4450 5100 4450
Wire Wire Line
	7600 4450 7600 4050
Wire Wire Line
	5100 4450 5100 4500
Wire Wire Line
	5100 4500 3700 4500
Connection ~ 6300 4450
Connection ~ 6800 3300
Wire Wire Line
	3800 3600 3700 3600
Wire Wire Line
	7050 3950 7050 3300
Wire Wire Line
	7050 3300 6700 3300
Connection ~ 5100 3600
Connection ~ 6100 3300
Wire Wire Line
	6300 3300 5850 3300
Wire Wire Line
	5850 3800 5850 3950
Wire Wire Line
	5850 3300 5850 3400
Wire Wire Line
	5100 3300 5100 3950
Wire Wire Line
	5550 3600 4950 3600
Wire Wire Line
	6300 4050 6300 3900
Wire Wire Line
	6300 3900 5850 3900
Connection ~ 5850 3900
Connection ~ 5850 4450
Wire Wire Line
	4550 3600 4300 3600
Connection ~ 5100 4450
Wire Wire Line
	5650 4450 5650 4850
Connection ~ 5650 4450
Wire Wire Line
	5100 2800 7600 2800
Wire Wire Line
	7600 2800 7600 3150
Connection ~ 6100 2800
$Comp
L DC v1
U 1 1 51A5D97E
P 7600 3600
F 0 "v1" H 7400 3700 60  0000 C CNN
F 1 "DC" H 7400 3550 60  0000 C CNN
F 2 "R1" H 7300 3600 60  0000 C CNN
	1    7600 3600
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U1
U 1 1 51A5D42D
P 6800 3000
F 0 "U1" H 6650 3100 50  0000 C CNN
F 1 "VPLOT8_1" H 6950 3100 50  0000 C CNN
	1    6800 3000
	1    0    0    -1  
$EndComp
$Comp
L AC v2
U 1 1 51A486A5
P 3700 4050
F 0 "v2" H 3500 4150 60  0000 C CNN
F 1 "AC" H 3500 4000 60  0000 C CNN
F 2 "R1" H 3400 4050 60  0000 C CNN
	1    3700 4050
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG01
U 1 1 51A48298
P 5650 4450
F 0 "#FLG01" H 5650 4720 30  0001 C CNN
F 1 "PWR_FLAG" H 5650 4680 30  0000 C CNN
	1    5650 4450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 51A47FCD
P 5650 4850
F 0 "#PWR02" H 5650 4850 30  0001 C CNN
F 1 "GND" H 5650 4780 30  0001 C CNN
	1    5650 4850
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 51A47FBC
P 4050 3600
F 0 "R1" V 4130 3600 50  0000 C CNN
F 1 "50" V 4050 3600 50  0000 C CNN
	1    4050 3600
	0    1    1    0   
$EndComp
$Comp
L R R2
U 1 1 51A47FAB
P 5100 3050
F 0 "R2" V 5180 3050 50  0000 C CNN
F 1 "200k" V 5100 3050 50  0000 C CNN
	1    5100 3050
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 51A47FA0
P 4750 3600
F 0 "C1" H 4800 3700 50  0000 L CNN
F 1 "40u" H 4800 3500 50  0000 L CNN
	1    4750 3600
	0    -1   -1   0   
$EndComp
$Comp
L R R3
U 1 1 51A47F97
P 5100 4200
F 0 "R3" V 5180 4200 50  0000 C CNN
F 1 "50k" V 5100 4200 50  0000 C CNN
	1    5100 4200
	1    0    0    -1  
$EndComp
$Comp
L R R6
U 1 1 51A47F8B
P 7050 4200
F 0 "R6" V 7130 4200 50  0000 C CNN
F 1 "1k" V 7050 4200 50  0000 C CNN
	1    7050 4200
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 51A47F80
P 6300 4250
F 0 "C2" H 6350 4350 50  0000 L CNN
F 1 "100u" H 6350 4150 50  0000 L CNN
	1    6300 4250
	-1   0    0    1   
$EndComp
$Comp
L C C3
U 1 1 51A47F75
P 6500 3300
F 0 "C3" H 6550 3400 50  0000 L CNN
F 1 "40u" H 6550 3200 50  0000 L CNN
	1    6500 3300
	0    1    1    0   
$EndComp
$Comp
L R R5
U 1 1 51A47F5C
P 6100 3050
F 0 "R5" V 6180 3050 50  0000 C CNN
F 1 "2k" V 6100 3050 50  0000 C CNN
	1    6100 3050
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 51A47F50
P 5850 4200
F 0 "R4" V 5930 4200 50  0000 C CNN
F 1 "1.5k" V 5850 4200 50  0000 C CNN
	1    5850 4200
	1    0    0    -1  
$EndComp
$Comp
L NPN Q1
U 1 1 51A47F29
P 5750 3600
F 0 "Q1" H 5750 3450 50  0000 R CNN
F 1 "NPN" H 5750 3750 50  0000 R CNN
	1    5750 3600
	1    0    0    -1  
$EndComp
$EndSCHEMATC
