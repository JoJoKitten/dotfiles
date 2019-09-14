#!/bin/sh
widgets_dir="$HOME/.config/awesome/mywidgets"

output=$(curl 'https://www.wetteronline.de/wetter/hagen-niedersachsen-49170' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Connection: keep-alive' -H 'Cookie: WOM-Settings=prev_sid=MediumTerm|prev_pid=p_city_weather|prev_pcid=pc_city_weather|pcid=pc_city_weather|prev_gid=x0669|gid=x0669|pid=p_city_weather|baselayer=green_flat|sid=MediumTerm; _vwo_uuid=D19D8DE1A09E0BD75C0DA32C5DF4AA8C1; _ga=GA1.2.625778904.1523432029; reco_ligatus=1-18-6-2020; cto_lwid=bea3a1b7-dff4-44f9-9d29-5c790e1730a9; cto_idcpy=4e9d74f7-5dc8-4437-ab4b-e79d52e1f11c; userconsent_submit=yes; tenoso=3-10-9-2019; ioam2018=001258ed67a3113a35d7550d3:1594235909243:1567970309243:.wetteronline.de:4:wetteron:p_city_weather/MediumTerm:noevent:1567970393509:2zz5hn; _gid=GA1.2.2055796761.1567970315; WOaszip=49170; cto_bundle=BQwtX19sMGRiZ3lwWDJpRXZEY2ZrJTJCTmZkOXJwc1hLc21HTlBXSCUyQmtIWG83ciUyQkI0UWtlaHFSbzFtR1JJZmY2TkVrcW1Ra3pHWUtlY2t4d3ZPd0E1Tk54JTJGdWFEU0dVJTJGaExUa0FDTEZKZEd4ZmRwZ1c3Z3Fja3NyTWd1S3BSQ3NwNE1xVHZ5T21JYUozYVlDaGhBbFN5N0QxaHVIbFhpQTRPeUR0Z2pySEZJSE05R3JZJTNE; kiLp=2-9-9-2019; OB-USER-TOKEN=a8a8e2b8-1c20-43a4-8547-2f54b65af8c9' -H 'Upgrade-Insecure-Requests: 1' -H 'TE: Trailers')

temp_now=$(echo "$output" | sed -n 's/.*current-temperature..\([^<]*\).*/\1/p')
report_today=$(echo "$output" | sed -n 's/.*report-text today visible">\(.*\)<\/div.*/\1/p' | sed 's/<[^>]*>//g')

echo "$output" | sed -n 's/.*\(hour\|temperature\): \(.*\),/\2/p' \
    | awk '{if (NR % 2) {printf("%s ", $0)} else {printf("%s\n", $0)}}' \
    > $widgets_dir/weather_forecast.dat
gnuplot -p -e 'set terminal jpeg; set title "Prognose für die nächsten Stunden"; plot "~/.config/awesome/mywidgets/weather_forecast.dat" using 2:xtic(1) with linespoint lw 4 notitle' \
    > $widgets_dir/weather_forecast.jpg


echo "$temp_now"
echo "$report_today"
