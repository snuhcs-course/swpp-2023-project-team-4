import json

from django.core.exceptions import ObjectDoesNotExist
from report.models import Report
from stock.models import Stock

def run():
    with open('output.json', 'r', encoding='UTF-8-sig') as json_file:
        data = json.load(json_file)
        json_file.close()

    for item in data:
        try:
            stock_instance = Stock.objects.get(ticker=item['code'])

            report = Report(
                date=item['date'],
                summary=item['summary'],
                stock=item['code'],
            )
            report.save()

        except ObjectDoesNotExist:
            print(f"No stock found for ticker: {item['code']}")
            continue