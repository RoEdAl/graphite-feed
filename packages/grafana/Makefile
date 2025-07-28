include $(TOPDIR)/rules.mk

PKG_NAME:=grafana
PKG_VERSION:=12.1.0
PKG_RELEASE:=1

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
PKG_HASH:=69923cf95824008a6a7529f242295ecc2bc6b1dc4e5142c889971e88407d8712
else ifeq ($(GRAFANA_BIN_TARGET),arm64)
PKG_HASH:=2f53c7a99a09c21088707dc3d933f4a4455c33e458a9e8df564485e3b7c7b6e7
else ifeq ($(GRAFANA_BIN_TARGET),armv6)
PKG_HASH:=3d930a2164625469f46a25fce0498aec3b8cea836350d75fd4c6be5df512c390
else ifeq ($(GRAFANA_BIN_TARGET),armv7)
PKG_HASH:=414673d3316c12e6ca0712d227d799475f6da4b522b0ce6f160f40084853fe20
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
