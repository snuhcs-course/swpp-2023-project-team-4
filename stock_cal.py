

import psycopg2
import sys
from datetime import datetime, timedelta

# 데이터베이스 설정
db_config = {
    'host': 'your_host',
    'dbname': 'your_dbname',
    'user': 'your_user',
    'password': 'your_password',
    'port': 'your_port'
}

# 주식 가격의 주간 평균을 계산하는 함수
def calculate_weekly_average_price(stock_id, start_date):
    try:
        conn = psycopg2.connect(**db_config)
        cursor = conn.cursor()

        # 주식 가격의 주간 평균 계산
        end_date = start_date + timedelta(days=7)
        cursor.execute("""
            SELECT AVG(price) FROM daily_stock_prices
            WHERE stock_id = %s AND date >= %s AND date < %s;
        """, (stock_id, start_date, end_date))

        average_price = cursor.fetchone()[0]
        return average_price

    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        return None
    finally:
        if conn:
            conn.close()

# 특정 요일에 구매한 주식 가격이 평균 대비 몇 퍼센트 차이나는지 계산
def compare_purchase_price_with_average(user_id, stock_id, purchase_date):
    try:
        conn = psycopg2.connect(**db_config)
        cursor = conn.cursor()

        # 해당 주의 월요일 날짜 계산
        weekday = purchase_date.weekday()
        start_of_week = purchase_date - timedelta(days=weekday)

        # 주간 평균 가격 계산
        weekly_average_price = calculate_weekly_average_price(stock_id, start_of_week)

        # 해당 날짜의 구매 가격과 감정 조회
        cursor.execute("""
            SELECT purchase_price, emotion FROM user_transactions
            JOIN user_emotions ON user_transactions.user_id = user_emotions.user_id
            WHERE user_transactions.user_id = %s AND user_transactions.stock_id = %s
            AND user_transactions.date = %s;
        """, (user_id, stock_id, purchase_date))

        purchase_price, emotion = cursor.fetchone()

        # 가격 차이 및 퍼센트 계산
        price_difference = purchase_price - weekly_average_price
        percentage_difference = (price_difference / weekly_average_price) * 100

        return emotion, percentage_difference

    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        return None, None
    finally:
        if conn:
            conn.close()

# 예시 실행
if __name__ == '__main__':
    user_id = 123  # 사용자 ID
    stock_id = '005930'  # 삼성전자 주식 ID
    purchase_date = datetime(2023, 3, 15)  # 구매 날짜

    emotion, percentage_difference = compare_purchase_price_with_average(user_id, stock_id, purchase_date)
    print(f"{purchase_date.strftime('%Y-%m-%d')}에 선택한 감정 {emotion} 기준, 구매 가격은 평균 대비 {percentage_difference:.2f}% 차이납니다.")
