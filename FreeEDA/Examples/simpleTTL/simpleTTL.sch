EESchema Schematic File Version 2  date Tuesday 02 April 2013 03:01:00 PM IST
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
LIBS:simpleTTL-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "2 apr 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 5550 3450
Wire Wire Line
	5550 3300 5550 3600
Wire Wire Line
	2950 4600 5550 4600
Connection ~ 4500 4600
Wire Wire Line
	4500 4300 4500 4600
Wire Wire Line
	3700 4600 3700 4450
Connection ~ 2950 4600
Wire Wire Line
	2950 3350 4150 3350
Wire Wire Line
	2950 4250 2950 4800
Wire Wire Line
	3700 3550 4150 3550
Connection ~ 3700 4600
Wire Wire Line
	4550 2900 4550 3250
Wire Wire Line
	3450 3350 3450 3250
Connection ~ 3450 3350
Wire Wire Line
	5550 3450 5350 3450
Wire Wire Line
	5550 4600 5550 4100
$Comp
L VPLOT8_1 U2
U 2 1 50CEBA04
P 5550 3000
F 0 "U2" H 5400 3100 50  0000 C CNN
F 1 "VPLOT8_1" H 5700 3100 50  0000 C CNN
	2    5550 3000
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U2
U 1 1 50CEBA01
P 3450 2950
F 0 "U2" H 3300 3050 50  0000 C CNN
F 1 "VPLOT8_1" H 3600 3050 50  0000 C CNN
	1    3450 2950
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG01
U 1 1 50862FAD
P 4550 2900
F 0 "#FLG01" H 4550 3170 30  0001 C CNN
F 1 "PWR_FLAG" H 4550 3130 30  0000 C CNN
	1    4550 2900
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG02
U 1 1 50862FA6
P 4500 4300
F 0 "#FLG02" H 4500 4570 30  0001 C CNN
F 1 "PWR_FLAG" H 4500 4530 30  0000 C CNN
	1    4500 4300
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 50862F73
P 5550 3850
F 0 "R1" V 5630 3850 50  0000 C CNN
F 1 "1000" V 5550 3850 50  0000 C CNN
	1    5550 3850
	1    0    0    -1  
$EndComp
$Comp
L PULSE v1
U 1 1 50862F55
P 2950 3800
F 0 "v1" H 2750 3900 60  0000 C CNN
F 1 "PULSE" H 2750 3750 60  0000 C CNN
F 2 "R1" H 2650 3800 60  0000 C CNN
	1    2950 3800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 50862CF3
P 2950 4800
F 0 "#PWR03" H 2950 4800 30  0001 C CNN
F 1 "GND" H 2950 4730 30  0001 C CNN
	1    2950 4800
	1    0    0    -1  
$EndComp
$Comp
L DC v2
U 1 1 50862BA3
P 3700 4000
F 0 "v2" H 3500 4100 60  0000 C CNN
F 1 "5" H 3500 3950 60  0000 C CNN
F 2 "R1" H 3400 4000 60  0000 C CNN
	1    3700 4000
	1    0    0    -1  
$EndComp
$Comp
L 7400 U1
U 3 1 50862B5B
P 4750 3450
F 0 "U1" H 4750 3500 60  0000 C CNN
F 1 "7400" H 4750 3350 60  0000 C CNN
	3    4750 3450
	1    0    0    -1  
$EndComp
$EndSCHEMATC
