import mysql.connector
import requests
import datetime

# Database connection
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'bitcoin_information'
}

def collect_data():
    url = "https://api.kraken.com/0/public/Ticker"
    params = {
          'pair': 'XXBTZUSD' 
    }
    
    try:
        response = requests.get(url, params=params)
        response.raise_for_status() 
        data = response.json()
        
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
        
    except requests.exceptions.RequestException as e:
        print(f"Data collection failed: {e}")
    except mysql.connector.Error as e:
        print(f"MySQL error: {e}")
    finally:
        if 'cursor' in locals(): cursor.close()
        if 'conn' in locals(): conn.close()

if __name__ == "__main__":
    collect_data()

