#!/bin/bash

# Removing
rm -rf out/soong out/host/linux-x86
rm -rf build/make
rm -rf device/asus
rm -rf kernel/asus
rm -rf vendor/asus
rm -rf frameworks/base

## cloning
git clone --depth=1 https://github.com/Tiktodz/android_frameworks_base frameworks/base
git clone --depth=1 https://github.com/texascake/crdroid_build build/make
git clone --depth=1 https://github.com/Tiktodz/device_asus_X00TD-4.19 device/asus/X00TD
git clone --depth=1 https://github.com/Tiktodz/device_asus_sdm660-common-4.19 device/asus/sdm660-common
git clone --depth=1 --recurse-submodules https://github.com/Tiktodz/android_kernel_asus_sdm660 -b wip --single-branch kernel/asus/sdm660
git clone --depth=1 https://github.com/Tiktodz/vendor_asus-4.19 vendor/asus

### Renaming
sed -i 's/CONFIG_LOCALVERSION=.*/CONFIG_LOCALVERSION="-TOMTzy-969"/g' kernel/asus/sdm660/arch/arm64/configs/asus/X00TD_defconfig
sed -i 's/dontaudit location_domain vendor_sysfs_soc_sensitive:file r_file_perms;/dontaudit location_domain sysfs_socinfo_sensitive:file r_file_perms;/g' device/lineage/sepolicy/qcom/vendor/location.te

#### signing
rm -rf vendor/lineage-priv/keys
mkdir -p vendor/lineage-priv/keys
cp -R lineage/scripts/lineage-priv-template/* vendor/lineage-priv/keys/
cd vendor/lineage-priv/keys
bash keys.sh
cd -

export BUILD_USERNAME=queen
export BUILD_HOSTNAME=$DISTRO
export TZ=Asia/Jakarta

#####hanaqueen#####
