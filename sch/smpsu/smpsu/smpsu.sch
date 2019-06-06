EESchema Schematic File Version 4
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Regulator_Switching:LM2596S-3.3 U1
U 1 1 5CF7F6C0
P 2600 3900
F 0 "U1" H 2600 4267 50  0000 C CNN
F 1 "LM2596S-3.3" H 2600 4176 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:TO-263-5_TabPin3" H 2650 3650 50  0001 L CIN
F 3 "http://www.ti.com/lit/ds/symlink/lm2596.pdf" H 2600 3900 50  0001 C CNN
	1    2600 3900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5CF7FC96
P 2600 4550
F 0 "#PWR0101" H 2600 4300 50  0001 C CNN
F 1 "GND" H 2605 4377 50  0000 C CNN
F 2 "" H 2600 4550 50  0001 C CNN
F 3 "" H 2600 4550 50  0001 C CNN
	1    2600 4550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5CF7FCD0
P 2000 4150
F 0 "R1" H 2070 4196 50  0000 L CNN
F 1 "R" H 2070 4105 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 1930 4150 50  0001 C CNN
F 3 "~" H 2000 4150 50  0001 C CNN
	1    2000 4150
	1    0    0    -1  
$EndComp
$Comp
L Device:D_Schottky D1
U 1 1 5CF7FD79
P 3450 4150
F 0 "D1" V 3404 4229 50  0000 L CNN
F 1 "D_Schottky" V 3495 4229 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-220-2_Vertical" H 3450 4150 50  0001 C CNN
F 3 "~" H 3450 4150 50  0001 C CNN
	1    3450 4150
	0    1    1    0   
$EndComp
$Comp
L Device:L L1
U 1 1 5CF7FE01
P 4150 4000
F 0 "L1" V 3972 4000 50  0000 C CNN
F 1 "L" V 4063 4000 50  0000 C CNN
F 2 "Choke_Toroid_ThroughHole:Transformer_Toroid_horizontal_Diameter18mm" H 4150 4000 50  0001 C CNN
F 3 "~" H 4150 4000 50  0001 C CNN
	1    4150 4000
	0    1    1    0   
$EndComp
$Comp
L Device:C C2
U 1 1 5CF7FE5D
P 1700 3950
F 0 "C2" H 1815 3996 50  0000 L CNN
F 1 "C" H 1815 3905 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" H 1738 3800 50  0001 C CNN
F 3 "~" H 1700 3950 50  0001 C CNN
	1    1700 3950
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 5CF7FEBD
P 4450 4150
F 0 "C3" H 4565 4196 50  0000 L CNN
F 1 "C" H 4565 4105 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" H 4488 4000 50  0001 C CNN
F 3 "~" H 4450 4150 50  0001 C CNN
	1    4450 4150
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C1
U 1 1 5CF7FF7B
P 1350 3950
F 0 "C1" H 1468 3996 50  0000 L CNN
F 1 "CP" H 1468 3905 50  0000 L CNN
F 2 "" H 1388 3800 50  0001 C CNN
F 3 "~" H 1350 3950 50  0001 C CNN
	1    1350 3950
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C4
U 1 1 5CF7FFB7
P 4800 4150
F 0 "C4" H 4918 4196 50  0000 L CNN
F 1 "CP" H 4918 4105 50  0000 L CNN
F 2 "" H 4838 4000 50  0001 C CNN
F 3 "~" H 4800 4150 50  0001 C CNN
	1    4800 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 4300 2600 4300
Wire Wire Line
	2600 4200 2600 4300
Connection ~ 2600 4300
Wire Wire Line
	2600 4300 3450 4300
Wire Wire Line
	2600 4550 2600 4300
Wire Wire Line
	2100 4000 2000 4000
Wire Wire Line
	3100 4000 3450 4000
Wire Wire Line
	4450 4300 4800 4300
Connection ~ 4450 4300
Wire Wire Line
	4800 4000 4450 4000
Wire Wire Line
	4300 4000 4450 4000
Connection ~ 4450 4000
Wire Wire Line
	4000 4000 3450 4000
Connection ~ 3450 4000
Wire Wire Line
	3450 4300 4450 4300
Connection ~ 3450 4300
Wire Wire Line
	4450 4000 4450 3800
Wire Wire Line
	4450 3800 3100 3800
Wire Wire Line
	2100 3800 1700 3800
Wire Wire Line
	1700 3800 1350 3800
Connection ~ 1700 3800
$Comp
L power:GND #PWR0102
U 1 1 5CF80607
P 1550 4100
F 0 "#PWR0102" H 1550 3850 50  0001 C CNN
F 1 "GND" H 1555 3927 50  0000 C CNN
F 2 "" H 1550 4100 50  0001 C CNN
F 3 "" H 1550 4100 50  0001 C CNN
	1    1550 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 4100 1550 4100
Wire Wire Line
	1550 4100 1350 4100
Connection ~ 1550 4100
Wire Wire Line
	1700 4100 1700 4300
Wire Wire Line
	1700 4300 2000 4300
Connection ~ 1700 4100
Connection ~ 2000 4300
$EndSCHEMATC
