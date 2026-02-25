#!/bin/bash

# Removing
rm -rf out/soong out/host/linux-x86
rm -rf build/make
rm -rf device/asus
rm -rf kernel/asus
rm -rf vendor/asus
rm -rf lineage/scripts
#rm -rf frameworks/base

## cloning
#git clone --depth=1 https://github.com/Tiktodz/android_frameworks_base frameworks/base
git clone --depth=1 https://github.com/Tiktodz/android_build build/make
git clone --depth=1 https://github.com/Tiktodz/device_asus_X00TD-4.19 device/asus/X00TD
git clone --depth=1 https://github.com/Tiktodz/device_asus_sdm660-common-4.19 device/asus/sdm660-common
git clone --depth=1 --recurse-submodules https://github.com/Tiktodz/android_kernel_asus_sdm660 --single-branch kernel/asus/sdm660
git clone --depth=1 https://github.com/Tiktodz/vendor_asus-4.19 vendor/asus
git clone --depth=1 https://github.com/Tiktodz/scripts lineage/scripts

### Renaming
sed -i 's/CONFIG_LOCALVERSION=.*/CONFIG_LOCALVERSION="-TOMTzy-969"/g' kernel/asus/sdm660/arch/arm64/configs/asus/X00TD_defconfig
#sed -i 's/dontaudit location_domain vendor_sysfs_soc_sensitive:file r_file_perms;/dontaudit location_domain sysfs_socinfo_sensitive:file r_file_perms;/g' device/lineage/sepolicy/qcom/vendor/location.te

#### signing
rm -rf vendor/lineage-priv/keys
rm -rf vendor/custom-priv/keys
mkdir -p vendor/custom-priv/keys
cp -R lineage/scripts/lineage-priv-template/* vendor/custom-priv/keys/
cd vendor/custom-priv/keys
bash keys.sh
cd -

export BUILD_USERNAME=queen
export BUILD_HOSTNAME=$(cat /etc/hostname)
export TZ=Asia/Jakarta

#####hanaqueen#####
