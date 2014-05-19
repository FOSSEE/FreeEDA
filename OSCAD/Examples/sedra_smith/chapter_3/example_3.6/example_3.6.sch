EESchema Schematic File Version 2  date Tuesday 16 April 2013 10:43:17 AM IST
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
LIBS:example_3.6-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "16 apr 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 5650 3950
$Comp
L PWR_FLAG #FLG01
U 1 1 516CDDBE
P 5650 3950
F 0 "#FLG01" H 5650 4220 30  0001 C CNN
F 1 "PWR_FLAG" H 5650 4180 30  0000 C CNN
	1    5650 3950
	0    -1   -1   0   
$EndComp
Connection ~ 5650 3850
Connection ~ 5700 5350
Wire Wire Line
	5650 4700 5650 5350
Wire Wire Line
	5650 3850 5650 4200
Wire Wire Line
	6350 4200 6350 5350
Wire Wire Line
	6350 3300 6350 2150
Connection ~ 5950 4100
Connection ~ 5950 3450
Connection ~ 5950 5450
Wire Wire Line
	5950 5350 5950 5600
Connection ~ 5950 5350
Wire Wire Line
	6350 5350 5650 5350
Wire Wire Line
	5950 4200 5950 4050
Wire Wire Line
	6350 2150 5950 2150
Wire Wire Line
	5950 3300 5950 3650
Wire Wire Line
	5950 2800 5950 2650
Wire Wire Line
	5950 4700 5950 4850
$Comp
L IPLOT U4
U 1 1 516CDCFB
P 5650 4450
F 0 "U4" H 5500 4550 50  0000 C CNN
F 1 "IPLOT" H 5800 4550 50  0000 C CNN
	1    5650 4450
	0    -1   -1   0   
$EndComp
$Comp
L IPLOT U3
U 1 1 516C0D28
P 5950 4450
F 0 "U3" H 5800 4550 50  0000 C CNN
F 1 "IPLOT" H 6100 4550 50  0000 C CNN
	1    5950 4450
	0    -1   -1   0   
$EndComp
$Comp
L IPLOT U2
U 1 1 516C0CED
P 5950 3050
F 0 "U2" H 5800 3150 50  0000 C CNN
F 1 "IPLOT" H 6100 3150 50  0000 C CNN
	1    5950 3050
	0    -1   -1   0   
$EndComp
$Comp
L VPLOT8_1 U1
U 2 1 5166CA3C
P 5650 4100
F 0 "U1" H 5500 4200 50  0000 C CNN
F 1 "VPLOT8_1" H 5800 4200 50  0000 C CNN
	2    5650 4100
	0    -1   -1   0   
$EndComp
$Comp
L VPLOT8_1 U1
U 1 1 5166C9F3
P 5650 3450
F 0 "U1" H 5500 3550 50  0000 C CNN
F 1 "VPLOT8_1" H 5800 3550 50  0000 C CNN
	1    5650 3450
	0    -1   -1   0   
$EndComp
$Comp
L PWR_FLAG #FLG02
U 1 1 5166C8C4
P 5700 5350
F 0 "#FLG02" H 5700 5445 30  0001 C CNN
F 1 "PWR_FLAG" H 5700 5530 30  0000 C CNN
	1    5700 5350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 5166C87D
P 5950 5600
F 0 "#PWR03" H 5950 5600 30  0001 C CNN
F 1 "GND" H 5950 5530 30  0001 C CNN
	1    5950 5600
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5166C822
P 5950 2400
F 0 "R1" V 6030 2400 50  0000 C CNN
F 1 "4700" V 5950 2400 50  0000 C CNN
	1    5950 2400
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 5166C7EC
P 5950 5100
F 0 "R2" V 6030 5100 50  0000 C CNN
F 1 "3300" V 5950 5100 50  0000 C CNN
	1    5950 5100
	1    0    0    -1  
$EndComp
$Comp
L DC v1
U 1 1 5166C79C
P 6350 3750
F 0 "v1" H 6150 3850 60  0000 C CNN
F 1 "10V" H 6150 3700 60  0000 C CNN
F 2 "R1" H 6050 3750 60  0000 C CNN
	1    6350 3750
	1    0    0    -1  
$EndComp
$Comp
L NPN Q1
U 1 1 5166C72A
P 5850 3850
F 0 "Q1" H 5850 3700 50  0000 R CNN
F 1 "NPN" H 5850 4000 50  0000 R CNN
	1    5850 3850
	1    0    0    -1  
$EndComp
$EndSCHEMATC
