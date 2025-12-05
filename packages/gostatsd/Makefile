include $(TOPDIR)/rules.mk

PKG_NAME:=gostatsd
PKG_VERSION:=41.0.3
PKG_RELEASE:=1

PKG_MAINTAINER:=Edmunt Pienkowsky <roed@onet.eu>
PKG_LICENSE:=MIT

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

PKG_HASH:=d3c8304ae722070a86ea2abd4577a72d514d72b7
PKG_UNIX_EPOCH:=1756797130

GO_PKG:=github.com/atlassian/gostatsd
GO_PKG_TAGS:=timetzdata
GO_PKG_LDFLAGS_X:=\
	main.Version=$(PKG_VERSION) \
	main.GitCommit=$(PKG_HASH) \
	main.BuildDate=$(shell date --utc --date=@$(PKG_UNIX_EPOCH) +%Y-%m-%d-%H:%M)

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

define Build/Compile
	$(GO_GENERAL_BUILD_CONFIG_VARS) \
	$(GO_PKG_BUILD_CONFIG_VARS) \
	$(GO_PKG_VARS) \
	GOWORK=off \
	go install \
		$(GO_MOD_ARGS) \
		$(GO_PKG_INSTALL_ARGS) \
		$(GO_PKG)/cmd/gostatsd@$(PKG_VERSION)
endef

define Build/Install
endef

define Build/InstallDev
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
