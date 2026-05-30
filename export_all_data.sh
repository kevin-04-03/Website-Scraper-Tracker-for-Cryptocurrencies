#!/bin/bash
# MySQL credentials
MYSQL_USER="root"
MYSQL_PASS=""
MYSQL_DB="bitcoin_information"
OUTPUT_FILE="/mnt/c/Users/Asus/data_management_cw2_ethan_kevin/all_data.csv"

# Temporary file path for MySQL OUTFILE
TEMP_FILE="/var/lib/mysql-files/temp_all_data.csv"

echo "Executing as: $(whoami)"

# Remove any existing temporary file
if [ -f "$TEMP_FILE" ]; then
    echo "Removing existing temporary file..."
    sudo rm "$TEMP_FILE"
    if [ $? -ne 0 ]; then
        echo "Failed to remove $TEMP_FILE. Exiting."
        exit 1
    fi
fi

# Export MySQL data to CSV
mysql -u $MYSQL_USER -p $MYSQL_PASS -h localhost $MYSQL_DB -e "
SELECT CreatedDateTime, Cryptocurrency, CurrentPrice
INTO OUTFILE '$TEMP_FILE'
FIELDS TERMINATED BY ','
ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
FROM (
    SELECT 'Bitcoin' AS Cryptocurrency, CurrentPrice, CreatedDateTime
    FROM bitcoin
    UNION ALL
    SELECT 'Ethereum' AS Cryptocurrency, CurrentPrice, CreatedDateTime
    FROM ethereum
    UNION ALL
    SELECT 'Solana' AS Cryptocurrency, CurrentPrice, CreatedDateTime
    FROM solana
) AS all_data;" || { echo "MYSQL export failed"; exit 1; }

# Move the exported file to target directory
sudo mv "$TEMP_FILE" "$OUTPUT_FILE" || { echo "Failed to move file to $OUTPUT_FILE"; exit 1; }

echo "Export successful: $OUTPUT_FILE"
