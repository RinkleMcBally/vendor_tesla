PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/tesla/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/tesla/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/tesla/prebuilt/common/bin/50-slim.sh:system/addon.d/50-slim.sh \
    vendor/tesla/prebuilt/common/bin/99-backup.sh:system/addon.d/99-backup.sh \
    vendor/tesla/prebuilt/common/etc/backup.conf:system/etc/backup.conf

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/tesla/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# tesla-specific init file
PRODUCT_COPY_FILES += \
    vendor/tesla/prebuilt/common/etc/init.local.rc:root/init.slim.rc

# Copy latinime for gesture typing
PRODUCT_COPY_FILES += \
    vendor/tesla/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/tesla/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/tesla/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/tesla/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

PRODUCT_COPY_FILES += \
    vendor/tesla/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/tesla/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/tesla/prebuilt/common/bin/sysinit:system/bin/sysinit

# Embed SuperUser
SUPERUSER_EMBEDDED := true

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    SpareParts \
    Superuser \
    su

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# Extra Optional packages
PRODUCT_PACKAGES += \
    SlimLauncher \
    LatinIME \
    BluetoothExt \
    DashClock

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libstagefright_soft_ffmpegadec \
    libstagefright_soft_ffmpegvdec \
    libFFmpegExtractor \
    libnamparser

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/tesla/overlay/common

# Bootanimation support
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/bootanimation.zip:system/media/bootanimation.zip

# SuperSU
PRODUCT_COPY_FILES += \
    vendor/tesla/prebuilt/common/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
    vendor/tesla/prebuilt/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

# Kernel Auditor
PRODUCT_COPY_FILES += \
    vendor/tesla/prebuilt/apps/tesla_auditor.apk:system/app/Auditor/Auditor.apk

# Versioning System
# teslaLP first version.
PRODUCT_VERSION_MAJOR = 5.1.1
PRODUCT_VERSION_MINOR = alpha
PRODUCT_VERSION_MAINTENANCE = 1.0
ifdef TESLA_BUILD_EXTRA
    TESLA_POSTFIX := -$(TESLA_BUILD_EXTRA)
endif
ifndef TESLA_BUILD_TYPE
    TESLA_BUILD_TYPE := UNOFFICIAL
    PLATFORM_VERSION_CODENAME := UNOFFICIAL
    TESLA_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
endif

# Set all versions
TESLA_VERSION := Tesla-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(TESLA_BUILD_TYPE)$(TESLA_POSTFIX)
TESLA_MOD_VERSION := Tesla-$(TESLA_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(TESLA_BUILD_TYPE)$(TESLA_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    tesla.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.tesla.version=$(TESLA_VERSION) \
    ro.modversion=$(TESLA_MOD_VERSION) \
    ro.tesla.buildtype=$(TESLA_BUILD_TYPE)

EXTENDED_POST_PROCESS_PROPS := vendor/tesla/tools/slim_process_props.py

# Squisher Location
SQUISHER_SCRIPT := vendor/tesla/tools/squisher
