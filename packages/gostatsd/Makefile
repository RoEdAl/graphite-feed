include $(TOPDIR)/rules.mk

PKG_NAME:=gostatsd
PKG_VERSION:=40.0.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/atlassian/gostatsd/tar.gz/$(PKG_VERSION)?
PKG_HASH:=505bbcbd7961c037b2fb11b54282f8b3232b48e0d739980b3279f2510167ad50

PKG_MAINTAINER:=Edmunt Pienkowsky <roed@onet.eu>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

GO_PKG:=github.com/atlassian/gostatsd/cmd/gostatsd
GO_PKG_BUILD_PKG:=github.com/atlassian/gostatsd/cmd/gostatsd
GO_PKG_LDFLAGS_X:=\
	main.Version=$(PKG_VERSION) \
	main.GitCommit=$(PKG_HASH) \
	main.BuildDate=$(shell date --utc --date=@$(SOURCE_DATE_EPOCH) +%Y-%m-%d-%H:%M)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/gostatsd
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=An implementation of Etsy's statsd in Go with tags support
	URL:=https://github.com/atlassian/gostatsd
	DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
	USERID:=statsd:statsd
endef

define Package/gostatsd/description
An implementation of Etsy's statsd in Go, based on original code from https://github.com/kisielk/gostatsd.
endef

define Build/Install
endef

define Package/gostatsd/install
	$(call GoPackage/Package/Install/Bin,$(1))
	$(INSTALL_DIR) $(1)/etc/gostatsd
	$(INSTALL_DATA) files/gostatsd.toml $(1)/etc/gostatsd
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/gostatsd.init $(1)/etc/init.d/gostatsd
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/gostatsd.config $(1)/etc/config/gostatsd
endef

define Package/gostatsd/conffiles
/etc/config/gostatsd
/etc/gostatsd/gostatsd.toml
endef

$(eval $(call GoBinPackage,gostatsd))
$(eval $(call BuildPackage,gostatsd))
