EESchema Schematic File Version 2  date Friday 26 April 2013 04:42:05 PM IST
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
LIBS:example_8.1-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "26 apr 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 5450 5400
$Comp
L PWR_FLAG #FLG01
U 1 1 5178C3EF
P 5450 5400
F 0 "#FLG01" H 5450 5670 30  0001 C CNN
F 1 "PWR_FLAG" H 5450 5630 30  0000 C CNN
	1    5450 5400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 5178C3E3
P 5450 5500
F 0 "#PWR02" H 5450 5500 30  0001 C CNN
F 1 "GND" H 5450 5430 30  0001 C CNN
	1    5450 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 5300 5450 5500
Connection ~ 6550 3150
Wire Wire Line
	6350 3150 6550 3150
Wire Wire Line
	4350 5050 4350 5800
Wire Wire Line
	6850 3500 6850 5800
Wire Wire Line
	7350 4550 7350 5550
Wire Wire Line
	7350 5550 6050 5550
Wire Wire Line
	5200 3500 4850 3500
Wire Wire Line
	5500 2450 6550 2450
Wire Wire Line
	6550 3700 6550 4000
Wire Wire Line
	5500 3700 5500 4000
Wire Wire Line
	5500 2950 5500 3300
Wire Wire Line
	6550 2950 6550 3300
Wire Wire Line
	6550 4500 5500 4500
Wire Wire Line
	6850 5800 4850 5800
Wire Wire Line
	6050 4500 6050 4650
Connection ~ 6050 4500
Wire Wire Line
	6500 2450 6500 2200
Connection ~ 6500 2450
Wire Wire Line
	6500 2200 7350 2200
Wire Wire Line
	7350 2200 7350 3650
Wire Wire Line
	4350 3500 4350 4150
Wire Wire Line
	5750 3150 5500 3150
Connection ~ 5500 3150
Wire Wire Line
	6050 4600 5450 4600
Connection ~ 6050 4600
Wire Wire Line
	5450 4600 5450 4800
$Comp
L R R7
U 1 1 5178C3D2
P 5450 5050
F 0 "R7" V 5530 5050 50  0000 C CNN
F 1 "150" V 5450 5050 50  0000 C CNN
	1    5450 5050
	1    0    0    -1  
$EndComp
$Comp
L SINE v1
U 1 1 5178C33C
P 4350 4600
F 0 "v1" H 4150 4700 60  0000 C CNN
F 1 "SINE" H 4150 4550 60  0000 C CNN
F 2 "R1" H 4050 4600 60  0000 C CNN
	1    4350 4600
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8 U1
U 1 1 51779652
P 6050 3150
F 0 "U1" H 5900 3250 50  0000 C CNN
F 1 "VPLOT8" H 6200 3250 50  0000 C CNN
	1    6050 3150
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 517794FF
P 4600 3500
F 0 "R1" V 4680 3500 50  0000 C CNN
F 1 "5k" V 4600 3500 50  0000 C CNN
	1    4600 3500
	0    1    1    0   
$EndComp
$Comp
L R R6
U 1 1 517794EA
P 6550 4250
F 0 "R6" V 6630 4250 50  0000 C CNN
F 1 "150" V 6550 4250 50  0000 C CNN
	1    6550 4250
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 517794E3
P 5500 4250
F 0 "R4" V 5580 4250 50  0000 C CNN
F 1 "150" V 5500 4250 50  0000 C CNN
	1    5500 4250
	1    0    0    -1  
$EndComp
$Comp
L R R5
U 1 1 517794C9
P 6550 2700
F 0 "R5" V 6630 2700 50  0000 C CNN
F 1 "10k" V 6550 2700 50  0000 C CNN
	1    6550 2700
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 517794BE
P 5500 2700
F 0 "R3" V 5580 2700 50  0000 C CNN
F 1 "10k" V 5500 2700 50  0000 C CNN
	1    5500 2700
	1    0    0    -1  
$EndComp
$Comp
L NPN Q2
U 1 1 5177949E
P 6650 3500
F 0 "Q2" H 6650 3350 50  0000 R CNN
F 1 "NPN" H 6650 3650 50  0000 R CNN
	1    6650 3500
	-1   0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 51779433
P 4600 5800
F 0 "R2" V 4680 5800 50  0000 C CNN
F 1 "R" V 4600 5800 50  0000 C CNN
	1    4600 5800
	0    1    1    0   
$EndComp
$Comp
L DC v3
U 1 1 51779424
P 7350 4100
F 0 "v3" H 7150 4200 60  0000 C CNN
F 1 "15" H 7150 4050 60  0000 C CNN
F 2 "R1" H 7050 4100 60  0000 C CNN
	1    7350 4100
	1    0    0    -1  
$EndComp
$Comp
L NPN Q1
U 1 1 51779415
P 5400 3500
F 0 "Q1" H 5400 3350 50  0000 R CNN
F 1 "NPN" H 5400 3650 50  0000 R CNN
	1    5400 3500
	1    0    0    -1  
$EndComp
$Comp
L IDC v2
U 1 1 5177940C
P 6050 5100
F 0 "v2" H 5850 5200 60  0000 C CNN
F 1 "1m" H 5850 5050 60  0000 C CNN
F 2 "R1" H 5750 5100 60  0000 C CNN
	1    6050 5100
	1    0    0    -1  
$EndComp
$EndSCHEMATC
