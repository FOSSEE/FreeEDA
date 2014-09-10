EESchema Schematic File Version 2  date Monday 15 April 2013 04:09:27 PM IST
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
LIBS:example3.4-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "15 apr 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 5000 2650
$Comp
L VPLOT8_1 U3
U 1 1 516BD8B9
P 5300 2650
F 0 "U3" H 5150 2750 50  0000 C CNN
F 1 "VPLOT8_1" H 5450 2750 50  0000 C CNN
	1    5300 2650
	0    1    1    0   
$EndComp
$Comp
L VPLOT8_1 U3
U 2 1 516BD8AC
P 5300 3450
F 0 "U3" H 5150 3550 50  0000 C CNN
F 1 "VPLOT8_1" H 5450 3550 50  0000 C CNN
	2    5300 3450
	0    1    1    0   
$EndComp
Wire Wire Line
	5900 2550 5900 1050
Wire Wire Line
	4400 4300 4400 3050
Wire Wire Line
	5000 3800 5000 3250
Wire Wire Line
	5000 2050 5000 1550
Connection ~ 5000 5450
Wire Wire Line
	4400 5450 5900 5450
Wire Wire Line
	5900 1050 5000 1050
Wire Wire Line
	4400 3050 4700 3050
Wire Wire Line
	4400 5450 4400 5200
Wire Wire Line
	5000 4950 5000 5750
Connection ~ 5000 5600
Connection ~ 5000 3450
Wire Wire Line
	5000 2550 5000 2850
Wire Wire Line
	5000 4300 5000 4450
Wire Wire Line
	5900 5450 5900 3450
$Comp
L IPLOT U2
U 1 1 516BD643
P 5000 4050
F 0 "U2" H 4850 4150 50  0000 C CNN
F 1 "IPLOT" H 5150 4150 50  0000 C CNN
	1    5000 4050
	0    1    1    0   
$EndComp
$Comp
L IPLOT U1
U 1 1 516BD5F9
P 5000 2300
F 0 "U1" H 4850 2400 50  0000 C CNN
F 1 "IPLOT" H 5150 2400 50  0000 C CNN
	1    5000 2300
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG01
U 1 1 5166BF83
P 5000 5600
F 0 "#FLG01" H 5000 5695 30  0001 C CNN
F 1 "PWR_FLAG" H 5000 5780 30  0000 C CNN
	1    5000 5600
	0    1    1    0   
$EndComp
$Comp
L GND #PWR02
U 1 1 5166BF64
P 5000 5750
F 0 "#PWR02" H 5000 5750 30  0001 C CNN
F 1 "GND" H 5000 5680 30  0001 C CNN
	1    5000 5750
	1    0    0    -1  
$EndComp
$Comp
L DC v1
U 1 1 5166BEE6
P 4400 4750
F 0 "v1" H 4200 4850 60  0000 C CNN
F 1 "4" H 4200 4700 60  0000 C CNN
F 2 "R1" H 4100 4750 60  0000 C CNN
	1    4400 4750
	1    0    0    -1  
$EndComp
$Comp
L DC v2
U 1 1 5166BED7
P 5900 3000
F 0 "v2" H 5700 3100 60  0000 C CNN
F 1 "10V" H 5700 2950 60  0000 C CNN
F 2 "R1" H 5600 3000 60  0000 C CNN
	1    5900 3000
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 5166BE96
P 5000 4700
F 0 "R2" V 5080 4700 50  0000 C CNN
F 1 "3300" V 5000 4700 50  0000 C CNN
	1    5000 4700
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5166BE8E
P 5000 1300
F 0 "R1" V 5080 1300 50  0000 C CNN
F 1 "4700" V 5000 1300 50  0000 C CNN
	1    5000 1300
	1    0    0    -1  
$EndComp
$Comp
L NPN Q1
U 1 1 5166BE53
P 4900 3050
F 0 "Q1" H 4900 2900 50  0000 R CNN
F 1 "NPN" H 4900 3200 50  0000 R CNN
	1    4900 3050
	1    0    0    -1  
$EndComp
$EndSCHEMATC
