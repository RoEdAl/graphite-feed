include $(TOPDIR)/rules.mk

PKG_NAME:=telegraf-bin
PKG_VERSION:=1.36.3
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
PKG_HASH:=9b723764456638f5c6f2a9e0c9381a6867feb0ce70049a10a0215d5b60e33b59
else ifeq ($(TELEGRAF_BIN_TARGET),arm64)
PKG_HASH:=0b5bce3b27fe5e4f0eb665b9f9946815043a28c3e628670597da314ef694d87d
else ifeq ($(TELEGRAF_BIN_TARGET),armel)
PKG_HASH:=9afdfb20594c85d5d79c4b0400192038496853037bcfdceab3599377beb01c8e
else ifeq ($(TELEGRAF_BIN_TARGET),armhf)
PKG_HASH:=348bd0022db6387c7f1039284b34b52812a67735eed616e734ee4c94ed09b724
else ifeq ($(TELEGRAF_BIN_TARGET),riscv64)
PKG_HASH:=aa6437c9943dfdccc8ed37b5a91afd23ae4d38b077a758fb4d8a7f4c371fe7ab
else ifeq ($(TELEGRAF_BIN_TARGET),mipsel)
PKG_HASH:=3035e46d8c14e669b4e9c58545a313ce9d9503f85cb9d3b5fc3699d230e7211b
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
