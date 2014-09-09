EESchema Schematic File Version 2  date Tuesday 21 May 2013 11:07:18 AM IST
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
LIBS:example_2.5-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "21 may 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Notes 6650 2050 0    90   Italic 18
Vd
Text Notes 6450 3850 0    90   Italic 18
Id
$Comp
L DC v1
U 1 1 5191FF90
P 5000 3850
F 0 "v1" H 4800 3950 60  0000 C CNN
F 1 "DC" H 4800 3800 60  0000 C CNN
F 2 "R1" H 4700 3850 60  0000 C CNN
	1    5000 3850
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG01
U 1 1 5190978A
P 6250 5300
F 0 "#FLG01" H 6250 5570 30  0001 C CNN
F 1 "PWR_FLAG" H 6250 5530 30  0000 C CNN
	1    6250 5300
	1    0    0    -1  
$EndComp
Connection ~ 6600 2100
$Comp
L VPLOT8_1 U1
U 1 1 51909775
P 6600 1800
F 0 "U1" H 6450 1900 50  0000 C CNN
F 1 "VPLOT8_1" H 6750 1900 50  0000 C CNN
	1    6600 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6250 5300 5000 5300
Wire Wire Line
	6250 3300 6250 3350
Wire Wire Line
	6250 4850 6250 5500
Wire Wire Line
	6250 2350 6250 2100
Connection ~ 6250 5300
Connection ~ 6250 2100
Wire Wire Line
	5250 2100 5000 2100
Wire Wire Line
	5750 2100 6600 2100
Connection ~ 6250 5300
Wire Wire Line
	6250 2750 6250 2800
Wire Wire Line
	5000 2100 5000 3400
Wire Wire Line
	6250 4250 6250 4350
Wire Wire Line
	5000 5300 5000 4300
$Comp
L IPLOT U2
U 1 1 519096FE
P 6250 4600
F 0 "U2" H 6100 4700 50  0000 C CNN
F 1 "IPLOT" H 6400 4700 50  0000 C CNN
	1    6250 4600
	0    1    1    0   
$EndComp
$Comp
L R Rd
U 1 1 519096A6
P 6250 3050
F 0 "Rd" V 6330 3050 50  0000 C CNN
F 1 "20m" V 6250 3050 50  0000 C CNN
	1    6250 3050
	1    0    0    -1  
$EndComp
$Comp
L DC v2
U 1 1 5190969F
P 6250 3800
F 0 "v2" H 6050 3900 60  0000 C CNN
F 1 "65m" H 6050 3750 60  0000 C CNN
F 2 "R1" H 5950 3800 60  0000 C CNN
	1    6250 3800
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 516A928C
P 5500 2100
F 0 "R1" V 5580 2100 50  0000 C CNN
F 1 "1000" V 5500 2100 50  0000 C CNN
	1    5500 2100
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR02
U 1 1 5166AFB9
P 6250 5500
F 0 "#PWR02" H 6250 5500 30  0001 C CNN
F 1 "GND" H 6250 5430 30  0001 C CNN
	1    6250 5500
	1    0    0    -1  
$EndComp
$Comp
L DIODE D1
U 1 1 5166AF28
P 6250 2550
F 0 "D1" H 6250 2650 40  0000 C CNN
F 1 "DIODE" H 6250 2450 40  0000 C CNN
	1    6250 2550
	0    1    1    0   
$EndComp
$EndSCHEMATC
