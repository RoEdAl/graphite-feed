include $(TOPDIR)/rules.mk

PKG_NAME:=carbonapi
PKG_VERSION:=0.17.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/go-graphite/carbonapi/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=f99ef3d1f1844cab470e255f31efee20792748b66fc9e4bb4a3bb2e648d623e4

PKG_MAINTAINER:=Edmunt Pienkowsky <roed@onet.eu>
PKG_LICENSE:=BSD-2
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

GO_PKG:=github.com/go-graphite/carbonapi/cmd/carbonapi
GO_PKG_BUILD_PKG:=github.com/go-graphite/carbonapi/cmd/carbonapi
GO_PKG_LDFLAGS_X:=main.BuildVersion=$(PKG_VERSION)
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

define Build/Install
endef

define Package/carbonapi/install
	$(call GoPackage/Package/Install/Bin,$(1))
	$(INSTALL_DIR) $(1)/etc/carbonapi
	$(INSTALL_DATA) files/carbonapi.yaml $(1)/etc/carbonapi
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/carbonapi.init $(1)/etc/init.d/carbonapi
endef

define Package/carbonapi/conffiles
/etc/carbonapi/carbonapi.yaml
/etc/carbonapi/
endef

$(eval $(call GoBinPackage,carbonapi))
$(eval $(call BuildPackage,carbonapi))
