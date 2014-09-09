EESchema Schematic File Version 2  date Monday 13 May 2013 12:59:04 PM IST
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
LIBS:example_2.4-cache
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
L PWR_FLAG #FLG01
U 1 1 51909635
P 5200 4200
F 0 "#FLG01" H 5200 4470 30  0001 C CNN
F 1 "PWR_FLAG" H 5200 4430 30  0000 C CNN
	1    5200 4200
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U1
U 1 1 5190961B
P 5700 2550
F 0 "U1" H 5550 2650 50  0000 C CNN
F 1 "VPLOT8_1" H 5850 2650 50  0000 C CNN
	1    5700 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 2850 5700 2850
Wire Wire Line
	5700 3600 5700 3700
Connection ~ 5200 4200
Wire Wire Line
	5200 4200 5200 4750
Connection ~ 5700 2850
Wire Wire Line
	5700 2850 5700 3200
Wire Wire Line
	4200 3200 4200 2850
Wire Wire Line
	4200 2850 4650 2850
Wire Wire Line
	4200 4100 4200 4200
Wire Wire Line
	4200 4200 5700 4200
$Comp
L IPLOT U2
U 1 1 5167D5E8
P 5700 3950
F 0 "U2" H 5550 4050 50  0000 C CNN
F 1 "IPLOT" H 5850 4050 50  0000 C CNN
	1    5700 3950
	0    1    1    0   
$EndComp
$Comp
L GND #PWR02
U 1 1 5166ABF9
P 5200 4750
F 0 "#PWR02" H 5200 4750 30  0001 C CNN
F 1 "GND" H 5200 4680 30  0001 C CNN
	1    5200 4750
	1    0    0    -1  
$EndComp
$Comp
L DIODE D1
U 1 1 5166A924
P 5700 3400
F 0 "D1" H 5700 3500 40  0000 C CNN
F 1 "DIODE" H 5700 3300 40  0000 C CNN
	1    5700 3400
	0    1    1    0   
$EndComp
$Comp
L R R1
U 1 1 5166A8EF
P 4900 2850
F 0 "R1" V 4980 2850 50  0000 C CNN
F 1 "1000" V 4900 2850 50  0000 C CNN
	1    4900 2850
	0    -1   -1   0   
$EndComp
$Comp
L DC v1
U 1 1 5166A8CD
P 4200 3650
F 0 "v1" H 4000 3750 60  0000 C CNN
F 1 "5V" H 4000 3600 60  0000 C CNN
F 2 "R1" H 3900 3650 60  0000 C CNN
	1    4200 3650
	1    0    0    -1  
$EndComp
$EndSCHEMATC
