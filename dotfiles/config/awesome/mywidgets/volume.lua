local awful = require("awful")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local GET_VOLUME_CMD = 'amixer -D pulse sget Master'
local INC_VOLUME_CMD = 'amixer -D pulse sset Master 2%+'
local DEC_VOLUME_CMD = 'amixer -D pulse sset Master 2%-'
local TOG_VOLUME_CMD = 'amixer -D pulse sset Master toggle'

local volume_widget = wibox.widget {
    max_value = 1,
    thickness = 2,
    paddings = 1,
    forced_width = 18,
    forced_height = 18,
    start_angle = 4.712,
    bg = "#f0f0f020",
    widget = wibox.container.arcchart(),
    {
        markup = ' ',
        widget = wibox.widget.textbox
    }
}

local update_graphic = function(widget, stdout, _, _, _)
    local mute = string.match(stdout, "%[(o%D%D?)%]")
    local volume = string.match(stdout, "(%d?%d?%d)%%")
    volume = tonumber(string.format("% 3d", volume))
    widget.colors = mute == 'off' and { "#f0f0f0a0" } or { "#a0f0f0" }
    if (mute == 'off') then
        widget._private.widget.markup = ' x'
    elseif (volume == 0) then
        widget._private.widget.markup = ' '
    elseif (volume < 50) then
        widget._private.widget.markup = ' '
    else
        widget._private.widget.markup = ''
    end
    if (volume > 100) then
        volume = volume - 100
        widget.colors = { "#f06060" }
    end
    widget.value = volume / 100;
end

volume_widget:connect_signal("button::press", function(_, _, _, button)
    if (button == 4) then awful.spawn(INC_VOLUME_CMD, false)
    elseif (button == 5) then awful.spawn(DEC_VOLUME_CMD, false)
    elseif (button == 1) then awful.spawn(TOG_VOLUME_CMD, false)
    end

    spawn.easy_async(GET_VOLUME_CMD, function(stdout, stderr, exitreason, exitcode)
        update_graphic(volume_widget, stdout, stderr, exitreason, exitcode)
    end)
end)

watch(GET_VOLUME_CMD, 1, update_graphic, volume_widget)

return volume_widget
