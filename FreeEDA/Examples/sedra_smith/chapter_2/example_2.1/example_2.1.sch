EESchema Schematic File Version 2  date Tuesday 14 May 2013 11:52:16 AM IST
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
LIBS:example_2.1-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "14 may 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 5750 5050
Wire Wire Line
	5550 3150 5650 3150
Wire Wire Line
	5050 4550 5050 5050
Wire Wire Line
	6500 4900 6500 5050
Wire Wire Line
	6050 3150 6500 3150
Wire Wire Line
	5750 5050 5750 5800
Connection ~ 5750 5550
Connection ~ 6500 3150
Wire Wire Line
	6500 3150 6500 3350
Wire Wire Line
	6500 3850 6500 4000
Wire Wire Line
	5050 3150 5050 3650
Wire Wire Line
	6500 5050 5050 5050
$Comp
L DC v2
U 1 1 516BA020
P 6500 4450
F 0 "v2" H 6300 4550 60  0000 C CNN
F 1 "DC" H 6300 4400 60  0000 C CNN
F 2 "R1" H 6200 4450 60  0000 C CNN
	1    6500 4450
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG01
U 1 1 5167CC3A
P 5750 5550
F 0 "#FLG01" H 5750 5645 30  0001 C CNN
F 1 "PWR_FLAG" H 5750 5730 30  0000 C CNN
	1    5750 5550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 5167CC15
P 5750 5800
F 0 "#PWR02" H 5750 5800 30  0001 C CNN
F 1 "GND" H 5750 5730 30  0001 C CNN
	1    5750 5800
	1    0    0    -1  
$EndComp
$Comp
L IPLOT U1
U 1 1 5166A34A
P 6500 3600
F 0 "U1" H 6350 3700 50  0000 C CNN
F 1 "IPLOT" H 6650 3700 50  0000 C CNN
	1    6500 3600
	0    1    1    0   
$EndComp
$Comp
L DIODE D1
U 1 1 5166A210
P 5850 3150
F 0 "D1" H 5850 3250 40  0000 C CNN
F 1 "DIODE" H 5850 3050 40  0000 C CNN
	1    5850 3150
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5166A1EB
P 5300 3150
F 0 "R1" V 5380 3150 50  0000 C CNN
F 1 "100" V 5300 3150 50  0000 C CNN
	1    5300 3150
	0    -1   -1   0   
$EndComp
$Comp
L SINE v1
U 1 1 5166A1AC
P 5050 4100
F 0 "v1" H 4850 4200 60  0000 C CNN
F 1 "SINE" H 4850 4050 60  0000 C CNN
F 2 "R1" H 4750 4100 60  0000 C CNN
	1    5050 4100
	1    0    0    -1  
$EndComp
$EndSCHEMATC
