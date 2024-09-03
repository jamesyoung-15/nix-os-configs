# Issue Faced
When trying to suspend my desktop (AMD CPU and GPU), it immediately wakes up. I suspect it is due to usb controller, this has been described in the Arch [wiki](https://wiki.archlinux.org/title/Power_management/Wakeup_triggers#Instantaneous_wakeups_from_suspend).

## Solution
The [Arch wiki](https://wiki.archlinux.org/title/Power_management/Wakeup_triggers#Instantaneous_wakeups_from_suspend) solution works.

Disable usb wakeup triggers
``` bash
sudo su # go into root mode
# turn off triggers
echo XHC0 > /proc/acpi/wakeup && echo XHC1 > /proc/acpi/wakeup && echo XHC2 > /proc/acpi/wakeup
exit
```

View wakeup triggers

``` bash
cat /proc/acpi/wakeup | grep enabled
```
