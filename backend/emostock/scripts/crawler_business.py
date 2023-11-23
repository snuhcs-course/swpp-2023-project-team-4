import urllib.request
from bs4 import BeautifulSoup
import json
from datetime import datetime, timedelta
import PyPDF2


date = (datetime.now() - timedelta(days=1))
date = datetime.strftime(date, '%Y-%m-%d')

userAgent = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36'}


class ArticleLink:
    def __init__(self, date, code, company, title, link, fair_price, invest_recom, author, source, status, content):
        self.title = title
        self.link = link
        self.date = date
        self.code = code
        self.fair_price = fair_price
        self.invest_recom = invest_recom
        self.author = author
        self.source = source
        self.company = company
        self.status = status
        self.content = content


class Article:
    def __init__(self, title, text):
        self.title = title
        self.text = text


def get_url(date):
    now_page = 1
    url = "https://consensus.hankyung.com/analysis/list?skinType=business&sdate={}&edate={}&order_type=&now_page={}".format(
        date, date, now_page)
    return url


def get_pages(url):
    req = urllib.request.Request(url, headers=userAgent)

    try:
        file_ = urllib.request.urlopen(req)
    except:
        print(url)
        file_ = urllib.request.urlopen(req, timeout=10)
    webpage = file_.read()
    soup = BeautifulSoup(webpage, 'html.parser')
    last_page_element = soup.find('a', class_='btn last')
    if last_page_element:
        href = last_page_element['href']
        # href -> 'now_page'
        pages = href.split('&now_page=')[-1]
        if pages.isdigit():
            pages = int(pages)
            print("페이지 수:", pages)
        else:
            print("페이지 수를 찾을 수 없음")
    else:
        print("마지막 페이지 요소를 찾을 수 없음")
    # UTF-8 decode
    file_.close()
    return pages


# return articles(title, link)
def get_urls(date, pages):
    articlelinks = []
    for now_page in range(1, pages + 1):
        url = "https://consensus.hankyung.com/analysis/list?&sdate={}&edate={}&report_type=CO&order_type=&now_page={}".format(
            date, date, now_page)
        req = urllib.request.Request(url, headers=userAgent)
        try:
            file_ = urllib.request.urlopen(req)
        except:
            print(url)
            file_ = urllib.request.urlopen(req, timeout=10)
        webpage = file_.read()
        soup = BeautifulSoup(webpage, 'html.parser')
        file_.close()
        url_header = 'https://consensus.hankyung.com'
        for tr in soup.find_all('tr')[1:]:
            # <td> 태그들을 찾기
            # 'td' 태그의 텍스트 추출
            date = tr.find(class_="first txt_number").text
            # 'a' 태그의 href 속성 값 추출
            link = url_header + tr.find('a')['href']
            # 'a' 태그의 텍스트에서 회사명과 코드 추출
            text = tr.find('a').text
            title = text
            if '(' in text and ')' in text:
                company, code = text.split('(')[0], text.split('(')[1].split(')')[0]
            else:
                company, code = text, None
            # 'td' 태그의 텍스트에서 fair price 추출
            fair_price = tr.find(class_='text_r txt_number').text
            # 'td' 태그의 텍스트에서 투자의견 추출
            investment_opinion = tr.find_all('td')[3].text.strip()
            # 'td' 태그의 텍스트에서 작성자 추출
            author = tr.find_all('td')[4].text
            # 'td' 태그의 텍스트에서 제공출처 추출
            source = tr.find_all('td')[5].text
            articlelink = ArticleLink(date, code, company, title, link, fair_price, investment_opinion, author, source,
                                      status="", content="")
            articlelinks.append(articlelink)
    return articlelinks


def download_pdf(pdf_url):
    userAgent = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36'}
    req = urllib.request.Request(pdf_url, headers=userAgent)
    downloaded_pdf = 'pdf.pdf'

    try:
        file_ = urllib.request.urlopen(req)
    except:
        print(pdf_url)
        file_ = urllib.request.urlopen(req, timeout=10)  # Handle error here.

    webpage = file_.read()
    file_.close()
    with open(downloaded_pdf, 'wb') as f:
        f.write(webpage)
    return downloaded_pdf


def pdf_to_txt(downloaded_pdf):
    text = ""
    try:
        with open(downloaded_pdf, 'rb') as pdf_file:
            pdf_reader = PyPDF2.PdfReader(pdf_file)
            # PDF 파일 내의 페이지 수
            num_pages = len(pdf_reader.pages)
            # 각 페이지의 텍스트를 추출하여 출력
            for page_num in range(num_pages):
                page = pdf_reader.pages[page_num]
                text += page.extract_text()
    except FileNotFoundError:
        print("파일을 찾을 수 없습니다.")
    except PermissionError:
        print("파일에 쓰기 권한이 없습니다.")
    except IOError as e:
        print(f"입출력 오류 발생: {e}")
    except Exception as e:
        print(f"다른 예외 발생: {e}")
    pdf_file.close()
    return text


articles = []


def read_articles(articlelinks):
    i = 0
    for articlelink in articlelinks:
        i = i + 1
        print(f"{i}. {articlelink.title}")
        content = read_article(articlelink.link)
        articlelink.content = content


def read_article(link):
    pdf_url = link
    downloaded_pdf = download_pdf(pdf_url)
    content = pdf_to_txt(downloaded_pdf)
    return content


def articles_to_dict(articlelinks):
    new_dataset = []
    for article in articlelinks:
        status = "Complete"
        if article.content == "":
            status = "Incomplete"
        fair_price_str = article.fair_price
        price_int = None
        if fair_price_str and fair_price_str.replace(',', '').isdigit():
            price_int = int(fair_price_str.replace(',', ''))
        new_data = {
            "date": article.date,
            "company": article.company,
            "code": article.code,
            "title": article.title,
            "link": article.link,
            "fair_price": price_int,
            "investment_op": article.invest_recom,
            "author": article.author,
            "source": article.source,
            "status": status,
            "content": article.content
        }
        new_dataset.append(new_data)
    return new_dataset


def save_as_json(new_db):
    with open('data.json', 'w', encoding='UTF-8-sig') as file:
        file.write(json.dumps(new_db, ensure_ascii=False, indent=4))
        file.close()

def run():
    url = get_url(date)
    print(f"날짜: {date}에서 {date}까지")
    pages = get_pages(url)
    articlelinks = get_urls(date, pages)
    read_articles(articlelinks)
    new_dataset = articles_to_dict(articlelinks)
    save_as_json(new_dataset)