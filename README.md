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
