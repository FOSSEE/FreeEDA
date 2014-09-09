EESchema Schematic File Version 2  date Wednesday 15 May 2013 06:59:23 PM IST
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
LIBS:example_3.1-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "15 may 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	5750 4200 5750 3850
Wire Wire Line
	5750 5350 5750 5950
Connection ~ 4300 4400
Connection ~ 5750 4100
Wire Wire Line
	4300 4500 4300 4400
Wire Wire Line
	4300 4400 5450 4400
Connection ~ 4750 4400
Wire Wire Line
	4750 4600 4750 4050
Wire Wire Line
	4750 3150 4750 2750
Wire Wire Line
	4750 2750 5750 2750
Wire Wire Line
	5750 4600 5750 4850
Wire Wire Line
	4750 5500 4750 5950
Wire Wire Line
	4750 5950 5750 5950
Wire Wire Line
	5750 3250 5750 3350
$Comp
L IPLOT U2
U 1 1 51938D87
P 5750 3600
F 0 "U2" H 5600 3700 50  0000 C CNN
F 1 "IPLOT" H 5900 3700 50  0000 C CNN
	1    5750 3600
	0    1    1    0   
$EndComp
$Comp
L DC v1
U 1 1 517A27AF
P 4750 3600
F 0 "v1" H 4550 3700 60  0000 C CNN
F 1 "DC" H 4550 3550 60  0000 C CNN
F 2 "R1" H 4450 3600 60  0000 C CNN
	1    4750 3600
	1    0    0    -1  
$EndComp
$Comp
L DC v2
U 1 1 517A278C
P 4750 5050
F 0 "v2" H 4550 5150 60  0000 C CNN
F 1 "DC" H 4550 5000 60  0000 C CNN
F 2 "R1" H 4450 5050 60  0000 C CNN
	1    4750 5050
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U1
U 1 1 5178C864
P 6050 4100
F 0 "U1" H 5900 4200 50  0000 C CNN
F 1 "VPLOT8_1" H 6200 4200 50  0000 C CNN
	1    6050 4100
	0    1    1    0   
$EndComp
$Comp
L NPN Q1
U 1 1 5178C812
P 5650 4400
F 0 "Q1" H 5650 4250 50  0000 R CNN
F 1 "NPN" H 5650 4550 50  0000 R CNN
	1    5650 4400
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG1
U 1 1 516BDAF0
P 4300 4400
F 0 "#FLG1" H 4300 4670 30  0001 C CNN
F 1 "PWR_FLAG" H 4300 4630 30  0000 C CNN
	1    4300 4400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR1
U 1 1 516BDAE0
P 4300 4500
F 0 "#PWR1" H 4300 4500 30  0001 C CNN
F 1 "GND" H 4300 4430 30  0001 C CNN
	1    4300 4500
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 516BD9B5
P 5750 3000
F 0 "R1" V 5830 3000 50  0000 C CNN
F 1 "5k" V 5750 3000 50  0000 C CNN
	1    5750 3000
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 516BD9A9
P 5750 5100
F 0 "R2" V 5850 5100 50  0000 C CNN
F 1 "7.07k" V 5750 5100 50  0000 C CNN
	1    5750 5100
	1    0    0    -1  
$EndComp
$EndSCHEMATC
