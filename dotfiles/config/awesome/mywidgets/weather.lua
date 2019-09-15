local awful = require("awful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local naughty = require("naughty")

local current_temp = 0
local forecast = "0 0 0"
local report = ""

local weather_widget = wibox.widget {
    text = ' ',
    widget = wibox.widget.textbox
}

local update_weather = function(widget, stdout, _, _, _)
    current_temp = stdout:match('(%d+)')
    report = stdout:match('[^\n]*\n(.*)')

    widget.text = current_temp .. '°'

    -- fix for memory leak (caused by all watch calls)
    collectgarbage("collect")
end

weather_widget:buttons(
    awful.util.table.join(
        awful.button({}, 1, function()
            -- naughty.notify({ preset = naughty.config.presets.information,
            --                  title = "Wetter",
            --                  text = report,
            --                  timeout = 10,
            --              })
            naughty.notify({ preset = naughty.config.presets.information,
                             -- title = "Wettervorhersage",
                             message = "Wettervorhersage",
                             icon = "/home/jbensmann/.config/awesome/mywidgets/weather_forecast.png",
                             position = "top_right",
                             icon_size = 1000,
                             timeout = 10,
                         })
        end)
    )
)

watch('bash -c ~/.config/awesome/mywidgets/get_weather.sh', 30 * 60, update_weather, weather_widget)

return weather_widget
