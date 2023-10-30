import exchange_calendars as ecals
import pandas as pd
import requests as request
from datetime import datetime
from io import BytesIO
from stock.models import Stock

date = datetime.now().strftime('%Y%m%d')

gen_otp_url = 'http://data.krx.co.kr/comm/fileDn/GenerateOTP/generate.cmd'
gen_otp_stk = {
    'locale': 'ko_KR',
    'mktId': 'ALL',
    'trdDd': date,
    'money': '1',
    'csvxls_isNo': 'false',
    'name': 'fileDown',
    'url': 'dbms/MDC/STAT/standard/MDCSTAT01501'
}
headers = {'Referer': 'http://data.krx.co.kr/contents/MDC/MDI/mdiLoader/index.cmd?menuId=MDC0201020506'}
down_url = 'http://data.krx.co.kr/comm/fileDn/download_csv/download.cmd'


def generate_df(gen_otp_url, gen_otp_stk, headers):
    otp_stk = request.post(gen_otp_url, gen_otp_stk, headers=headers).text
    down_sector_stk = request.post(down_url, {'code': otp_stk}, headers=headers)
    df_stock = pd.read_csv(BytesIO(down_sector_stk.content), encoding='EUC-KR')
    new_df = df_stock[['종목코드', '종목명', '시장구분', '종가', '고가', '저가']]
    new_df.columns = ['ticker', 'name', 'market_type', 'current_price', 'highest_price', 'lowest_price']
    new_df = new_df[new_df['market_type'].isin(['KOSDAQ', 'KOSPI'])]
    new_df = new_df[new_df['ticker'].str.contains('^[0-9]+$')]
    new_df['ticker'] = new_df['ticker'].astype(str).str.zfill(6)
    new_df.reset_index(drop=True, inplace=True)
    save_stock_info(new_df)
    return new_df


def save_stock_info(df):
    for i in range(len(df)):
        stock, created = Stock.objects.get_or_create(
            ticker=df['ticker'][i],
            name=df['name'][i],
            market_type=df['market_type'][i],
            current_price=df['current_price'][i],
            highest_price=df['highest_price'][i],
            lowest_price=df['lowest_price'][i],
        )

        if not created:
            stock.current_price = df['current_price'][i]
            stock.highest_price = df['highest_price'][i]
            stock.lowest_price = df['lowest_price'][i]

        stock.save()


# python manage.py runscript stock_info
def run():
    XKRX = ecals.get_calendar('XKRX')
    if(XKRX.is_session(datetime.now().strftime("%Y-%m-%d"))):
        generate_df(gen_otp_url, gen_otp_stk, headers)
    else:
        print("Today is not a business day")
