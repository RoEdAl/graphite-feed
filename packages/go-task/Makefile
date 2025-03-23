include $(TOPDIR)/rules.mk

PKG_NAME:=go-task
PKG_VERSION:=3.42.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/go-task/task/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=ebda29f1ec14e3e78f6d1e89136822c8177cc0b6d214fac8b1f027abce3c9042
PKG_BUILD_DIR:=$(BUILD_DIR)/task-$(PKG_VERSION)

PKG_MAINTAINER:=Edmunt Pienkowsky <roed@onet.eu>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=no-mips16

GO_PKG:=github.com/go-task/task/v3/cmd/task

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/go-task
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=A task runner written in Go
  URL:=https://taskfile.dev/
  DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
endef

define Package/go-task/description
A task runner / simpler Make alternative written in Go.
endef

$(eval $(call GoBinPackage,go-task))
$(eval $(call BuildPackage,go-task))