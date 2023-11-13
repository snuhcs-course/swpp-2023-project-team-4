# summary.py
# -*- coding: utf-8 -*-

import torch
from transformers import AutoTokenizer, BartForConditionalGeneration
from extract_keyword import create_stopword_set, get_keywords_top5
from create_summary import remove_substrings, create_summary
import psycopg2




# Initialize model and tokenizer
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = BartForConditionalGeneration.from_pretrained("gogamza/kobart-base-v2")
tokenizer = AutoTokenizer.from_pretrained('gogamza/kobart-base-v2')
model.to(device)
model.eval()


def save_summary_to_db(report_id, summary):
    # Database credentials
    db_host = 'emostock.cm8cyxywzanw.ap-northeast-2.rds.amazonaws.com'
    db_user = 'root'
    db_password = 'Y7keL6YuCuvweeLtQqqC' 
    db_name = 'emostock'
    db_port = '5432'

    # SQL query to insert summary
    insert_query = """
    INSERT INTO report_summary (report_id, summary_text)
    VALUES (%s, %s)
    ON CONFLICT (report_id) DO UPDATE SET
    summary_text = EXCLUDED.summary_text;
    """

    # Connect to the database
    conn = psycopg2.connect(
        host=db_host,
        database=db_name,
        user=db_user,
        password=db_password,
        port=db_port
    )
    cur = conn.cursor()

    try:
        # Execute insert query
        cur.execute(insert_query, (report_id, summary))

        # Commit changes
        conn.commit()
    except Exception as e:
        # If an error occurs, print the error and rollback the transaction
        print(f"An error occurred: {e}")
        conn.rollback()
    finally:
        # Close cursor and connection
        cur.close()
        conn.close()

def generate_and_save_summary(report_id, text):
    summary = generate_summary_from_text(text)
    save_summary_to_db(report_id, summary)


def generate_summary_from_text(text, stopwords):
    # Remove unnecessary substrings
    cleaned_text = remove_substrings(text)

    # Extract keywords
    keywords = get_keywords_top5(cleaned_text, stopwords)

    # Generate summary
    summary = create_summary(cleaned_text, keywords, model, tokenizer, device)

    return summary

