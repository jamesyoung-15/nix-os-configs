# Config Notes

Currently all dumped into one large config file.
  
Config file assumes have mounted drive and will be auto-mounted. Eg:

``` bash

fileSystems."/home/jamesyoung/Extra-Storage-01" = {
    device = "/dev/disk/by-label/JamesStorage";
    fsType = "ext4";
    options = [ "nofail" ];
  };

```

