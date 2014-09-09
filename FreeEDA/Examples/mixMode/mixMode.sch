EESchema Schematic File Version 2  date Monday 17 December 2012 11:41:04 AM IST
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
LIBS:mixMode-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "17 dec 2012"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L VPLOT8_1 U1
U 2 1 50CEB729
P 7150 2900
F 0 "U1" H 7000 3000 50  0000 C CNN
F 1 "VPLOT8_1" H 7300 3000 50  0000 C CNN
	2    7150 2900
	1    0    0    -1  
$EndComp
$Comp
L VPLOT8_1 U1
U 1 1 50CEB722
P 5600 2950
F 0 "U1" H 5450 3050 50  0000 C CNN
F 1 "VPLOT8_1" H 5750 3050 50  0000 C CNN
	1    5600 2950
	1    0    0    -1  
$EndComp
Connection ~ 5750 4400
Wire Wire Line
	5750 4400 5750 4300
Connection ~ 7150 3350
Wire Wire Line
	7150 3350 7150 3200
Wire Wire Line
	5950 3350 4800 3350
Wire Wire Line
	7350 4000 7350 4400
Wire Wire Line
	7350 4400 4800 4400
Connection ~ 5600 3350
Wire Wire Line
	5600 3250 5600 3350
Wire Wire Line
	5350 3350 5350 3650
Wire Wire Line
	4800 4550 4800 4250
Connection ~ 4800 4400
Connection ~ 5350 3350
Wire Wire Line
	6850 3350 7350 3350
Wire Wire Line
	7350 3350 7350 3500
Wire Wire Line
	6350 3000 6350 3250
Wire Wire Line
	5350 4400 5350 4150
Connection ~ 5350 4400
$Comp
L PWR_FLAG #FLG01
U 1 1 50653022
P 6350 3000
F 0 "#FLG01" H 6350 3270 30  0001 C CNN
F 1 "PWR_FLAG" H 6350 3230 30  0000 C CNN
	1    6350 3000
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 50652FB6
P 7350 3750
F 0 "R2" V 7430 3750 50  0000 C CNN
F 1 "1000" V 7350 3750 50  0000 C CNN
	1    7350 3750
	1    0    0    -1  
$EndComp
$Comp
L 74HC04 U2
U 1 1 505FDE5C
P 6400 3350
F 0 "U2" H 6550 3450 40  0000 C CNN
F 1 "74HC04" H 6600 3250 40  0000 C CNN
	1    6400 3350
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG02
U 1 1 505CA177
P 5750 4300
F 0 "#FLG02" H 5750 4570 30  0001 C CNN
F 1 "PWR_FLAG" H 5750 4530 30  0000 C CNN
	1    5750 4300
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 505C9F25
P 5350 3900
F 0 "R1" V 5430 3900 50  0000 C CNN
F 1 "1000" V 5350 3900 50  0000 C CNN
	1    5350 3900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 505C9EE8
P 4800 4550
F 0 "#PWR03" H 4800 4550 30  0001 C CNN
F 1 "GND" H 4800 4480 30  0001 C CNN
	1    4800 4550
	1    0    0    -1  
$EndComp
$Comp
L PULSE v1
U 1 1 505C9ECF
P 4800 3800
F 0 "v1" H 4600 3900 60  0000 C CNN
F 1 "PULSE" H 4600 3750 60  0000 C CNN
	1    4800 3800
	1    0    0    -1  
$EndComp
$EndSCHEMATC
