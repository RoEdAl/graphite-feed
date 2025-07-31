include $(TOPDIR)/rules.mk

PKG_NAME:=telegraf-bin
PKG_VERSION:=1.35.3
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
PKG_HASH:=f753a3c6eb89251c84bf74bcfc11a85a33c134500a073640932cd2abe4653332
else ifeq ($(TELEGRAF_BIN_TARGET),arm64)
PKG_HASH:=46db98dac55f07adfa8b2433ad51e7cdde981266066c904d5640b65e28fecf2a
else ifeq ($(TELEGRAF_BIN_TARGET),armel)
PKG_HASH:=e99fcbc4ab7776cc92cf36cfee59b9fa498e00a088f04864b7890e2029e0dea2
else ifeq ($(TELEGRAF_BIN_TARGET),armhf)
PKG_HASH:=cb678fa3995fa44c0cb95ee2334c0e7e5e81a7af2e83c94864d5d362438d2c93
else ifeq ($(TELEGRAF_BIN_TARGET),riscv64)
PKG_HASH:=44cb775ca38b20541e99abdeba93d1379645089a245f8d369ee92cbb7c172e77
else ifeq ($(TELEGRAF_BIN_TARGET),mipsel)
PKG_HASH:=57bc0490a9d0e87552f72c46db803582f0e32216e696ac0599f6a2c2b869288b
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
