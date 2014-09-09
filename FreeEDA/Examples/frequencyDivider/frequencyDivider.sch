EESchema Schematic File Version 2  date Monday 17 December 2012 10:57:17 AM IST
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
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
LIBS:converterSpice
LIBS:digitalSpice
LIBS:linearSpice
LIBS:measurementSpice
LIBS:portSpice
LIBS:sourcesSpice
LIBS:convergenceAidSpice
LIBS:frequencyDivider-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "17 dec 2012"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L VPLOT8_1 U1
U 2 1 50CE9193
P 7700 3000
F 0 "U1" H 7550 3100 50  0000 C CNN
F 1 "VPLOT8_1" H 7850 3100 50  0000 C CNN
	2    7700 3000
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U1
U 1 1 50CE918C
P 6300 3000
F 0 "U1" H 6150 3100 50  0000 C CNN
F 1 "VPLOT8_1" H 6450 3100 50  0000 C CNN
	1    6300 3000
	1    0    0    -1  
$EndComp
Connection ~ 4650 4100
Wire Wire Line
	4650 4100 4650 4050
Connection ~ 6600 2850
Wire Wire Line
	7050 4600 6600 4600
Wire Wire Line
	6600 4600 6600 2850
Connection ~ 6300 3350
Wire Wire Line
	6300 3300 6300 3900
Connection ~ 6100 3350
Wire Wire Line
	6300 3900 6400 3900
Wire Wire Line
	6300 3350 5900 3350
Wire Wire Line
	6400 2850 6400 3650
Wire Wire Line
	6100 4550 6100 4100
Wire Wire Line
	3650 4700 4850 4700
Wire Wire Line
	3650 4700 3650 4050
Wire Wire Line
	3650 2700 4450 2700
Wire Wire Line
	3650 2700 3650 3150
Wire Wire Line
	5900 3550 6000 3550
Wire Wire Line
	6000 3550 6000 3000
Wire Wire Line
	6000 3000 4150 3000
Wire Wire Line
	4150 3000 4150 3400
Connection ~ 4000 3400
Wire Wire Line
	4150 3400 4000 3400
Wire Wire Line
	4000 4150 4000 4000
Connection ~ 4200 4100
Wire Wire Line
	4500 3350 4200 3350
Wire Wire Line
	4200 3350 4200 4100
Wire Wire Line
	4300 4400 5200 4400
Connection ~ 5700 4550
Wire Wire Line
	5700 4550 5700 4300
Connection ~ 4850 4550
Wire Wire Line
	4850 4700 4850 4550
Connection ~ 5200 4550
Connection ~ 5200 4400
Wire Wire Line
	5200 4550 5200 3950
Wire Wire Line
	5900 3750 5900 4100
Wire Wire Line
	4450 2700 4450 2850
Connection ~ 4450 2850
Connection ~ 5200 2850
Wire Wire Line
	5900 4550 5900 4800
Connection ~ 5900 4550
Connection ~ 4450 2700
Wire Wire Line
	4500 3850 4400 3850
Wire Wire Line
	4400 3850 4400 2850
Connection ~ 4400 2850
Wire Wire Line
	4300 4000 4300 3600
Wire Wire Line
	4300 3600 4500 3600
Wire Wire Line
	4000 3350 4000 3500
Wire Wire Line
	5900 4100 4000 4100
Connection ~ 4000 4100
Wire Wire Line
	6100 3350 6100 3600
Wire Wire Line
	4000 4550 6400 4550
Wire Wire Line
	6400 4550 6400 4150
Connection ~ 6100 4550
Wire Wire Line
	5200 2850 5200 3150
Wire Wire Line
	4000 2850 7050 2850
Wire Wire Line
	7050 2850 7050 3200
Connection ~ 6400 2850
Wire Wire Line
	7700 3650 7700 3300
$Comp
L IC U2
U 1 1 50CE8F30
P 4650 4050
F 0 "U2" H 4650 4320 30  0000 C CNN
F 1 "IC" H 4650 4280 30  0000 C CNN
	1    4650 4050
	1    0    0    -1  
$EndComp
NoConn ~ 7700 4150
$Comp
L 74LS109 U3
U 1 1 50C1C9BA
P 7050 3900
F 0 "U3" H 7050 4000 60  0000 C CNN
F 1 "74LS109" H 7050 3800 60  0000 C CNN
	1    7050 3900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 50A93D02
P 5900 4800
F 0 "#PWR01" H 5900 4800 30  0001 C CNN
F 1 "GND" H 5900 4730 30  0001 C CNN
	1    5900 4800
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG02
U 1 1 50A93CC0
P 5700 4300
F 0 "#FLG02" H 5700 4570 30  0001 C CNN
F 1 "PWR_FLAG" H 5700 4530 30  0000 C CNN
	1    5700 4300
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG03
U 1 1 50A93CB7
P 5200 2850
F 0 "#FLG03" H 5200 3120 30  0001 C CNN
F 1 "PWR_FLAG" H 5200 3080 30  0000 C CNN
	1    5200 2850
	1    0    0    -1  
$EndComp
$Comp
L DC v1
U 1 1 50A93C56
P 3650 3600
F 0 "v1" H 3450 3700 60  0000 C CNN
F 1 "5" H 3450 3550 60  0000 C CNN
F 2 "R1" H 3350 3600 60  0000 C CNN
	1    3650 3600
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 50A93BFE
P 6100 3850
F 0 "R3" V 6180 3850 50  0000 C CNN
F 1 "1000" V 6100 3850 50  0000 C CNN
	1    6100 3850
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 50A93ACA
P 4300 4200
F 0 "C2" H 4350 4300 50  0000 L CNN
F 1 "0.01e-6" H 4350 4100 50  0000 L CNN
	1    4300 4200
	1    0    0    -1  
$EndComp
$Comp
L CP C1
U 1 1 50A93893
P 4000 4350
F 0 "C1" H 4050 4450 50  0000 L CNN
F 1 "100e-12" H 4050 4250 50  0000 L CNN
	1    4000 4350
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 50A93858
P 4000 3750
F 0 "R2" V 4080 3750 50  0000 C CNN
F 1 "10000" V 4000 3750 50  0000 C CNN
	1    4000 3750
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 50A93852
P 4000 3100
F 0 "R1" V 4080 3100 50  0000 C CNN
F 1 "1000" V 4000 3100 50  0000 C CNN
	1    4000 3100
	1    0    0    -1  
$EndComp
$Comp
L LM555N X1
U 1 1 50A937B9
P 5200 3550
F 0 "X1" H 5200 3650 70  0000 C CNN
F 1 "LM555N" H 5200 3450 70  0000 C CNN
	1    5200 3550
	1    0    0    -1  
$EndComp
$EndSCHEMATC
