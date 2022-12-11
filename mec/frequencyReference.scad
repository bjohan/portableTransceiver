use <lmxpllframe.scad>
use </home/bjohan/git_wd/portableTransceiver/mec/transferSwitchAndMixerAssembly.scad>


module referenceBox(){
    hull(){
        roundedBlock([113, 61, 4], 5);
        roundedBlock([111, 59.5, 31], 5);
    }
}


module referenceAssembly(){
    referenceBox();
}

referenceAssembly();