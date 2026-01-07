include $(TOPDIR)/rules.mk

PKG_NAME:=collectd-statsd
PKG_VERSION:=1
PKG_RELEASE:=3

include $(INCLUDE_DIR)/package.mk

define Package/collectd-statsd
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=StatsD server based on CollectD
	MAINTAINER:=Edmunt Pienkowsky <roed@onet.eu>
	PKGARCH:=all
	DEPENDS:=+collectd +collectd-mod-logfile +collectd-mod-statsd +collectd-mod-write-graphite
	#EXTRA_DEPENDS:=collectd, collectd-mod-logfile, collectd-mod-statsd, collectd-mod-write-graphite
	USERID:=statsd:statsd
endef

define Package/collectd-statsd/description
CollectD acting as StatsD daemon.
StatsD daemon = CollectdD + StatsD plugin + Graphite plugin
endef

define Build/Compile
endef

define Package/collectd-statsd/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/collectd-statsd.init $(1)/etc/init.d/collectd-statsd
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/collectd-statsd.config $(1)/etc/config/collectd-statsd
endef

define Package/collectd-statsd/conffiles
/etc/config/collectd-statsd
endef

$(eval $(call BuildPackage,collectd-statsd))
