# XFCE Display Profiles for LightDM

This script "exports" all XFCE Display Profiles to be used outside of XFCE e.g. with LightDM

usage:
```
./xfconf_to_xrandr.sh > lightdm-display-setup-script.sh
chmod a+x lightdm-display-setup-script.sh
```

you can also just test by calling the generated script then:
```
./lightdm-display-setup-script.sh
```

Then you can use this script as LightDM "display-setup-script"
see https://github.com/Canonical/lightdm/blob/master/data/lightdm.conf

# Quick & dirty
If you set your config in `/etc/lightdm/lightdm.conf` to something like
```
[Seat:seat*]
display-setup-script = /etc/lightdm/lightdm.conf.d/xrandr.sh
```

You can also directly update with
```
./xfconf_to_xrandr.sh |sudo tee /etc/lightdm/lightdm.conf.d/xrandr.sh >/dev/null
sudo chmod a+rx /etc/lightdm/lightdm.conf.d/xrandr.sh
```

and test with
```
/etc/lightdm/lightdm.conf.d/xrandr.sh
```
