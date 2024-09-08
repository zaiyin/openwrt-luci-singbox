include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-singbox
PKG_VERSION:=1.0
PKG_RELEASE:=1

LUCI_TITLE:=Luci support for Sing-Box
LUCI_DEPENDS:=+sing-box
LUCI_PKGARCH:=all

include $(TOPDIR)/feeds/luci/luci.mk

# Update MAINTAINER details
MAINTAINER:=Your Name <youremail@example.com>

# Define Package
define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller/singbox.lua
	$(INSTALL_BIN) ./luasrc/controller/singbox.lua $(1)/usr/lib/lua/luci/controller/singbox.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/singbox
	$(INSTALL_BIN) ./luasrc/model/cbi/singbox/config.lua $(1)/usr/lib/lua/luci/model/cbi/singbox/config.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/singbox
	$(INSTALL_BIN) ./luasrc/view/singbox/control.htm $(1)/usr/lib/lua/luci/view/singbox/control.htm

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/singbox-init $(1)/etc/init.d/singbox
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
