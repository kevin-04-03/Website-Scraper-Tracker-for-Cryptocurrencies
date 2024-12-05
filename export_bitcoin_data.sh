#!/bin/bash
# MySQL credentials
MYSQL_USER="ethan"
MYSQL_PASS="29122002"
MYSQL_DB="bitcoin_information"
OUTPUT_FILE="/mnt/c/Users/Asus/data_management_cw2_ethan_kevin/bitcoin_data.csv"

# Temporary file path for MySQL OUTFILE
TEMP_FILE="/var/lib/mysql-files/temp_bitcoin_data.csv"

# Export MySQL data to CSV
mysql -u $MYSQL_USER -p$MYSQL_PASS -h localhost $MYSQL_DB -e "
SELECT CreatedDateTime, CurrentPrice, DayHighestPrice, DayLowestPrice
INTO OUTFILE '$TEMP_FILE'
FIELDS TERMINATED BY ','
ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
FROM bitcoin;"

# Move the exported file to target directory
mv $TEMP_FILE $OUTPUT_FILE
