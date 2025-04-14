include $(TOPDIR)/rules.mk

PKG_NAME:=grafana
PKG_VERSION:=11.6.0
PKG_RELEASE:=4

undefine GRAFANA_BIN_TARGET
undefine PKG_HASH

ifeq ($(ARCH),x86_64)
GRAFANA_BIN_TARGET:=amd64
else ifeq ($(ARCH),arm)
ARM_TARGET_CORE:=$(word 1,$(subst +,$(space),$(call qstrip,$(CONFIG_CPU_TYPE))))
ifneq ($(filter $(ARM_TARGET_CORE),cortex-a7 cortex-a8 cortex-a9 cortex-a15),)
GRAFANA_BIN_TARGET:=armv7
else
ARM_TARGET_FPU:=$(word 2,$(subst +,$(space),$(call qstrip,$(CONFIG_CPU_TYPE))))
ifeq ($(ARM_TARGET_FPU),)
GRAFANA_BIN_TARGET:=armv5
else ifneq ($(filter $(ARM_TARGET_FPU),vfp vfpv2),)
GRAFANA_BIN_TARGET:=armv6
else
GRAFANA_BIN_TARGET:=armv7
endif
endif
else ifeq ($(ARCH),aarch64)
GRAFANA_BIN_TARGET:=arm64
endif

ifeq ($(GRAFANA_BIN_TARGET),amd64)
PKG_HASH:=043fa7b8c634ff060a70e2d069d0beee9300e5b259d8125c456d6b8cae35169f
else ifeq ($(GRAFANA_BIN_TARGET),arm64)
PKG_HASH:=bb0ce9f61e972e1a9ddfd5d6d4aea417894b7ceddbe60bab7024b2b641b5eae7
else ifeq ($(GRAFANA_BIN_TARGET),armv6)
PKG_HASH:=fec94aae0d1ede5257572907799f8e32b1724efa09d7b9cce727f00bb98d00db
else ifeq ($(GRAFANA_BIN_TARGET),armv7)
PKG_HASH:=6e9d447938a79ff496b348a31a708782ab5beba140f4ef9c6106977913a168e5
else
PKG_HASH:=0000000000000000000000000000000000000000000000000000000000000000
endif

PKG_SOURCE_URL:=https://dl.grafana.com/oss/release/
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).linux-$(GRAFANA_BIN_TARGET).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-v$(PKG_VERSION)

PKG_MAINTAINER:=Edmunt Pienkowsky <roed@onet.eu>
PKG_LICENSE:=AGPL-3.0
PKG_LICENSE_FILES:=LICENSE

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/grafana-bin
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=The open-source platform for monitoring and observability [$(GRAFANA_BIN_TARGET)]
	URL:=https://grafana.com
	DEPENDS:=@(aarch64||arm||x86_64) +ca-bundle
	USERID:=grafana:grafana
	PROVIDES:=$(PKG_NAME)
	VARIANT:=bin
	DEFAULT_VARIANT:=1
endef

define Package/grafana-bin/description
The open and composable observability and data visualization platform [$(GRAFANA_BIN_TARGET)].
Visualize metrics, logs, and traces from multiple sources like Prometheus, Loki, Elasticsearch, InfluxDB, Postgres and many more.
endef

define Build/Configure
endef

define Build/Compile
endef

define Build/Install
endef

define Package/grafana-bin/install
	$(INSTALL_DIR) $(1)/usr/share/grafana

	$(INSTALL_DATA) $(PKG_BUILD_DIR)/LICENSE $(1)/usr/share/grafana
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/NOTICE.md $(1)/usr/share/grafana
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/README.md $(1)/usr/share/grafana
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/VERSION $(1)/usr/share/grafana

	$(INSTALL_DIR) $(1)/usr/share/grafana/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/grafana $(1)/usr/share/grafana/bin/grafana

	$(CP) $(PKG_BUILD_DIR)/conf $(1)/usr/share/grafana
	$(CP) $(PKG_BUILD_DIR)/docs $(1)/usr/share/grafana
	$(CP) $(PKG_BUILD_DIR)/npm-artifacts $(1)/usr/share/grafana
	$(CP) $(PKG_BUILD_DIR)/packaging $(1)/usr/share/grafana
	$(CP) $(PKG_BUILD_DIR)/plugins-bundled $(1)/usr/share/grafana
	$(CP) $(PKG_BUILD_DIR)/public $(1)/usr/share/grafana
	$(CP) $(PKG_BUILD_DIR)/tools $(1)/usr/share/grafana

	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) files/grafana-server $(1)/usr/sbin
	$(INSTALL_BIN) files/grafana-cli $(1)/usr/sbin

	$(INSTALL_DIR) $(1)/etc/grafana
	$(INSTALL_DATA) files/grafana.ini $(1)/etc/grafana
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/grafana.init $(1)/etc/init.d/grafana
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/grafana.config $(1)/etc/config/grafana
endef

define Package/grafana-bin/conffiles
/etc/config/grafana
/etc/grafana/grafana.ini
endef

$(eval $(call BuildPackage,grafana-bin))
