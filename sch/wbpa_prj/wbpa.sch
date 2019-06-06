<Qucs Schematic 0.0.18>
<Properties>
  <View=0,-49,1365,1031,1,0,0>
  <Grid=10,10,1>
  <DataSet=wbpa.dat>
  <DataDisplay=wbpa.dpl>
  <OpenDisplay=1>
  <Script=wbpa.m>
  <RunScript=0>
  <showFrame=0>
  <FrameText0=Title>
  <FrameText1=Drawn By:>
  <FrameText2=Date:>
  <FrameText3=Revision:>
</Properties>
<Symbol>
</Symbol>
<Components>
  <Pac P1 1 120 230 18 -26 0 1 "1" 1 "50 Ohm" 1 "0 dBm" 0 "1 GHz" 0 "26.85" 0>
  <GND * 1 120 280 0 0 0 0>
  <Eqn Eqn2 1 90 800 -23 14 0 0 "dBS21=dB(S[2,1])" 1 "yes" 0>
  <Eqn Eqn3 1 100 880 -23 14 0 0 "dBS12=dB(S[1,2])" 1 "yes" 0>
  <Eqn Eqn4 1 110 950 -23 14 0 0 "dBS22=dB(S[2,2])" 1 "yes" 0>
  <Eqn Eqn1 1 90 730 -23 14 0 0 "dBS11=dB(S[1,1])" 1 "yes" 0>
  <Eqn Eqn6 1 410 970 -23 14 0 0 "num=1-sqr(abs(S[1,1]))-sqr(abs(S[2,2]))+sqr(abs(D))" 1 "yes" 0>
  <Eqn Eqn8 1 400 840 -23 14 0 0 "K=num/divisor" 1 "yes" 0>
  <Eqn Eqn10 1 400 910 -23 14 0 0 "stab=min(K)" 1 "yes" 0>
  <Eqn Eqn5 1 400 770 -23 14 0 0 "D=S[1,1]*S[2,2]-S[1,2]*S[2,1]" 1 "yes" 0>
  <Eqn Eqn7 1 400 700 -23 14 0 0 "divisor=2*abs(S[2,1]*S[1,2])" 1 "yes" 0>
  <GND * 1 510 240 0 0 0 0>
  <L L5 1 510 180 10 -26 0 1 "L5" 1 "" 0>
  <C C6 1 630 150 -26 -45 0 2 "C6" 1 "" 0 "neutral" 0>
  <GND * 1 670 230 0 0 0 0>
  <GND * 1 840 200 0 0 0 0>
  <SPfile X1 1 840 150 -26 -49 0 0 "/home/bjohan/Downloads/cg2h40025_s_parameters_vds_28_v_idq_250_ma.s2p" 1 "rectangular" 0 "linear" 0 "open" 0 "2" 0>
  <TLIN Line1 1 910 150 -26 20 0 0 "LZ1" 1 "LL1" 1 "0 dB" 0 "26.85" 0>
  <TLIN Line2 1 760 150 -26 20 0 0 "LZ2" 1 "LL2" 1 "0 dB" 0 "26.85" 0>
  <C C7 1 670 180 17 -26 0 1 "C7" 1 "" 0 "neutral" 0>
  <GND * 1 710 400 0 0 0 0>
  <L L7 1 710 340 10 -26 0 1 "L7" 1 "" 0>
  <GND * 1 950 380 0 0 0 0>
  <L L8 1 950 320 10 -26 0 1 "L8" 1 "" 0>
  <R R3 1 710 260 15 -26 0 1 "R3" 1 "26.85" 0 "0.0" 0 "0.0" 0 "26.85" 0 "european" 0>
  <GND * 1 970 230 0 0 0 0>
  <C C3 1 970 180 17 -26 0 1 "C3" 1 "" 0 "neutral" 0>
  <Pac P2 1 1210 260 18 -26 0 1 "2" 1 "50 Ohm" 1 "0 dBm" 0 "1 GHz" 0 "26.85" 0>
  <GND * 1 1210 320 0 0 0 0>
  <C C4 1 1140 150 -26 17 0 0 "C4" 1 "" 0 "neutral" 0>
  <R R5 1 1070 150 -26 15 0 0 "R2" 1 "26.85" 0 "0.0" 0 "0.0" 0 "26.85" 0 "european" 0>
  <C C5 1 410 150 -26 -45 0 2 "C5" 1 "" 0 "neutral" 0>
  <Eqn Eqn9 1 700 660 -23 14 0 0 "gain=min(abs(S[2,1]), 0.1e9:3e9)" 1 "yes" 0>
  <Eqn Eqn11 1 700 750 -23 14 0 0 "gainMax=max(abs(S[2,1]), 0.1e9:3e9)" 1 "yes" 0>
  <R R1 1 560 150 -26 15 0 0 "R1" 1 "26.85" 0 "0.0" 0 "0.0" 0 "26.85" 0 "european" 0>
  <.Opt Opt1 1 340 0 0 40 0 0 "Sim=SP1" 0 "DE=3|500|2|200|0.85|1|3|1e-6|20|200" 0 "Var=L8|yes|7.759369E-08|1e-9|100e-9|LIN_DOUBLE" 0 "Var=L7|yes|6.587939E-08|1e-9|100e-9|LIN_DOUBLE" 0 "Var=LL2|yes|1.019210E-02|0|0.1|LIN_DOUBLE" 0 "Var=LZ2|yes|3.947197E+01|1|100|LIN_DOUBLE" 0 "Var=LZ1|yes|1.286612E+01|1|100|LIN_DOUBLE" 0 "Var=LL1|yes|2.898973E-02|0|0.1|LIN_DOUBLE" 0 "Var=C5|yes|3.321211E-11|1e-12|100e-12|LIN_DOUBLE" 0 "Var=C6|yes|2.868748E-11|1e-12|100e-12|LIN_DOUBLE" 0 "Var=C3|yes|2.391560E-11|1e-12|100e-12|LIN_DOUBLE" 0 "Var=C4|yes|6.364095E-11|1e-12|100e-12|LIN_DOUBLE" 0 "Var=R1|yes|1.719303E+02|0|200|LIN_DOUBLE" 0 "Var=R2|yes|1.693755E+00|0|2|LIN_DOUBLE" 0 "Var=L5|yes|6.710273E-08|1e-9|100e-9|LIN_DOUBLE" 0 "Var=C7|yes|8.511022E-12|1e-12|100e-12|LIN_DOUBLE" 0 "Var=R3|yes|9.632164E+01|0|200|LIN_DOUBLE" 0 "Goal=stab|GE|1.2" 0 "Goal=gain|GE|5" 0>
  <.SP SP1 1 90 -20 0 65 0 0 "lin" 1 "100 MHz" 1 "8 GHz" 1 "1000" 1 "no" 0 "1" 0 "2" 0 "no" 0 "no" 0>
