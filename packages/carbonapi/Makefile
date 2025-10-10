include $(TOPDIR)/rules.mk

PKG_NAME:=carbonapi
PKG_VERSION:=0.18.2
PKG_RELEASE:=1

PKG_MAINTAINER:=Edmunt Pienkowsky <roed@onet.eu>
PKG_LICENSE:=BSD-2

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

GO_PKG:=github.com/go-graphite/carbonapi
GO_PKG_LDFLAGS_X:=main.BuildVersion=$(PKG_VERSION)
GO_PKG_TAGS:=timetzdata
# GO_PKG_TAGS=cairo

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/carbonapi
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=Golang implementation of Graphite API
	URL:=https://github.com/go-graphite/carbonapi
	DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
	USERID:=graphite:graphite
endef

define Package/carbonapi/description
Implementation of graphite API (graphite-web) in golang
endef

define Build/Compile
	$(GO_GENERAL_BUILD_CONFIG_VARS) \
	$(GO_PKG_BUILD_CONFIG_VARS) \
	$(GO_PKG_VARS) \
	GOWORK=off \
	go install \
		$(GO_MOD_ARGS) \
		$(GO_PKG_INSTALL_ARGS) \
		$(GO_PKG)/cmd/carbonapi@v$(PKG_VERSION)
endef

define Build/Install
endef

define Build/InstallDev
endef

define Package/carbonapi/install
	$(call GoPackage/Package/Install/Bin,$(1))
	$(INSTALL_DIR) $(1)/etc/carbonapi
	$(INSTALL_DATA) files/carbonapi.yaml $(1)/etc/carbonapi
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/carbonapi.init $(1)/etc/init.d/carbonapi
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/carbonapi.config $(1)/etc/config/carbonapi
endef

define Package/carbonapi/conffiles
/etc/config/carbonapi
/etc/carbonapi/carbonapi.yaml
endef

$(eval $(call GoBinPackage,carbonapi))
$(eval $(call BuildPackage,carbonapi))
