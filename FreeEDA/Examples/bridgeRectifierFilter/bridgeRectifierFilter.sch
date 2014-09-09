EESchema Schematic File Version 2  date Sunday 09 December 2012 03:22:19 PM IST
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
LIBS:bridgeRectifierFilter-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "9 dec 2012"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	4400 2650 4500 2650
Wire Wire Line
	5850 2900 5850 2850
Wire Wire Line
	3700 2950 3700 2650
Connection ~ 5350 4100
Wire Wire Line
	5350 4100 5350 3900
Connection ~ 5850 2900
Connection ~ 5650 2900
Wire Wire Line
	6200 3300 6200 2900
Wire Wire Line
	6200 2900 4250 2900
Connection ~ 3700 2950
Connection ~ 4250 3400
Wire Wire Line
	4250 3400 3850 3400
Wire Wire Line
	3850 3400 3850 2950
Wire Wire Line
	3850 2950 3400 2950
Wire Wire Line
	3400 2950 3400 3000
Connection ~ 4850 2900
Wire Wire Line
	5650 2900 5650 3300
Wire Wire Line
	4250 3700 4250 3300
Wire Wire Line
	4850 3700 4850 3300
Wire Wire Line
	5650 4100 5650 3800
Connection ~ 4850 4100
Wire Wire Line
	3400 3900 3400 4000
Wire Wire Line
	3400 4000 3850 4000
Wire Wire Line
	3850 4000 3850 3600
Wire Wire Line
	3850 3600 4850 3600
Connection ~ 4850 3600
Connection ~ 4500 3600
Wire Wire Line
	4250 4100 6200 4100
Wire Wire Line
	6200 4100 6200 3700
Connection ~ 5650 4100
Connection ~ 5200 4100
Wire Wire Line
	5200 4100 5200 4200
Wire Wire Line
	4500 2650 4500 3600
Wire Wire Line
	3700 2650 3800 2650
Text Notes 3750 4400 0    80   Italic 0
Bridge Rectifier with Capacitor Filter
$Comp
L PWR_FLAG #FLG01
U 1 1 50852DDA
P 5350 3900
F 0 "#FLG01" H 5350 4170 30  0001 C CNN
F 1 "PWR_FLAG" H 5350 4130 30  0000 C CNN
	1    5350 3900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 5070FDD5
P 5200 4200
F 0 "#PWR02" H 5200 4200 30  0001 C CNN
F 1 "GND" H 5200 4130 30  0001 C CNN
	1    5200 4200
	1    0    0    -1  
$EndComp
$Comp
L VPLOT1 U2
U 1 1 5070F9F8
P 5850 2550
F 0 "U2" H 5700 2650 50  0000 C CNN
F 1 "VPLOT1" H 6000 2650 50  0000 C CNN
	1    5850 2550
	1    0    0    -1  
$EndComp
$Comp
L VPLOT U1
U 1 1 5070F9E6
P 4100 2650
F 0 "U1" H 3950 2750 50  0000 C CNN
F 1 "VPLOT" H 4250 2750 50  0000 C CNN
	1    4100 2650
	1    0    0    -1  
$EndComp
$Comp
L SINE V1
U 1 1 5070F9A6
P 3400 3450
F 0 "V1" H 3200 3550 60  0000 C CNN
F 1 "SINE" H 3200 3400 60  0000 C CNN
F 2 "R1" H 3100 3450 60  0000 C CNN
	1    3400 3450
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 5070F977
P 6200 3500
F 0 "C1" H 6250 3600 50  0000 L CNN
F 1 "1e-06" H 6250 3400 50  0000 L CNN
	1    6200 3500
	1    0    0    -1  
$EndComp
$Comp
L DIODE D4
U 1 1 5070F878
P 4850 3900
F 0 "D4" H 4850 4000 40  0000 C CNN
F 1 "1n4007" H 4850 3800 40  0000 C CNN
	1    4850 3900
	0    -1   -1   0   
$EndComp
$Comp
L DIODE D2
U 1 1 5070F85B
P 4850 3100
F 0 "D2" H 4850 3200 40  0000 C CNN
F 1 "1n4007" H 4850 3000 40  0000 C CNN
	1    4850 3100
	0    -1   -1   0   
$EndComp
$Comp
L DIODE D3
U 1 1 5070F84B
P 4250 3900
F 0 "D3" H 4250 4000 40  0000 C CNN
F 1 "1n4007" H 4250 3800 40  0000 C CNN
	1    4250 3900
	0    -1   -1   0   
$EndComp
$Comp
L DIODE D1
U 1 1 5070F83D
P 4250 3100
F 0 "D1" H 4250 3200 40  0000 C CNN
F 1 "1n4007" H 4250 3000 40  0000 C CNN
	1    4250 3100
	0    -1   -1   0   
$EndComp
$Comp
L R R1
U 1 1 5070F82C
P 5650 3550
F 0 "R1" V 5730 3550 50  0000 C CNN
F 1 "100000" V 5650 3550 50  0000 C CNN
	1    5650 3550
	1    0    0    -1  
$EndComp
$EndSCHEMATC
