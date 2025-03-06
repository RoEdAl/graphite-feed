include $(TOPDIR)/rules.mk

PKG_NAME:=carbon-relay-ng
PKG_VERSION:=1.5.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/grafana/carbon-relay-ng/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=06d87ec1e53e5a85f8ed55b0d68df24e184f4b901eb2c1e618af47aedc7cbd74

PKG_MAINTAINER:=Edmunt Pienkowsky <roed@onet.eu>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

GO_PKG:=github.com/grafana/carbon-relay-ng/cmd/carbon-relay-ng
GO_PKG_BUILD_PKG:=github.com/grafana/carbon-relay-ng/cmd/carbon-relay-ng
GO_PKG_LDFLAGS_X:=main.Version=$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/carbon-relay-ng
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=Fast carbon relay+aggregator
	URL:=https://github.com/grafana/carbon-relay-ng
	DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
	USERID:=carbon-relay:carbon-relay
endef

define Package/carbon-relay-ng/description
Fast carbon relay+aggregator with admin interfaces for making changes online - production ready
endef

define Build/Configure
	$(GO_GENERAL_BUILD_CONFIG_VARS) \
	$(GO_PKG_BUILD_CONFIG_VARS) \
	$(SHELL) files/mod-tweaks.sh
	$(call GoPackage/Build/Configure)
endef

define Build/Install
endef

define Package/carbon-relay-ng/install
	$(call GoPackage/Package/Install/Bin,$(1))
	$(INSTALL_DIR) $(1)/etc/carbon-relay-ng
	$(INSTALL_DATA) files/carbon-relay-ng.conf $(1)/etc/carbon-relay-ng/carbon-relay-ng.conf
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/carbon-relay-ng.init $(1)/etc/init.d/carbon-relay-ng
	$(INSTALL_DIR) $(1)/var/spool/carbon-relay-ng
endef

define Package/carbon-relay-ng/conffiles
/etc/go-carbon/carbon-relay-ng/carbon-relay-ng.yaml
/etc/go-carbon/carbon-relay-ng/
/var/spool/carbon-relay-ng/
endef

define Package/carbon-relay-ng/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
  chown -R carbon-relay:carbon-relay /var/spool/carbon-relay-ng
fi
exit 0
endef


$(eval $(call GoBinPackage,carbon-relay-ng))
$(eval $(call BuildPackage,carbon-relay-ng))
