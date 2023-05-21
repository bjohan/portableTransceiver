#!/usr/bin/python3
import sys
sys.path.append('lmx2594/py/')
import lmx2594cmd2
import time
class RfIfConverter:
    def __init__(self, port, fosc=100e6, mash_order=3, timeout=5):
        self.p = lmx2594cmd2.Lmx2594(port, fosc, mash_order, timeout, macro=False)
        self.state = None

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

    def setFrequency(self, f):
        self.p.setFrequency2(f)
        if(f > 6e9):
            self.setPathHigh()
        else:
            self.setPathLow()
        


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(prog="lmx2594.py", description="Program for controlling lmx2594 pll", epilog="Have fun!")
    parser.add_argument("port", help='For instance /dev/ttyUSB0')
    parser.add_argument('-f', '--frequency', help="Set frequency", type=float);
    parser.add_argument('-r', '--reference', help="Reference frequency", type=float);
    parser.add_argument('-mo', '--mash-order', help="Order of delta sigma", type=int);
    parser.add_argument('-d', '--down', help="Set transfer switch for down conversion", action='store_true')
    parser.add_argument('-u', '--up', help="Set transfer switch for ip conversion", action='store_true')
    args=parser.parse_args()

    reference=280e6;
    if args.reference:
        reference=args.reference

    mash_order = 3
    if args.mash_order:
        mash_order = args.mash_order
        if mash_order not in range(5):
            print("Mash order must be in range 0..4")

    d=RfIfConverter(args.port, fosc=reference, mash_order=mash_order)
    if args.down:
        d.setDownConvert()
    if args.up:
        d.setUpConvert()

    if args.frequency:
        #d.setFrequency(args.frequency)
        d.setFrequency(args.frequency)


