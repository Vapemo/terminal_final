#!/bin/bash
echo -e "\n\e[36m╔═════════════════════════════╗"
echo -e "║        📅 FECHA Y HORA       ║"
echo -e "╚═════════════════════════════╝\e[0m\n"

hora=$(grep "rtc_time" /proc/driver/rtc | awk '{print $3}')
IFS=":" read -ra time <<< "$hora"
hour=${time[0]}
min=${time[1]}
sec=${time[2]}


fecha=$(grep "rtc_date" /proc/driver/rtc | awk '{print $3}')
IFS="-" read -ra date <<< "$fecha"
year=${date[0]}
month=${date[1]}
day=${date[2]}


echo -e "\n\t${am}[ ${r}FECHA:${v} $day/$month/$year ${am}| ${r}HORA:${v} $hour:$min:$sec ${am}]"
