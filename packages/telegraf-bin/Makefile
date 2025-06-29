include $(TOPDIR)/rules.mk

PKG_NAME:=telegraf-bin
PKG_VERSION:=1.35.1
PKG_RELEASE:=1

undefine TELEGRAF_BIN_TARGET
undefine PKG_HASH

ifeq ($(ARCH),x86_64)
TELEGRAF_BIN_TARGET:=amd64
else ifeq ($(ARCH),arm)
ARM_TARGET_CORE:=$(word 1,$(subst +,$(space),$(call qstrip,$(CONFIG_CPU_TYPE))))
ifneq ($(filter $(ARM_TARGET_CORE),cortex-a7 cortex-a8 cortex-a9 cortex-a15),)
TELEGRAF_BIN_TARGET:=armhf
else
ARM_TARGET_FPU:=$(word 2,$(subst +,$(space),$(call qstrip,$(CONFIG_CPU_TYPE))))
ifeq ($(ARM_TARGET_FPU),)
TELEGRAF_BIN_TARGET:=armel
else ifneq ($(filter $(ARM_TARGET_FPU),vfp vfpv2),)
TELEGRAF_BIN_TARGET:=armel
else
TELEGRAF_BIN_TARGET:=armhf
endif
endif
else ifeq ($(ARCH),aarch64)
TELEGRAF_BIN_TARGET:=arm64
else ifeq ($(ARCH),riscv64)
TELEGRAF_BIN_TARGET:=riscv64
else ifeq ($(ARCH),mipsel)
TELEGRAF_BIN_TARGET:=mipsel
endif

ifeq ($(TELEGRAF_BIN_TARGET),amd64)
PKG_HASH:=20dacc6d3485fba297cabf262d25447c13cfd319a9f1f40737b5b96226d30c8a
else ifeq ($(TELEGRAF_BIN_TARGET),arm64)
PKG_HASH:=bdb21fb428fa89e0f29a96981a68548df897273f405bb6348fd8d5cb29c56c8a
else ifeq ($(TELEGRAF_BIN_TARGET),armel)
PKG_HASH:=98088efee0108158ff118765e05ac62c95d1dfe011f349a4e76ee1bf6374f40c
else ifeq ($(TELEGRAF_BIN_TARGET),armhf)
PKG_HASH:=2fac9a20b9c0360384c1bab1966773d3a2d93fe104ebc9316b1329eaf6fbf432
else ifeq ($(TELEGRAF_BIN_TARGET),riscv64)
PKG_HASH:=d37096fa27dd910eddd0b5b8df8f45ce090040ff4224932d52f7af9d6e1908d2
else ifeq ($(TELEGRAF_BIN_TARGET),mipsel)
PKG_HASH:=48e3cb4c7133997f0ce32b723d2db9708334f2d63ae3a6ad1139aa05b2eeefd4
else
PKG_HASH:=0000000000000000000000000000000000000000000000000000000000000000
endif

PKG_SOURCE_URL:=https://dl.influxdata.com/telegraf/releases
PKG_SOURCE:=telegraf-$(PKG_VERSION)_linux_$(TELEGRAF_BIN_TARGET).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/telegraf-$(PKG_VERSION)

PKG_MAINTAINER:=Edmunt Pienkowsky <roed@onet.eu>
PKG_LICENSE:=MIT

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/telegraf-bin
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=Agent for collecting, processing, aggregating, and writing metrics, logs, and other arbitrary data [$(TELEGRAF_BIN_TARGET)].
	URL:=https://influxdata.com/telegraf
	DEPENDS:=@(aarch64||arm||x86_64||riscv64||mipsel) +ca-bundle
	USERID:=telegraf:telegraf
	PROVIDES=telegraf
	VARIANT:=bin
	DEFAULT_VARIANT:=1
endef

define Package/telegraf-bin/description
Agent for collecting, processing, aggregating, and writing metrics, logs, and other arbitrary data [$(TELEGRAF_BIN_TARGET)].
endef

define Build/Configure
endef

define Build/Compile
endef

define Build/Install
endef

define Package/telegraf-bin/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/usr/bin/telegraf $(1)/usr/bin/telegraf

	$(INSTALL_DIR) $(1)/etc/telegraf/telegraf.d
	$(INSTALL_DATA) files/agent.conf $(1)/etc/telegraf/telegraf.d/
	$(INSTALL_DATA) files/stdout.conf $(1)/etc/telegraf/telegraf.d/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/telegraf.init $(1)/etc/init.d/telegraf
	
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/telegraf.config $(1)/etc/config/telegraf
endef

define Package/telegraf-bin/conffiles
/etc/config/telegraf
/etc/telegraf/telegraf.conf
/etc/telegraf/telegraf.d/agent.conf
/etc/telegraf/telegraf.d/stdout.conf
endef

$(eval $(call BuildPackage,telegraf-bin))
