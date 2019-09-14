local awful = require("awful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local ram_widget = wibox.widget {
    border_width = 0,
    colors = {
        '#74aeab', '#26403f'
    },
    display_labels = false,
    forced_width = 20,
    widget = wibox.widget.piechart
}

local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap

local function getPercentage(value)
    return math.floor(value / (total+total_swap) * 100 + 0.5) .. '%'
end

watch('bash -c "LANGUAGE=en_US.UTF-8 free | grep -z Mem.*Swap.*"', 5,
    function(widget, stdout, stderr, exitreason, exitcode)
        total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
            stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')

        widget.data = { used, total-used } widget.data = { used, total-used }

        if w.visible then
            w.pie.data_list = {
                {'used ' .. getPercentage(used + used_swap), used + used_swap},
                {'free ' .. getPercentage(free + free_swap), free + free_swap},
                {'buff_cache ' .. getPercentage(buff_cache), buff_cache}
            }

        -- fix for memory leak (caused by all watch calls)
        collectgarbage("collect")
        end
    end,
    ram_widget
)

return ram_widget
