{ config, pkgs, ... }:

{

  ###### implementation

  config = {

    jobAttrs.lvm =
      { startOn = " udev"; # !!! or on new-devices

        script =
          ''
            # Load the device mapper.
            ${config.system.sbin.modprobe}/sbin/modprobe dm_mod || true

            ${pkgs.devicemapper}/sbin/dmsetup mknodes
            # Scan for block devices that might contain LVM physical volumes
            # and volume groups.
            ${pkgs.lvm2}/sbin/vgscan --mknodes

            # Make all logical volumes on all volume groups available, i.e.,
            # make them appear in /dev.
            ${pkgs.lvm2}/sbin/vgchange --available y

            initctl emit new-devices
          '';

        task = true;
      };

  };
  
}
