EESchema Schematic File Version 2  date Monday 22 April 2013 12:09:56 PM IST
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
LIBS:example_7.1-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "22 apr 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 1050 3250
$Comp
L VPLOT8_1 U2
U 1 1 5174D971
P 1050 2950
F 0 "U2" H 900 3050 50  0000 C CNN
F 1 "VPLOT8_1" H 1200 3050 50  0000 C CNN
	1    1050 2950
	1    0    0    -1  
$EndComp
Connection ~ 2950 3200
$Comp
L PWR_FLAG #FLG01
U 1 1 5174D14C
P 2050 5350
F 0 "#FLG01" H 2050 5620 30  0001 C CNN
F 1 "PWR_FLAG" H 2050 5580 30  0000 C CNN
	1    2050 5350
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U1
U 2 1 5174D02B
P 2950 2900
F 0 "U1" H 2800 3000 50  0000 C CNN
F 1 "VPLOT8_1" H 3100 3000 50  0000 C CNN
	2    2950 2900
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U1
U 1 1 5174D021
P 2050 2900
F 0 "U1" H 1900 3000 50  0000 C CNN
F 1 "VPLOT8_1" H 2200 3000 50  0000 C CNN
	1    2050 2900
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U1
U 3 1 5174D010
P 4050 2900
F 0 "U1" H 3900 3000 50  0000 C CNN
F 1 "VPLOT8_1" H 4200 3000 50  0000 C CNN
	3    4050 2900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 5174CFD9
P 2050 5500
F 0 "#PWR02" H 2050 5500 30  0001 C CNN
F 1 "GND" H 2050 5430 30  0001 C CNN
	1    2050 5500
	1    0    0    -1  
$EndComp
Connection ~ 2750 5350
Wire Wire Line
	2750 3950 2750 5350
Connection ~ 2050 5350
Wire Wire Line
	1050 4200 1050 5350
Connection ~ 2050 4600
Wire Wire Line
	2050 4800 2050 4000
Wire Wire Line
	3650 4600 3800 4600
Connection ~ 3800 3200
Wire Wire Line
	3800 4600 3800 3200
Connection ~ 4050 3200
Wire Wire Line
	4050 3200 4050 3350
Wire Wire Line
	2050 4200 2500 4200
Connection ~ 2050 4200
Wire Wire Line
	2500 4200 2500 3700
Wire Wire Line
	1050 3200 1050 3300
Wire Wire Line
	2050 3200 2050 3500
Wire Wire Line
	1550 3200 2500 3200
Wire Wire Line
	2500 3200 2500 3600
Connection ~ 2050 3200
Wire Wire Line
	2750 3350 2750 3200
Wire Wire Line
	2750 3200 3100 3200
Wire Wire Line
	3600 3200 4250 3200
Wire Wire Line
	2050 4600 3150 4600
Wire Wire Line
	2050 5300 2050 5500
Wire Wire Line
	4050 3850 4050 5350
Wire Wire Line
	4050 5350 1050 5350
$Comp
L R R3
U 1 1 5174CF9E
P 2050 5050
F 0 "R3" V 2130 5050 50  0000 C CNN
F 1 "1000" V 2050 5050 50  0000 C CNN
	1    2050 5050
	-1   0    0    1   
$EndComp
$Comp
L R R5
U 1 1 5174CF7E
P 3400 4600
F 0 "R5" V 3480 4600 50  0000 C CNN
F 1 "100000" V 3400 4600 50  0000 C CNN
	1    3400 4600
	0    1    1    0   
$EndComp
$Comp
L R R6
U 1 1 5174CF4D
P 4050 3600
F 0 "R6" V 4130 3600 50  0000 C CNN
F 1 "2000" V 4050 3600 50  0000 C CNN
	1    4050 3600
	-1   0    0    1   
$EndComp
$Comp
L R R4
U 1 1 5174CF16
P 3350 3200
F 0 "R4" V 3430 3200 50  0000 C CNN
F 1 "1000" V 3350 3200 50  0000 C CNN
	1    3350 3200
	0    1    1    0   
$EndComp
$Comp
L VCVS E1
U 1 1 5174CEE8
P 2700 3650
F 0 "E1" H 2500 3750 50  0000 C CNN
F 1 "2" H 2500 3600 50  0000 C CNN
	1    2700 3650
	0    1    1    0   
$EndComp
$Comp
L R R2
U 1 1 5174CEC2
P 2050 3750
F 0 "R2" V 2130 3750 50  0000 C CNN
F 1 "100000" V 2050 3750 50  0000 C CNN
	1    2050 3750
	-1   0    0    1   
$EndComp
$Comp
L SINE v1
U 1 1 5174CE88
P 1050 3750
F 0 "v1" H 850 3850 60  0000 C CNN
F 1 "SINE" H 850 3700 60  0000 C CNN
F 2 "R1" H 750 3750 60  0000 C CNN
	1    1050 3750
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5174CE5E
P 1300 3200
F 0 "R1" V 1380 3200 50  0000 C CNN
F 1 "10000" V 1300 3200 50  0000 C CNN
	1    1300 3200
	0    1    1    0   
$EndComp
$EndSCHEMATC
