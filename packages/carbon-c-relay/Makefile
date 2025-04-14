#
# carbon-c-relay
# Based on Makefile taken from https://github.com/j0ju/openwrt-local-packages
#
# Three variants:
#   carbon-c-relay-full  +SSL +PCRE2 +LZ4 +GZIP
#   carbon-c-relay-nossl -SSL +PCRE2 -LZ4 +GZIP
#   carbon-c-relay-tiny  -SSL -PCRE2 -LZ4 -GZIP

include $(TOPDIR)/rules.mk

PKG_NAME:=carbon-c-relay
PKG_VERSION:=3.8.1
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/grobian/carbon-c-relay/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=c6a10775cba22ecb6137a816e403f090a59e8b5213f9f0daa14f137775da4f20

PKG_MAINTAINER:=Edmunt Pienkowsky <roed@onet.eu>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE.md

PKG_FIXUP:=autoreconf
PKG_BUILD_DEPENDS+=zlib liblz4 pcre2 openssl
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/carbon-c-relay/default
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=Enhanced implementation of Carbon relay
	DEPENDS:=+libpthread
	URL:=https://github.com/grobian/carbon-c-relay
	USERID:=carbon-relay:carbon-relay
	PROVIDES:=$(PKG_NAME)
endef

define Package/carbon-c-relay/default/description
Enhanced C implementation of Carbon relay, aggregator and rewriter
endef

define Package/carbon-c-relay-full
	$(Package/carbon-c-relay/default)
	TITLE += (with SSL and libz4 support)
	DEPENDS += +zlib +liblz4 +libopenssl +ca-bundle +libpcre2
	VARIANT:=full
endef

define Package/carbon-c-relay-full/description
	$(Package/carbon-c-relay/default/description)
endef

define Package/carbon-c-relay-nossl
	$(Package/carbon-c-relay/default)
	TITLE += (without SSL support)
	DEPENDS += +zlib +libpcre2
	VARIANT:=nossl
endef

define Package/carbon-c-relay-nossl/description
	$(Package/carbon-c-relay/default/description)
endef

define Package/carbon-c-relay-tiny
	$(Package/carbon-c-relay/default)
	TITLE += (without SSL and PCRE2 support)
	VARIANT:=tiny
	DEFAULT_VARIANT:=1
endef

define Package/carbon-c-relay-tiny/description
	$(Package/carbon-c-relay/default/description)
endef

ifeq ($(BUILD_VARIANT),full)
	CONFIGURE_ARGS += --with-ssl --with-pcre2 --without-pcre --with-lz4 --with-gzip
else ifeq ($(BUILD_VARIANT),nossl)
	CONFIGURE_ARGS += --without-ssl --with-pcre2 --without-pcre --without-lz4 --with-gzip
else # tiny
	CONFIGURE_ARGS += --without-ssl --without-pcre2 --without-pcre --without-lz4 --without-gzip
endif

define Package/carbon-c-relay/default/conffiles
/etc/config/carbon-c-relay
/etc/carbon-c-relay/carbon-c-relay.conf
endef

define Package/carbon-c-relay/default/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/relay $(1)/usr/bin/carbon-c-relay-$(BUILD_VARIANT)
	ln -sr $(1)/usr/bin/carbon-c-relay-$(BUILD_VARIANT) $(1)/usr/bin/carbon-c-relay
	$(INSTALL_DIR) $(1)/etc/carbon-c-relay
	$(INSTALL_DATA) files/carbon-c-relay.conf $(1)/etc/carbon-c-relay/carbon-c-relay.conf
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/carbon-c-relay.init $(1)/etc/init.d/carbon-c-relay
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/carbon-c-relay.config $(1)/etc/config/carbon-c-relay
endef

Package/carbon-c-relay-full/install = $(Package/carbon-c-relay/default/install)
Package/carbon-c-relay-full/conffiles = $(Package/carbon-c-relay/default/conffiles)

Package/carbon-c-relay-nossl/install = $(Package/carbon-c-relay/default/install)
Package/carbon-c-relay-nossl/conffiles = $(Package/carbon-c-relay/default/conffiles)

Package/carbon-c-relay-tiny/install = $(Package/carbon-c-relay/default/install)
Package/carbon-c-relay-tiny/conffiles = $(Package/carbon-c-relay/default/conffiles)

$(eval $(call BuildPackage,carbon-c-relay-full))
$(eval $(call BuildPackage,carbon-c-relay-nossl))
$(eval $(call BuildPackage,carbon-c-relay-tiny))
