EESchema Schematic File Version 2  date Monday 13 May 2013 12:54:28 PM IST
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
LIBS:example_2.2-cache
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
Connection ~ 6650 4750
$Comp
L VPLOT8_1 U3
U 1 1 519094DB
P 6650 4450
F 0 "U3" H 6500 4550 50  0000 C CNN
F 1 "VPLOT8_1" H 6800 4550 50  0000 C CNN
	1    6650 4450
	1    0    0    -1  
$EndComp
Connection ~ 6350 4750
Wire Wire Line
	6350 4750 6650 4750
Wire Wire Line
	5050 3150 5450 3150
Wire Wire Line
	4150 6850 4150 6500
Wire Wire Line
	4150 3150 4150 4150
Wire Wire Line
	6350 3850 6350 4150
Wire Wire Line
	4150 5750 4150 6000
Wire Wire Line
	6350 4650 6350 4800
Wire Wire Line
	4150 5350 4150 4650
Wire Wire Line
	6350 5200 4150 5200
Connection ~ 4150 5200
Wire Wire Line
	6350 3350 6350 3150
Connection ~ 6350 4000
Connection ~ 4150 6650
Wire Wire Line
	5250 3150 5250 3300
Connection ~ 5250 3150
$Comp
L GND #PWR01
U 1 1 51909464
P 5250 3300
F 0 "#PWR01" H 5250 3300 30  0001 C CNN
F 1 "GND" H 5250 3230 30  0001 C CNN
	1    5250 3300
	1    0    0    -1  
$EndComp
$Comp
L DC v2
U 1 1 51909454
P 5900 3150
F 0 "v2" H 5700 3250 60  0000 C CNN
F 1 "10V" H 5700 3100 60  0000 C CNN
F 2 "R1" H 5600 3150 60  0000 C CNN
	1    5900 3150
	0    1    1    0   
$EndComp
$Comp
L DC v1
U 1 1 5167D912
P 4600 3150
F 0 "v1" H 4400 3250 60  0000 C CNN
F 1 "10V" H 4400 3100 60  0000 C CNN
F 2 "R1" H 4300 3150 60  0000 C CNN
	1    4600 3150
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG02
U 1 1 516A8F23
P 4150 6650
F 0 "#FLG02" H 4150 6745 30  0001 C CNN
F 1 "PWR_FLAG" H 4150 6830 30  0000 C CNN
	1    4150 6650
	0    1    1    0   
$EndComp
$Comp
L GND #PWR03
U 1 1 5167DAB9
P 4150 6850
F 0 "#PWR03" H 4150 6850 30  0001 C CNN
F 1 "GND" H 4150 6780 30  0001 C CNN
	1    4150 6850
	1    0    0    -1  
$EndComp
$Comp
L IPLOT U1
U 1 1 5167DA8B
P 4150 6250
F 0 "U1" H 4000 6350 50  0000 C CNN
F 1 "IPLOT" H 4300 6350 50  0000 C CNN
	1    4150 6250
	0    1    1    0   
$EndComp
$Comp
L IPLOT U2
U 1 1 5167D9D2
P 6350 3600
F 0 "U2" H 6200 3700 50  0000 C CNN
F 1 "IPLOT" H 6500 3700 50  0000 C CNN
	1    6350 3600
	0    1    1    0   
$EndComp
$Comp
L DIODE D2
U 1 1 5167D956
P 6350 5000
F 0 "D2" H 6350 5100 40  0000 C CNN
F 1 "DIODE" H 6350 4900 40  0000 C CNN
	1    6350 5000
	0    1    1    0   
$EndComp
$Comp
L R R2
U 1 1 5167D8E5
P 6350 4400
F 0 "R2" V 6430 4400 50  0000 C CNN
F 1 "5k" V 6350 4400 50  0000 C CNN
	1    6350 4400
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5167D8B8
P 4150 4400
F 0 "R1" V 4230 4400 50  0000 C CNN
F 1 "10k" V 4150 4400 50  0000 C CNN
	1    4150 4400
	1    0    0    -1  
$EndComp
$Comp
L DIODE D1
U 1 1 5167D869
P 4150 5550
F 0 "D1" H 4150 5650 40  0000 C CNN
F 1 "DIODE" H 4150 5450 40  0000 C CNN
	1    4150 5550
	0    -1   -1   0   
$EndComp
$EndSCHEMATC
