EESchema Schematic File Version 2  date Monday 13 May 2013 01:31:57 PM IST
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
LIBS:example_3.12-cache
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
Connection ~ 5350 4000
Connection ~ 6300 4100
Wire Wire Line
	6300 4350 6300 4100
Wire Wire Line
	5350 3400 5350 4100
Wire Wire Line
	4950 2500 4950 2550
Wire Wire Line
	4950 2550 6500 2550
Wire Wire Line
	6500 4950 6500 3450
Wire Wire Line
	5050 5100 5050 3200
Wire Wire Line
	4200 3850 3850 3850
Connection ~ 6650 4100
Wire Wire Line
	6750 4100 6200 4100
Wire Wire Line
	6500 5850 5350 5850
Wire Wire Line
	5350 5850 5350 5300
Wire Wire Line
	5350 4900 5350 4600
Connection ~ 6500 4100
Connection ~ 5350 4100
Wire Wire Line
	4700 3850 5050 3850
Connection ~ 5050 3850
Wire Wire Line
	3850 5950 6650 5950
Wire Wire Line
	3850 5950 3850 5850
Wire Wire Line
	6650 5950 6650 4100
Wire Wire Line
	3850 3850 3850 4950
Connection ~ 4900 3850
Wire Wire Line
	4950 3000 5350 3000
Wire Wire Line
	5850 4000 5850 4350
Wire Wire Line
	5850 4350 5800 4350
$Comp
L IPLOT U3
U 1 1 51909DB6
P 5600 4000
F 0 "U3" H 5450 4100 50  0000 C CNN
F 1 "IPLOT" H 5750 4100 50  0000 C CNN
	1    5600 4000
	-1   0    0    1   
$EndComp
$Comp
L PWR_FLAG #FLG01
U 1 1 516CE3EB
P 4900 3850
F 0 "#FLG01" H 4900 3945 30  0001 C CNN
F 1 "PWR_FLAG" H 4900 4030 30  0000 C CNN
	1    4900 3850
	1    0    0    -1  
$EndComp
$Comp
L IPLOT U1
U 1 1 516C3068
P 4950 2750
F 0 "U1" H 4800 2850 50  0000 C CNN
F 1 "IPLOT" H 5100 2850 50  0000 C CNN
	1    4950 2750
	0    1    1    0   
$EndComp
$Comp
L IPLOT U2
U 1 1 516C304B
P 5350 4350
F 0 "U2" H 5200 4450 50  0000 C CNN
F 1 "IPLOT" H 5500 4450 50  0000 C CNN
	1    5350 4350
	0    1    1    0   
$EndComp
$Comp
L DC v3
U 1 1 5166EE0B
P 3850 5400
F 0 "v3" H 3650 5500 60  0000 C CNN
F 1 "5V" H 3650 5350 60  0000 C CNN
F 2 "R1" H 3550 5400 60  0000 C CNN
	1    3850 5400
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 5166ED91
P 4450 3850
F 0 "R2" V 4530 3850 50  0000 C CNN
F 1 "10000" V 4450 3850 50  0000 C CNN
	1    4450 3850
	0    -1   -1   0   
$EndComp
$Comp
L PWR_FLAG #FLG02
U 1 1 5166ED50
P 6650 4100
F 0 "#FLG02" H 6650 4195 30  0001 C CNN
F 1 "PWR_FLAG" H 6650 4280 30  0000 C CNN
	1    6650 4100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 5166ED33
P 6750 4100
F 0 "#PWR03" H 6750 4100 30  0001 C CNN
F 1 "GND" H 6750 4030 30  0001 C CNN
	1    6750 4100
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5166ED03
P 6050 4350
F 0 "R1" V 6130 4350 50  0000 C CNN
F 1 "1000" V 6050 4350 50  0000 C CNN
	1    6050 4350
	0    -1   -1   0   
$EndComp
$Comp
L DC v2
U 1 1 5166ECC4
P 6500 5400
F 0 "v2" H 6300 5500 60  0000 C CNN
F 1 "5V" H 6300 5350 60  0000 C CNN
F 2 "R1" H 6200 5400 60  0000 C CNN
	1    6500 5400
	-1   0    0    -1  
$EndComp
$Comp
L DC v1
U 1 1 5166EC91
P 6500 3000
F 0 "v1" H 6300 3100 60  0000 C CNN
F 1 "5V" H 6300 2950 60  0000 C CNN
F 2 "R1" H 6200 3000 60  0000 C CNN
	1    6500 3000
	1    0    0    -1  
$EndComp
$Comp
L PNP Q2
U 1 1 5166EC64
P 5250 5100
F 0 "Q2" H 5250 4950 60  0000 R CNN
F 1 "PNP" H 5250 5250 60  0000 R CNN
	1    5250 5100
	1    0    0    1   
$EndComp
$Comp
L NPN Q1
U 1 1 5166EC56
P 5250 3200
F 0 "Q1" H 5250 3050 50  0000 R CNN
F 1 "NPN" H 5250 3350 50  0000 R CNN
	1    5250 3200
	1    0    0    -1  
$EndComp
$EndSCHEMATC
