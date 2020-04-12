// Instead of providing patched DSDT/SSDT, just include a single SSDT
// and do the rest of the work in config.plist

// A bit experimental, and a bit more difficult with laptops, but
// still possible.

// Note: No solution for missing IAOE here, but so far, not a problem.

DefinitionBlock("", "SSDT", 2, "hack", "_HACK", 0)
{
    External(_SB.PCI0, DeviceObj)

//
// For disabling the discrete GPU
//

//    External(_SB.PCI0.PEG0.PEGP._OFF, MethodObj)
//    Device(RMD2)
//    {
//        Name(_HID, "RMD20000")
//        Method(_INI)
//        {
//            If (_OSI ("Darwin"))
//            {
//                // disable discrete graphics (Nvidia/Radeon) if it is present
//                If (CondRefOf(\_SB.PCI0.PEG0.PEGP._OFF)) { \_SB.PCI0.PEG0.PEGP._OFF() }
//            }
//        }
//    }

//
// Standard Injections/Fixes
//

    Scope(_SB.PCI0)
    {
        Device(IMEI)
        {
            Name (_ADR, 0x00160000)
        }
    }
    
    

//
// Keyboard/Trackpad FN+Up OR FN+Down 

    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(TPDF, FieldUnitObj)

    Scope(_SB.PCI0.LPCB.EC0)
    {
        // The native _Qxx methods in DSDT are renamed XQxx,
        // so notifications from the EC driver will land here.

        // _Q11 called on brightness down key
        Method(_Q11)
        {
            If (_OSI ("Darwin"))
            {
                // Brightness Down
                If (LNotEqual(TPDF,0x08))
                {
                    // Synaptics/ALPS
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
                }
                Else
                {
                    // Other(ELAN)
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
                }
            }
        }
        //_Q12 called on brightness up key
        Method(_Q12)
        {
            If (_OSI ("Darwin"))
            {
                // Brightness Up
                If (LNotEqual(TPDF,0x08))
                {
                    // Synaptics/ALPS
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
                }
                Else
                {
                    // Other(ELAN)
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x10)
                }
            }
        }
    }
}
//EOF
