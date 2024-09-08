module("luci.controller.singbox", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/singbox") then
        return
    end

    entry({"admin", "services", "singbox"}, firstchild(), _("Sing-Box Control"), 10).dependent = false
    entry({"admin", "services", "singbox", "config"}, cbi("singbox/config"), _("Edit Config"), 1)
    entry({"admin", "services", "singbox", "control"}, template("singbox/control"), _("Control Panel"), 2).leaf = true
    entry({"admin", "services", "singbox", "status"}, call("action_status")).leaf = true
    entry({"admin", "services", "singbox", "start"}, call("action_start")).leaf = true
    entry({"admin", "services", "singbox", "stop"}, call("action_stop")).leaf = true
    entry({"admin", "services", "singbox", "restart"}, call("action_restart")).leaf = true
end

function action_status()
    local running = (luci.sys.call("pgrep sing-box >/dev/null") == 0)
    luci.http.prepare_content("application/json")
    luci.http.write_json({ running = running })
end

function action_start()
    luci.sys.call("/etc/init.d/singbox start")
    luci.http.redirect(luci.dispatcher.build_url("admin", "services", "singbox"))
end

function action_stop()
    luci.sys.call("/etc/init.d/singbox stop")
    luci.http.redirect(luci.dispatcher.build_url("admin", "services", "singbox"))
end

function action_restart()
    luci.sys.call("/etc/init.d/singbox restart")
    luci.http.redirect(luci.dispatcher.build_url("admin", "services", "singbox"))
end
