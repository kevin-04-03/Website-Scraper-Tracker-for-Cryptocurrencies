# Set output to a PNG file
set terminal pngcairo enhanced font 'Verdana,8'
set output '/mnt/c/Users/lowkp/data_management_cw2_ethan_kevin/all_price_plot.png'

# Set datafile separator and date formatting
set datafile separator ","
set timefmt "%Y-%m-%d %H:%M:%S"
set xdata time
set format x "%H:%M\n%Y-%m-%d"

# Set plot attributes
set title "Cryptocurrency Prices Over Time"
set xlabel "Date and Time"
set ylabel "Price (USD)"
set grid

# Define unique colors for each cryptocurrency
btc_color = "#FF0000"
eth_color = "#0000FF"
sol_color = "#00FF00"

# Plot the data
plot "/mnt/c/Users/lowkp/data_management_cw2_ethan_kevin/all_data.csv" \
     using 1:(strcol(2) eq "Bitcoin" ? $3 : 1/0) title "Bitcoin" with linespoints lc rgb btc_color, \
     '' using 1:(strcol(2) eq "Ethereum" ? $3 : 1/0) title "Ethereum" with linespoints lc rgb eth_color, \
     '' using 1:(strcol(2) eq "Solana" ? $3 : 1/0) title "Solana" with linespoints lc rgb sol_color

# Print a success message (Linux)
!echo "All data plot successfully created!"
