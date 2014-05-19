EESchema Schematic File Version 2  date Monday 17 December 2012 11:46:55 AM IST
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
LIBS:converterSpice
LIBS:digitalSpice
LIBS:linearSpice
LIBS:measurementSpice
LIBS:portSpice
LIBS:sourcesSpice
LIBS:modifiedNodalExample-cache
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
Wire Wire Line
	5300 3200 5300 3250
Connection ~ 5300 4250
Wire Wire Line
	5300 4250 5300 4100
Wire Wire Line
	5150 3050 5800 3050
Wire Wire Line
	5800 3050 5800 3350
Connection ~ 4950 4250
Wire Wire Line
	4950 4050 4950 4250
Connection ~ 4950 3350
Wire Wire Line
	4850 3350 5050 3350
Wire Wire Line
	4350 3350 4100 3350
Wire Wire Line
	5800 3350 5550 3350
Wire Wire Line
	4100 4250 5800 4250
Wire Wire Line
	4100 3350 4100 3050
Wire Wire Line
	4100 3050 4650 3050
Wire Wire Line
	4750 4250 4750 4400
Connection ~ 4750 4250
Wire Wire Line
	4950 3550 4950 3250
Wire Wire Line
	4950 3250 5300 3250
$Comp
L VPRINT1 U1
U 1 1 50692E86
P 5300 2900
F 0 "U1" H 5150 3000 50  0001 C CNN
F 1 "VPRINT1" H 5450 3000 50  0000 C CNN
	1    5300 2900
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG01
U 1 1 5069279A
P 5300 4100
F 0 "#FLG01" H 5300 4370 30  0001 C CNN
F 1 "PWR_FLAG" H 5300 4330 30  0000 C CNN
	1    5300 4100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 50692771
P 4750 4400
F 0 "#PWR02" H 4750 4400 30  0001 C CNN
F 1 "GND" H 4750 4330 30  0001 C CNN
	1    4750 4400
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 50692628
P 5300 3350
F 0 "R3" V 5380 3350 50  0000 C CNN
F 1 "1" V 5300 3350 50  0000 C CNN
	1    5300 3350
	0    1    1    0   
$EndComp
$Comp
L R R4
U 1 1 5069261E
P 4900 3050
F 0 "R4" V 4980 3050 50  0000 C CNN
F 1 "1" V 4900 3050 50  0000 C CNN
	1    4900 3050
	0    1    1    0   
$EndComp
$Comp
L R R1
U 1 1 50692613
P 4600 3350
F 0 "R1" V 4680 3350 50  0000 C CNN
F 1 "1" V 4600 3350 50  0000 C CNN
	1    4600 3350
	0    1    1    0   
$EndComp
$Comp
L R R2
U 1 1 5067FEAC
P 4950 3800
F 0 "R2" V 5030 3800 50  0000 C CNN
F 1 "1" V 4950 3800 50  0000 C CNN
	1    4950 3800
	1    0    0    -1  
$EndComp
$Comp
L DC v2
U 1 1 5067FE8E
P 5800 3800
F 0 "v2" H 5600 3900 60  0000 C CNN
F 1 "10" H 5600 3750 60  0000 C CNN
F 2 "R3" H 5500 3800 60  0000 C CNN
	1    5800 3800
	1    0    0    -1  
$EndComp
$Comp
L DC v1
U 1 1 5067FE8A
P 4100 3800
F 0 "v1" H 3900 3900 60  0000 C CNN
F 1 "5" H 3900 3750 60  0000 C CNN
F 2 "R3" H 3800 3800 60  0000 C CNN
	1    4100 3800
	1    0    0    -1  
$EndComp
$EndSCHEMATC
