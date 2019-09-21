local awful = require("awful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local naughty = require("naughty")

local old_time = 0
local new_time = 0
local old_bytes = 0
local new_bytes = 0

local network_widget = wibox.widget {
    text = ' ',
    widget = wibox.widget.textbox
}


local update_network = function(widget, stdout, _, _, _)
    old_time = new_time
    old_bytes = new_bytes

    new_time = stdout:match('([^ ]+)')
    new_bytes = stdout:match('[^ ]+(.*)')

    bandwith = math.floor((new_bytes - old_bytes) / (new_time - old_time))

    widget.text = ' ' .. bandwith

    -- fix for memory leak (caused by all watch calls)
    collectgarbage("collect")
end

watch('bash -c ~/.config/awesome/mywidgets/network.sh', 3, update_network, network_widget)

return network_widget
