import mysql.connector
import requests
import datetime
import time

# Database connection
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'bitcoin_information',
    'ssl_disabled': True
}

def collect_data():
    url = "https://api.kraken.com/0/public/Ticker"
    params = {'pair': 'XXBTZUSD'}
    
    max_retries = 3
    retry_delay = 5 

    for attempt in range(max_retries):
        try:
            response = requests.get(url, params=params, timeout=10)
            response.raise_for_status()  
            data = response.json()

            # Validate response structure
            if 'result' not in data or 'XXBTZUSD' not in data['result']:
                raise ValueError("Invalid data structure in API response")

            ticker_data = data['result']['XXBTZUSD']
            CurrentPrice = float(ticker_data['c'][0]) 
            DayHighestPrice = float(ticker_data['h'][0]) 
            DayLowestPrice = float(ticker_data['l'][0])  
            CreatedDateTime = datetime.datetime.now()

            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()
            query = """INSERT INTO bitcoin (CreatedDateTime, CurrentPrice, DayHighestPrice, DayLowestPrice) VALUES (%s, %s, %s, %s)"""

            cursor.execute(query, (CreatedDateTime, CurrentPrice, DayHighestPrice, DayLowestPrice))
            conn.commit()
            print("Data inserted successfully.")
            break 

        except requests.exceptions.RequestException as e:
            print(f"Attempt {attempt + 1} of {max_retries}: API request failed - {e}")
            if attempt < max_retries - 1:
                time.sleep(retry_delay) 
            else:
                print("All retry attempts failed. Exiting.")

        except ValueError as e:
            print(f"Data validation error: {e}")
            break

        except mysql.connector.Error as e:
            print(f"MySQL error: {e}")
            break

        finally:
            if 'cursor' in locals(): cursor.close()
            if 'conn' in locals(): conn.close()

if __name__ == "__main__":
    collect_data()
