local fs = require "nixio.fs"
local map = Map("singbox", "Sing-Box Configuration", "Edit the Sing-Box configuration file.")

config = map:section(TypedSection, "config", "Config File")
config.addremove = false
config.anonymous = true

text = config:option(TextValue, "_data", "")
text.rmempty = false
text.rows = 20
function text.cfgvalue(self, section)
    return fs.readfile("/etc/neko/config/config.json") or ""
end
function text.write(self, section, value)
    fs.writefile("/etc/neko/config/config.json", value)
end

return map