</Components>
<Wires>
  <120 260 120 280 "" 0 0 0 "">
  <510 210 510 240 "" 0 0 0 "">
  <660 150 670 150 "" 0 0 0 "">
  <940 150 950 150 "" 0 0 0 "">
  <840 180 840 200 "" 0 0 0 "">
  <870 150 880 150 "" 0 0 0 "">
  <790 150 810 150 "" 0 0 0 "">
  <670 210 670 230 "" 0 0 0 "">
  <710 370 710 400 "" 0 0 0 "">
  <670 150 710 150 "" 0 0 0 "">
  <710 150 730 150 "" 0 0 0 "">
  <710 150 710 230 "" 0 0 0 "">
  <710 290 710 310 "" 0 0 0 "">
  <950 150 950 290 "" 0 0 0 "">
  <950 350 950 380 "" 0 0 0 "">
  <970 210 970 230 "" 0 0 0 "">
  <950 150 970 150 "" 0 0 0 "">
  <1210 290 1210 320 "" 0 0 0 "">
  <1210 150 1210 230 "" 0 0 0 "">
  <1170 150 1210 150 "" 0 0 0 "">
  <1100 150 1110 150 "" 0 0 0 "">
  <970 150 1040 150 "" 0 0 0 "">
  <120 150 120 200 "" 0 0 0 "">
  <440 150 510 150 "" 0 0 0 "">
  <120 150 380 150 "" 0 0 0 "">
  <590 150 600 150 "" 0 0 0 "">
  <510 150 530 150 "" 0 0 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
</Paintings>
