include $(TOPDIR)/rules.mk

PKG_NAME:=telegraf-bin
PKG_VERSION:=1.34.2
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
PKG_HASH:=c790bee87caa91344df79f777592a3b34e8140c4ad2c2d8c451b61b981161c9b
else ifeq ($(TELEGRAF_BIN_TARGET),arm64)
PKG_HASH:=f28e29b6eb741c95c375c369d864d9a526c4668e5bb3810b148aec58c0a96ec6
else ifeq ($(TELEGRAF_BIN_TARGET),armel)
PKG_HASH:=c20dd0759c0ae6f4b6f9f2bdc5eb31d65115986a4910494b62fdb122a6e76663
else ifeq ($(TELEGRAF_BIN_TARGET),armhf)
PKG_HASH:=f50ce2d511bb9a17e4e1cf8bfe2a60bfbc9118c53408cad9b2dd15351471e9f3
else ifeq ($(TELEGRAF_BIN_TARGET),riscv64)
PKG_HASH:=9fd923ae5c27c6fbbba2ddc2aca91db0fa495cb7ef2e1d8f135d802eee1a1775
else ifeq ($(TELEGRAF_BIN_TARGET),mipsel)
PKG_HASH:=9ca38789722452d1481fd6ed42bfe36fc4d84427d96564583e23838555d67f18
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
