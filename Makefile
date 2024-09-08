include $(TOPDIR)/rules.mk

LUCI_TITLE:=Luci Sing-Box Control Panel
LUCI_DEPENDS:=+sing-box +nftables
LUCI_PKGARCH:=all

include $(TOPDIR)/feeds/luci/luci.mk

# Call BuildPackage - OpenWrt buildroot signature
$(eval $(call BuildPackage,luci-app-singbox))
