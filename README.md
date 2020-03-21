# Lenovo-Y50-Hackintosh-OC
Y50-70 UHD/4K(1080P) OpenCore5.6 10.15

BIOS settings

To start, set BIOS to Windows 8 defaults.

Then insure:
- UEFI boot is enabled
- secure boot is disabled
- enable Legacy Boot (but UEFI first) and you may experience less boot time glitches

For the UHD model, the DVMT-prealloc BIOS setting must be changed to 128MB. One of two methods can be used:
- use a EFI shell to change the DVMT-prealloc from the shell.
- use a patched BIOS which unlocks the advanced menu

Also, be aware that hibernation (suspend to disk or S4 sleep) is not supported on hackintosh.

- sudo pmset -a hibernatemode 0
- sudo rm /var/vm/sleepimage
- sudo mkdir /var/vm/sleepimage

