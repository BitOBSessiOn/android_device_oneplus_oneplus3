#include <stdlib.h>

// These are paths to folders in /sys which contain "uevent" file
// need to init this device.
// MultiROM needs to init framebuffer, mmc blocks, input devices,
// some ADB-related stuff and USB drives, if OTG is supported
// You can use * at the end to init this folder and all its subfolders
const char *mr_init_devices[] =
{

    "/sys/class/graphics/fb0",
    "/sys/class/graphics/fb1",
    "/sys/devices/virtual/graphics/fb0",
    "/sys/devices/virtual/graphics/fb1",
    
    // boot and data
    "/sys/block/sde/sde18", //boot
    "/sys/block/sda/sda15", //data

    // system and cache
    "/sys/block/sde/sde20", //system
    "/sys/block/sda/sda3", //cache

    // Mount persist and firmware
    "/sys/block/sda/sda2", // persist
    "/sys/block/sde/sde11", // firmware
    "/sys/block/sde/sde12", // dsp 
    //"/sys/block/sde/sde23", // bt_firmware    
    
    "/sys/block/loop0/*",
    "/sys/devices/virtual/misc/fuse",
    "/sys/devices/virtual/misc/fuse/*",
    
    "/sys/fs/selinux",
    "/sys/kernel/debug/*",
    "/sys/fs/pstore",
    
    "/sys/fs/fuse/*",
    "/sys/module/fuse/*",
    "/sys/devices/virtual/misc/fuse",
    
    "/sys/bus/mmc/drivers/mmcblk",
    "/sys/module/mmc_core",
    "/sys/module/mmcblk",

    //"/sys/bus*",
    //"/sys/devices*",
    
    // Encryption
    "/sys/devices/virtual/misc/device-mapper",
    "/sys/devices/virtual/misc/ion",
    "/sys/devices/virtual/qseecom/qseecom",

    // Logging
    "/sys/devices/virtual/pmsg/*",

    //  OP3/3T -----
    
    "/sys/bus/mmc*",
    "/sys/bus/mmc/drivers/mmcblk",
    "/sys/bus/sdio/drivers",
    "/sys/module/sdhci",
    "/sys/module/sdhci*",
    "/sys/module/sdhci_msm",
    "/sys/module/sdhci_msm*",

    // for input
    "/sys/devices/virtual/input*",
    "/sys/devices/virtual/input/input0",
    "/sys/devices/virtual/misc/uinput",
    "/sys/devices/soc/soc:gpio_keys/input4*",
    "/sys/devices/soc/soc:gpio_keys/input0*",
    "/sys/bus/platform/devices/gpio_keys/input*"
    "/sys/devices/virtual/misc/uinput",
    "/sys/devices/virtual/misc/uinput/*",
    "/sys/devices/soc/75b6000.i2c/i2c-8/8-0020/input*",
    "/sys/devices/soc/75b6000.i2c/i2c-8/8-0020/input/input5*",
    "/sys/devices/soc/75b6000.i2c/i2c-8/8-0020/input/input6*",
    "/sys/devices/soc/7577000.i2c/i2c-3/3-0036/*",
    "/sys/devices/soc/75ba000.i2c/i2c-12/12-0020/input/input3*",
    "/sys/devices/soc/75ba000.i2c/i2c-12/12-0020/input/input4*",

    // for adb
    "/sys/class/tty/ptmx",
    "/sys/class/misc/android_adb",
    "/sys/class/android_usb/android0*",
    "/sys/class/android_usb/android0/f_adb",
    "/sys/bus/platform/drivers/android_usb",
    "/sys/bus/usb",

    // USB Drive
    "/sys/bus/platform/drivers/xhci-hcd*",
    "/sys/block/sda/sda1",


    // for qualcomm overlay - /dev/ion
    "/sys/devices/virtual/misc/ion",
    
    // Adding Wildcard for Debug And for Bringup
    //"/sys/*",

    NULL
};
