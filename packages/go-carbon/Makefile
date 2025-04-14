include $(TOPDIR)/rules.mk

PKG_NAME:=go-carbon
PKG_VERSION:=0.18.0
PKG_RELEASE:=3

PKG_MAINTAINER:=Edmunt Pienkowsky <roed@onet.eu>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE.md

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

GO_PKG:=github.com/go-graphite/go-carbon
GO_PKG_LDFLAGS_X:=main.BuildVersion=$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/go-carbon
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=Golang implementation of Graphite/Carbon server
	URL:=https://github.com/go-graphite/go-carbon
	DEPENDS:=$(GO_ARCH_DEPENDS)
	USERID:=carbon:carbon
endef

define Package/go-carbon/description
Golang implementation of Graphite/Carbon server with classic architecture: Agent -> Cache -> Persister
endef

define Build/Compile
	$(GO_GENERAL_BUILD_CONFIG_VARS) \
	$(GO_PKG_BUILD_CONFIG_VARS) \
	$(GO_PKG_VARS) \
	GOWORK=off \
	go install \
		$(GO_MOD_ARGS) \
		$(GO_PKG_INSTALL_ARGS) \
		$(GO_PKG)@v$(PKG_VERSION)
endef

define Build/Install
endef

define Build/InstallDev
endef

define Package/go-carbon/install
	$(call GoPackage/Package/Install/Bin,$(1))
	$(INSTALL_DIR) $(1)/etc/go-carbon
	$(INSTALL_DATA) files/go-carbon.conf $(1)/etc/go-carbon
	$(INSTALL_DATA) files/storage-schemas.conf $(1)/etc/go-carbon
	$(INSTALL_DATA) files/storage-aggregation.conf $(1)/etc/go-carbon
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/go-carbon.init $(1)/etc/init.d/go-carbon
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/go-carbon.config $(1)/etc/config/go-carbon
endef

define Package/go-carbon/conffiles
/etc/config/go-carbon
/etc/go-carbon/go-carbon.conf
/etc/go-carbon/storage-schemas.conf
/etc/go-carbon/storage-aggregation.conf
endef

$(eval $(call GoBinPackage,go-carbon))
$(eval $(call BuildPackage,go-carbon))
