# Set output to a PNG file
set terminal pngcairo enhanced font 'Verdana,8'
set output '/mnt/c/Users/lowkp/data_management_cw2_ethan_kevin/solana_price_plot.png'

# Set datafile separator and date formatting
set datafile separator ","
set timefmt "%Y-%m-%d %H:%M:%S"
set xdata time
set format x "%H:%M\n%Y-%m-%d"

# Set plot attributes
set title "Solana Price Over Time"
set xlabel "Date and Time"
set ylabel "Price (USD)"
set grid

# Plot data
plot "/mnt/c/Users/lowkp/data_management_cw2_ethan_kevin/solana_data.csv" using 1:2 title "Current Price" with lines, \
     "/mnt/c/Users/lowkp/data_management_cw2_ethan_kevin/solana_data.csv" using 1:3 title "Day High" with lines, \
     "/mnt/c/Users/lowkp/data_management_cw2_ethan_kevin/solana_data.csv" using 1:4 title "Day Low" with lines

# Print a success message (Linux)
!echo "Solana Plot successfully created!"
