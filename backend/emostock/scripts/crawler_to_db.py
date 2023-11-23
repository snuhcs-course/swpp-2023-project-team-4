import json

from django.core.exceptions import ObjectDoesNotExist
from report.models import ReportAnalysis
from stock.models import Stock

def run():
    # JSON 파일에서 데이터 읽기
    with open('data.json', 'r', encoding='UTF-8-sig') as json_file:
        data = json.load(json_file)
        json_file.close()

    # 데이터베이스에 데이터 삽입
    for item in data:
        try:
            stock_instance = Stock.objects.get(ticker=item['code'])

            report_analysis = ReportAnalysis(
                company=item['company'],
                date=item['date'],
                link=item['link'],
                author=item['author'],
                source=item['source'],
                title=item['title'],
                fair_price=item['fair_price'],
                investment_op=item['investment_op'],
                status=item['status'],
                content=item['content'],
                stock_id=item['code']
            )
            report_analysis.save()

        except ObjectDoesNotExist:
            print(f"No stock found for ticker: {item['code']}")
            continue

        except Exception as e:
            print(f"Error processing item: {e}\n{item['company']} couldn't be updated")
