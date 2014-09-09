EESchema Schematic File Version 2  date Monday 13 May 2013 01:19:52 PM IST
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
LIBS:example_3.9-cache
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
U 1 1 51909AF0
P 6700 3550
F 0 "#PWR01" H 6700 3550 30  0001 C CNN
F 1 "GND" H 6700 3480 30  0001 C CNN
	1    6700 3550
	1    0    0    -1  
$EndComp
Connection ~ 6500 3550
Wire Wire Line
	6500 3550 6700 3550
Wire Wire Line
	4800 3600 4150 3600
Wire Wire Line
	6500 2050 5100 2050
Wire Wire Line
	5100 5100 5100 5250
Wire Wire Line
	5100 3800 5100 3950
Wire Wire Line
	5100 3250 5100 3400
Wire Wire Line
	5100 2650 5100 2750
Wire Wire Line
	5100 4450 5100 4600
Wire Wire Line
	5100 2050 5100 2150
Connection ~ 5100 3350
Connection ~ 5100 3900
Wire Wire Line
	3650 3600 3650 5100
Connection ~ 5100 2050
Connection ~ 5100 2050
Connection ~ 5100 2050
Wire Wire Line
	5100 5250 6500 5250
Connection ~ 4750 3600
Connection ~ 3650 3600
Connection ~ 4150 3600
Connection ~ 3950 3600
Connection ~ 4800 3600
Connection ~ 3650 4850
Wire Wire Line
	6500 2950 6500 4350
$Comp
L DC v2
U 1 1 51909ACB
P 6500 4800
F 0 "v2" H 6300 4900 60  0000 C CNN
F 1 "5" H 6300 4750 60  0000 C CNN
F 2 "R1" H 6200 4800 60  0000 C CNN
	1    6500 4800
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG02
U 1 1 516C1E89
P 3650 4850
F 0 "#FLG02" H 3650 5120 30  0001 C CNN
F 1 "PWR_FLAG" H 3650 5080 30  0000 C CNN
	1    3650 4850
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U2
U 1 1 516C1EFD
P 4750 3300
F 0 "U2" H 4600 3400 50  0000 C CNN
F 1 "VPLOT8_1" H 4900 3400 50  0000 C CNN
	1    4750 3300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 516C1E7B
P 3650 5100
F 0 "#PWR03" H 3650 5100 30  0001 C CNN
F 1 "GND" H 3650 5030 30  0001 C CNN
	1    3650 5100
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 516C1E56
P 3900 3600
F 0 "R1" V 3980 3600 50  0000 C CNN
F 1 "10000" V 3900 3600 50  0000 C CNN
	1    3900 3600
	0    1    1    0   
$EndComp
$Comp
L VPLOT8_1 U2
U 3 1 516C1E37
P 5400 3900
F 0 "U2" H 5250 4000 50  0000 C CNN
F 1 "VPLOT8_1" H 5550 4000 50  0000 C CNN
	3    5400 3900
	0    1    1    0   
$EndComp
$Comp
L R R3
U 1 1 516C1E04
P 5100 4850
F 0 "R3" V 5180 4850 50  0000 C CNN
F 1 "10000" V 5100 4850 50  0000 C CNN
	1    5100 4850
	1    0    0    -1  
$EndComp
$Comp
L IPLOT U4
U 1 1 516C1DF8
P 5100 4200
F 0 "U4" H 4950 4300 50  0000 C CNN
F 1 "IPLOT" H 5250 4300 50  0000 C CNN
	1    5100 4200
	0    1    1    0   
$EndComp
$Comp
L VPLOT8_1 U2
U 2 1 516C1DCB
P 5400 3350
F 0 "U2" H 5250 3450 50  0000 C CNN
F 1 "VPLOT8_1" H 5550 3450 50  0000 C CNN
	2    5400 3350
	0    1    1    0   
$EndComp
$Comp
L DC v1
U 1 1 516C1DBD
P 6500 2500
F 0 "v1" H 6300 2600 60  0000 C CNN
F 1 "5" H 6300 2450 60  0000 C CNN
F 2 "R1" H 6200 2500 60  0000 C CNN
	1    6500 2500
	1    0    0    -1  
$EndComp
$Comp
L IPLOT U3
U 1 1 516C1DAD
P 5100 3000
F 0 "U3" H 4950 3100 50  0000 C CNN
F 1 "IPLOT" H 5250 3100 50  0000 C CNN
	1    5100 3000
	0    1    1    0   
$EndComp
$Comp
L R R2
U 1 1 516C1D7F
P 5100 2400
F 0 "R2" V 5180 2400 50  0000 C CNN
F 1 "1000" V 5100 2400 50  0000 C CNN
	1    5100 2400
	1    0    0    -1  
$EndComp
$Comp
L PNP Q1
U 1 1 516C1D57
P 5000 3600
F 0 "Q1" H 5000 3450 60  0000 R CNN
F 1 "PNP" H 5000 3750 60  0000 R CNN
	1    5000 3600
	1    0    0    -1  
$EndComp
$EndSCHEMATC