# Example usage:
if __name__ == "__main__":
    # Load stopwords
    stopword_path = "data/stopwords-ko.txt"
    stopwords = create_stopword_set(stopword_path)
    test_text = "신세계의  3분기 실적은  시장 기대치를  소폭 하회하였습니다. 면세점이  \n부진했는  데, 공항점의 일시적  영업면적  축소에  따라 수익성이  높은 공\n항점의  매출 감소로  이어진  영향입니다 . 소비 부진에  따라 백화점에  대\n한 기대가  낮아지고  있지만 , 높은 VIP 비중으로  동사의  백화점은  상대\n적으로  방어력이  높을 것으로  전망하고  있으며 , 단체관광객  유입, 따이\n공 수요 회복으로  면세점  가치 부각도  기대됩니다 . \n3Q23 Review  \n신세계의  3분기 총매출액은  2.6조원(-15.1% YoY), 영업이익  1,318억\n원(-13.9% YoY)을 기록해  영업이익  시장 전망치(1,479억원)을 소폭 \n하회하였다 . 당사 추정치  대비 백화점의  실적은  부합했지만 , 면세점의  \n수익성이  하회하였다 . 8월부터  4기 사업자  영업을  시작하면서 , 동사의  \n인천공항점은  기존 대비 영업면적이  일시적으로  축소된  상황이다 . 3분\n기 기준 계약 면적 대비 40%를 운영하고  있으며 , 그마저도  절반은  임\n시매장형식으로  운영했다 . 면적 축소로  수익성이  높은 공항점의  매출 \n감소가  면세점의  수익성  약화로  이어졌다 . 공항점은  11월 현재 기준 \n50% 수준이  오픈된  상황이며 , 연말까지  70%가 오픈될  예정이기에  일\n시적 면적 축소에  대한 영향은  점진적으로  감소할  것으로  전망된다 . \n면세점  가치 부각될  것 \n소비 여력 감소가  현실화되면서  낮은 기저에  따라 4분기 턴어라운드가  \n예상되었던  백화점의  반등세가  약하다 . 백화점에  대한 기대치는  다소 \n낮출 필요가  있겠다 . 다만 면세점의  가치는  단체관광객  유입 본격화와  \n따이공  수요 회복으로  부각될  수 있을 것으로  보인다 . 동사는  단체관광  \n비즈니스를  경험한  바가 없음에도  불구하고  호텔신라 에 이어 단체관광  \n슬롯 확보에  경쟁력을  보여주고  있다는  점이 고무적이다 . 소비 부진에  \n백화점에  대한 기대가  낮아지고  있지만 , 동사는  VIP 매출 비중이  높아 \n경쟁사  대비 방어력이  높으며 , 단체관광에  따른 낙수효과로  백화점의  \n외국인  매출 비중 확대가  본격화될  수 있다는  점을 감안 시, 안정적  성\n장을 이어나갈  가능성이  높다고  판단된다 .  \n투자의견  BUY, 목표주가  30만원 하향 \n신세계에  대해 투자의견  BUY를 유지하나  목표주가는  30만원으로  하\n향조정한다 . 백화점과  면세점 (공항) 이익전망치  하향을  반영하였다."
    test_stopwords = create_stopword_set(stopword_path)  
    keywords = get_keywords_top5(test_text, test_stopwords)
    print("Extracted Keywords:", keywords)

    # Test if the summary creation is correct
    summary = create_summary(test_text, keywords, model, tokenizer, device)
    print("Generated Summary:", summary)

    # # Example text
    # example_text = "신세계의  3분기 실적은  시장 기대치를  소폭 하회하였습니다. 면세점이  \n부진했는  데, 공항점의 일시적  영업면적  축소에  따라 수익성이  높은 공\n항점의  매출 감소로  이어진  영향입니다 . 소비 부진에  따라 백화점에  대\n한 기대가  낮아지고  있지만 , 높은 VIP 비중으로  동사의  백화점은  상대\n적으로  방어력이  높을 것으로  전망하고  있으며 , 단체관광객  유입, 따이\n공 수요 회복으로  면세점  가치 부각도  기대됩니다 . \n3Q23 Review  \n신세계의  3분기 총매출액은  2.6조원(-15.1% YoY), 영업이익  1,318억\n원(-13.9% YoY)을 기록해  영업이익  시장 전망치(1,479억원)을 소폭 \n하회하였다 . 당사 추정치  대비 백화점의  실적은  부합했지만 , 면세점의  \n수익성이  하회하였다 . 8월부터  4기 사업자  영업을  시작하면서 , 동사의  \n인천공항점은  기존 대비 영업면적이  일시적으로  축소된  상황이다 . 3분\n기 기준 계약 면적 대비 40%를 운영하고  있으며 , 그마저도  절반은  임\n시매장형식으로  운영했다 . 면적 축소로  수익성이  높은 공항점의  매출 \n감소가  면세점의  수익성  약화로  이어졌다 . 공항점은  11월 현재 기준 \n50% 수준이  오픈된  상황이며 , 연말까지  70%가 오픈될  예정이기에  일\n시적 면적 축소에  대한 영향은  점진적으로  감소할  것으로  전망된다 . \n면세점  가치 부각될  것 \n소비 여력 감소가  현실화되면서  낮은 기저에  따라 4분기 턴어라운드가  \n예상되었던  백화점의  반등세가  약하다 . 백화점에  대한 기대치는  다소 \n낮출 필요가  있겠다 . 다만 면세점의  가치는  단체관광객  유입 본격화와  \n따이공  수요 회복으로  부각될  수 있을 것으로  보인다 . 동사는  단체관광  \n비즈니스를  경험한  바가 없음에도  불구하고  호텔신라 에 이어 단체관광  \n슬롯 확보에  경쟁력을  보여주고  있다는  점이 고무적이다 . 소비 부진에  \n백화점에  대한 기대가  낮아지고  있지만 , 동사는  VIP 매출 비중이  높아 \n경쟁사  대비 방어력이  높으며 , 단체관광에  따른 낙수효과로  백화점의  \n외국인  매출 비중 확대가  본격화될  수 있다는  점을 감안 시, 안정적  성\n장을 이어나갈  가능성이  높다고  판단된다 .  \n투자의견  BUY, 목표주가  30만원 하향 \n신세계에  대해 투자의견  BUY를 유지하나  목표주가는  30만원으로  하\n향조정한다 . 백화점과  면세점 (공항) 이익전망치  하향을  반영하였다."  # Replace with actual text
    # summary = generate_summary_from_text(example_text, stopwords)
    # print(summary)