# Set output to a PNG file
set terminal pngcairo enhanced font 'Verdana,6'
set output '/mnt/c/Users/Asus/data_management_cw2_ethan_kevin/ethereum_price_plot.png'

# Set datafile separator and date formatting
set datafile separator ","
set timefmt "%Y-%m-%d %H:%M:%S"
set xdata time
set format x "%H:%M\n%Y-%m-%d"

# Set plot attributes
set title "Ethereum Price Over Time"
set xlabel "Date and Time"
set ylabel "Price (USD)"
set grid

# Plot data
plot "/mnt/c/Users/Asus/data_management_cw2_ethan_kevin/ethereum_data.csv" using 1:2 title "Current Price" with lines, \
     "/mnt/c/Users/Asus/data_management_cw2_ethan_kevin/ethereum_data.csv" using 1:3 title "Day High" with lines, \
     "/mnt/c/Users/Asus/data_management_cw2_ethan_kevin/ethereum_data.csv" using 1:4 title "Day Low" with lines

# Print a success message (Linux)
!echo "Ethereum Plot successfully created!"
