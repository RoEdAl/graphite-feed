include $(TOPDIR)/rules.mk

PKG_NAME:=telegraf-bin
PKG_VERSION:=1.36.1
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
PKG_HASH:=0c0ec522dbcbce3bf50d3e94484885b4ef8e875b3f7ab863d2c8e04b9f5a01fd
else ifeq ($(TELEGRAF_BIN_TARGET),arm64)
PKG_HASH:=9f003edee168944148abfbb7c4d1a154297e1fd45ce325137c6af4c3fba4ec53
else ifeq ($(TELEGRAF_BIN_TARGET),armel)
PKG_HASH:=4ad8d97951750f3f85667302f99427f18a9537df2e9bcb2fdbd22c2d7c588f2e
else ifeq ($(TELEGRAF_BIN_TARGET),armhf)
PKG_HASH:=964732550a6c116925c0e9e249c27b1166a55b0a9c786f20f5e106b470ec4c0d
else ifeq ($(TELEGRAF_BIN_TARGET),riscv64)
PKG_HASH:=fae8f62b85b2f3af50772f0b6b61fae685c7d7ef9fbca534b6a2318629a3793f
else ifeq ($(TELEGRAF_BIN_TARGET),mipsel)
PKG_HASH:=acdff827faf6d292b0b3d27c58d91b59cc94b9e4da7d930c4526620d89eb9ce7
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
