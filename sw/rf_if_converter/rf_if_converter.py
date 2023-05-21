#!/usr/bin/python3
import sys
import scipy.io as sio
sys.path.append('lmx2594/py/')
import lmx2594cmd2
import time
import numpy as np

class RfIfConverter:
    def __init__(self, port, fosc=100e6, mash_order=3, timeout=5, levelMapFile=None):
        self.p = lmx2594cmd2.Lmx2594(port, fosc, mash_order, timeout, macro=False)
        self.state = None
        if levelMapFile is not None:
            levelData = sio.loadmat(levelMapFile) 
            self.fa = np.squeeze(levelData['fs']) #Frequency axis
            self.po = np.squeeze(levelData['po']) #Power output
            self.ps = np.squeeze(levelData['ps']) #Power settings

    def toggleRelay(self, v):
        if self.state != v:
            self.p.query(b'g %d'%(v))
            time.sleep(0.05)
            self.p.query(b'g 0')
            self.state = v

    def setPathLow(self):
        self.toggleRelay(2)

    def setPathHigh(self):
        self.toggleRelay(3)

    def setUpConvert(self):
        self.toggleRelay(4)

    def setDownConvert(self):
        self.toggleRelay(8)


    def setLevel(self, f, l):
        if f < np.min(self.fa) or f > np.max(self.fa):
            self.p.setPower(0)
            return
        bfi = np.argmin(np.abs(self.fa-f))
        #print("Used frequency", f, "mapped frequency", self.fa[bfi])
        powers_avail = self.po[:,bfi]
        bpi = np.argmin(np.abs(powers_avail-l))
        #print("requested power", l, "mapped power", powers_avail[bpi])
        powerSetting = self.ps[bpi]
        #print("Setting level to", l, "at frequency", f, "Hz")
        self.p.setPower(powerSetting)

    def setFrequency(self, f, l = None):
        self.p.setFrequency2(f)
        if(f > 6e9):
            self.setPathHigh()
        else:
            self.setPathLow()

        if l is not None:
            self.setLevel(f, l)
        else:
            self.p.setPower(0) 
        


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(prog="lmx2594.py", description="Program for controlling lmx2594 pll based frequency converter", epilog="Have fun!")
    parser.add_argument("port", help='For instance /dev/ttyUSB0')
    parser.add_argument('-f', '--frequency', help="Set frequency", type=float);
    parser.add_argument('-r', '--reference', help="Reference frequency", type=float);
    parser.add_argument('-mo', '--mash-order', help="Order of delta sigma", type=int);
    parser.add_argument('-d', '--down', help="Set transfer switch for down conversion", action='store_true')
    parser.add_argument('-u', '--up', help="Set transfer switch for ip conversion", action='store_true')
    parser.add_argument('-mf', '--map-file', help="File containing power map");
    parser.add_argument('-l', '--level', help="Using map from --map-file set power level to this value", type=float)
    args=parser.parse_args()

    reference=280e6;
    if args.reference:
        reference=args.reference

    mash_order = 3
    if args.mash_order:
        mash_order = args.mash_order
        if mash_order not in range(5):
            print("Mash order must be in range 0..4")

    d=RfIfConverter(args.port, fosc=reference, mash_order=mash_order, levelMapFile=args.map_file,)
    if args.down:
        d.setDownConvert()
    if args.up:
        d.setUpConvert()

    if args.frequency:
        #d.setFrequency(args.frequency)
        d.setFrequency(args.frequency, args.level)


