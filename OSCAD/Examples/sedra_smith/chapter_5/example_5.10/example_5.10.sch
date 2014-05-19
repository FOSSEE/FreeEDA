EESchema Schematic File Version 2  date Monday 13 May 2013 01:50:16 PM IST
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
LIBS:example_5.10-cache
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
Wire Wire Line
	6000 3200 6350 3200
Connection ~ 5200 3800
Connection ~ 4850 4700
Wire Wire Line
	4850 4700 4850 4850
Connection ~ 6350 3700
Wire Wire Line
	6500 3700 6250 3700
Wire Wire Line
	5050 3800 5250 3800
Wire Wire Line
	5250 3600 5050 3600
Wire Wire Line
	5150 3600 5150 3200
Connection ~ 5150 3600
Wire Wire Line
	6350 3200 6350 3700
Wire Wire Line
	4550 3600 4550 4700
Wire Wire Line
	4550 4700 5050 4700
Wire Wire Line
	5150 3200 5500 3200
$Comp
L R R2
U 1 1 5190A20F
P 5750 3200
F 0 "R2" V 5830 3200 50  0000 C CNN
F 1 "100k" V 5750 3200 50  0000 C CNN
	1    5750 3200
	0    1    1    0   
$EndComp
$Comp
L VPLOT8_1 U1
U 1 1 51877E04
P 5200 4100
F 0 "U1" H 5050 4200 50  0000 C CNN
F 1 "VPLOT8_1" H 5350 4200 50  0000 C CNN
	1    5200 4100
	-1   0    0    1   
$EndComp
$Comp
L VPLOT8_1 U1
U 2 1 51877DFD
P 6500 3400
F 0 "U1" H 6350 3500 50  0000 C CNN
F 1 "VPLOT8_1" H 6650 3500 50  0000 C CNN
	2    6500 3400
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG1
U 1 1 51877DEF
P 4850 4700
F 0 "#FLG1" H 4850 4970 30  0001 C CNN
F 1 "PWR_FLAG" H 4850 4930 30  0000 C CNN
	1    4850 4700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR1
U 1 1 51877DE4
P 4850 4850
F 0 "#PWR1" H 4850 4850 30  0001 C CNN
F 1 "GND" H 4850 4780 30  0001 C CNN
	1    4850 4850
	1    0    0    -1  
$EndComp
$Comp
L AC V1
U 1 1 51877DB5
P 5050 4250
F 0 "V1" H 4850 4350 60  0000 C CNN
F 1 "AC" H 4850 4200 60  0000 C CNN
F 2 "R1" H 4750 4250 60  0000 C CNN
	1    5050 4250
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 51877DA4
P 4800 3600
F 0 "R1" V 4880 3600 50  0000 C CNN
F 1 "1k" V 4800 3600 50  0000 C CNN
	1    4800 3600
	0    1    1    0   
$EndComp
$Comp
L UA741 X1
U 1 1 51877D93
P 5750 3700
F 0 "X1" H 5900 3850 60  0000 C CNN
F 1 "UA741" H 5900 3950 60  0000 C CNN
	1    5750 3700
	1    0    0    -1  
$EndComp
$EndSCHEMATC
