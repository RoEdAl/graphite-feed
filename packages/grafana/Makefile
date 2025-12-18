include $(TOPDIR)/rules.mk

PKG_NAME:=grafana
PKG_VERSION:=12.3.1
GRAFANA_TS:=20271043721
PKG_RELEASE:=1

undefine GRAFANA_BIN_TARGET
undefine PKG_HASH

ifeq ($(ARCH),x86_64)
GRAFANA_BIN_TARGET:=amd64
else ifeq ($(ARCH),arm)
ARM_TARGET_CORE:=$(word 1,$(subst +,$(space),$(call qstrip,$(CONFIG_CPU_TYPE))))
ifneq ($(filter $(ARM_TARGET_CORE),cortex-a7 cortex-a8 cortex-a9 cortex-a15),)
GRAFANA_BIN_TARGET:=arm-7
else
ARM_TARGET_FPU:=$(word 2,$(subst +,$(space),$(call qstrip,$(CONFIG_CPU_TYPE))))
ifeq ($(ARM_TARGET_FPU),)
GRAFANA_BIN_TARGET:=arm-5
else ifneq ($(filter $(ARM_TARGET_FPU),vfp vfpv2),)
GRAFANA_BIN_TARGET:=arm-6
else
GRAFANA_BIN_TARGET:=arm-7
endif
endif
else ifeq ($(ARCH),aarch64)
GRAFANA_BIN_TARGET:=arm64
endif

ifeq ($(GRAFANA_BIN_TARGET),amd64)
PKG_HASH:=75d03b5ac2dc7b009625869355225d73e5b29866efbd999479bdd24429a695db
else ifeq ($(GRAFANA_BIN_TARGET),arm64)
PKG_HASH:=889cac6634a365dacbc712e1e49ea2233d40b9c958e61266f39949537ce63cdd
else ifeq ($(GRAFANA_BIN_TARGET),arm-6)
PKG_HASH:=db94bcfbe9593693bee552dbbab241f109280b581a2489c4da3a681141e8e993
else ifeq ($(GRAFANA_BIN_TARGET),arm-7)
PKG_HASH:=8bdec666184fcb6ac3538ba1472df9e6c646aace58b1e6d435ebef7e19e4f62b
else
PKG_HASH:=0000000000000000000000000000000000000000000000000000000000000000
endif

PKG_SOURCE_URL:=https://dl.grafana.com/$(PKG_NAME)/release/$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION)_$(GRAFANA_TS)_linux_$(GRAFANA_BIN_TARGET).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

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
