# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file is the build configuration for a full Android
# build for grouper hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#
-include vendor/oneplus/oneplus3/BoardConfigVendor.mk

BOARD_PATH := device/oneplus/oneplus3

TARGET_NO_BOOTLOADER := true
TARGET_OTA_ASSERT_DEVICE := OnePlus3,oneplus3,OnePlus3T,oneplus3t
TARGET_BOOTLOADER_BOARD_NAME := msm8996

# Platform
TARGET_BOARD_PLATFORM := msm8996
TARGET_BOARD_PLATFORM_GPU := qcom-adreno530

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

TARGET_USE_QCOM_BIONIC_OPTIMIZATION := true
TARGET_USES_64_BIT_BINDER := true

ENABLE_CPUSETS := true

# Kernel
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 cma=32M@0-0xffffffff
#BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.selinux=enforcing user_debug=31 msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 cma=32M@0-0xffffffff androidboot.bootdevice=624000.ufshc
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x02000000
BOARD_RAMDISK_OFFSET     := 0x02200000
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_KERNEL_APPEND_DTB := true
TARGET_KERNEL_SOURCE := kernel/oneplus/msm8996
TARGET_KERNEL_CONFIG := omni_oneplus3_defconfig

#TARGET_PREBUILT_KERNEL := $(BOARD_PATH)/Image.gz-dtb

# partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3154116608
BOARD_USERDATAIMAGE_PARTITION_SIZE := 57436708864
BOARD_FLASH_BLOCK_SIZE := 262144

# global
TARGET_SPECIFIC_HEADER_PATH := $(BOARD_PATH)/include
BOARD_USES_QCOM_HARDWARE := true
TARGET_USES_QCOM_BSP := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Disable secure discard because it's SLOW
BOARD_SUPPRESS_SECURE_ERASE := true

# charger
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_DISABLE_INIT_BLANK := true

# power hal
TARGET_PROVIDES_POWERHAL := true

# libinit
TARGET_UNIFIED_DEVICE := true
TARGET_INIT_VENDOR_LIB := libinit_oneplus3

# liblights
TARGET_PROVIDES_LIBLIGHT := true

# Increase coldboot timeout
TARGET_INCREASES_COLDBOOT_TIMEOUT := true

# Recovery:Start
TARGET_RECOVERY_FSTAB := $(BOARD_PATH)/configs/fstab.qcom
TW_THEME := portrait_hdpi
BOARD_HAS_NO_REAL_SDCARD := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_DEFAULT_LANGUAGE := en-US
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_CRYPTO := true

#TWRP Extra params
#RECOVERY_SDCARD_ON_DATA := true
#BOARD_HAS_NO_SELECT_BUTTON := true
#TARGET_RECOVERY_PIXEL_FORMAT := "RGBA_8888"
#TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/module/g_android/parameters/file"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 100
#TW_SCREEN_BLANK_ON_BOOT := true
TW_MTP_DEVICE := "/dev/mtp_usb"
#TW_NO_EXFAT_FUSE := true
#BOARD_SUPPRESS_EMMC_WIPE := true
#TW_UNMOUNT_FIRMWARE_ON_BOOT := true
#TWHAVE_SELINUX := true
TW_INPUT_BLACKLIST := "hbtp_vm"

# MR config. MultiROM also uses parts of TWRP config
TARGET_RECOVERY_IS_MULTIROM := true
MR_NO_KEXEC := enabled
MR_CONTINUOUS_FB_UPDATE := true
MR_DPI := xhdpi
MR_DPI_FONT := 340
MR_USE_MROM_FSTAB := true
MR_FSTAB := $(BOARD_PATH)/multirom/mrom.fstab
MR_INPUT_TYPE := type_b
MR_INIT_DEVICES := $(BOARD_PATH)/multirom/mr_init_devices.c
MR_KEXEC_MEM_MIN := 0xac000000
MR_KEXEC_DTB := true
MR_DEVICE_HOOKS := $(BOARD_PATH)/multirom/mr_hooks.c
MR_DEVICE_HOOKS_VER := 4
MR_DEVICE_VARIANTS := OnePlus3 oneplus3 OnePlus3T oneplus3t
MR_USE_QCOM_OVERLAY := true
MR_QCOM_OVERLAY_HEADER := $(BOARD_PATH)/multirom/mr_qcom_overlay.h
MR_QCOM_OVERLAY_CUSTOM_PIXEL_FORMAT := MDP_RGBX_8888
# bootmenu
DEVICE_RESOLUTION := 1080x1920
MR_PIXEL_FORMAT := "RGBA_8888"
RECOVERY_GRAPHICS_USE_LINELENGTH := true
#MR_DEVICE_BOOTDEVICE := /dev/block/sde18
MR_DEV_BLOCK_BOOTDEVICE := true
#MR_DEVICE_SPECIFIC_VERSION := BitO
#MR_ENCRYPTION := true
#MR_ENCRYPTION_SETUP_SCRIPT := $(BOARD_PATH)/multirom/mr_cp_crypto.sh

#Force populating /dev/block/platform/msm_sdcc.1/by-name
#from the emmc
MR_POPULATE_BY_NAME_PATH := "/dev/block/platform/msm_sdcc.1/by-name"
# "/dev/block/bootdevice/by-name"
# "/dev/block/platform/soc/624000.ufshc/by-name"

# Versioning
TW_DEVICE_VERSION := 1

include $(BOARD_PATH)/multirom/version/MR_REC_VERSION.mk

ifeq ($(MR_REC_VERSION),)
MR_REC_VERSION := $(shell date -u +%Y%m%d)-01
endif

BOARD_MKBOOTIMG_ARGS += --board mrom$(MR_REC_VERSION)
