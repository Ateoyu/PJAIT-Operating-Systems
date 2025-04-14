**Task:** Today's task is to create a script (or several independent commands) that generates a USD to złoty exchange rate chart for the entire year 2024. Additionally, if the script is run with 3 arguments, then:
- the first should specify the currency (USD, EUR, CHF) whose złoty chart we will display;
- the second should specify the start date
- the third should specify the end date

**Solution:**
```bash
#!/bin/bash

if (( $# == 3 )); then
    currency=$(printf "%s" "$1" | awk ' {print toupper($0)}')
    startDate=$2;
    endDate=$3;
else
    currency="USD"
    startDate="2024-01-01";
    endDate="2025-01-01";
fi

apiResponse=$(curl --silent "https://api.nbp.pl/api/exchangerates/rates/a/$currency/$startDate/$endDate/" |
jq -r ".rates[] | .effectiveDate, .mid")

printf "%s" "$apiResponse" | paste -d " " - - > "apiResponseFormatted.data"

gnuplot -persist <<-EOF
    set title "$currency to PLN"
    set xlabel 'Date'
    set ylabel 'Exchange rate to PLN'
    set xdata time
    set timefmt '%Y-%m-%d'
    set format x "%b\n%Y"
    set xtics time 1 month
    plot "apiResponseFormatted.data" using 1:2 with lines title "$currency exchange rate to PLN across $startDate to $endDate"
EOF
```