# ... (imports and other code)

class DataPipe:
    def __init__(self, log_file:str=None, debug:bool=False):
        self.stopwords = stopwords
        self.model = model
        self.tokenizer = tokenizer
        self.device = device

    def process_text_and_update_db(self):
        # Connect to the database using psycopg2
        conn = psycopg2.connect(
            host=self._GOGH_ADDRESS,
            database=self._GOGH_DB,
            user=self._GOGH_USER,
            password=self._GOGH_PASSWORD
        )
        cur = conn.cursor()

        try:
            # Fetch text data from the database
            cur.execute("SELECT id, content FROM report_analysis WHERE status = 'waiting'")
            rows = cur.fetchall()

            for row in rows:
                report_id, content = row
                # Extract keywords and summarize
                keywords = get_keywords_top5(content, stopwords)
                summary = create_summary(content, keywords, model, tokenizer, device)

                # Save the summary into report_summary table
                cur.execute("INSERT INTO report_summary (report_id, summary_text) VALUES (%s, %s)", (report_id, summary))

                # Update the status in report_analysis table
                cur.execute("UPDATE report_analysis SET status = 'processed' WHERE id = %s", (report_id,))

            # Commit the changes
            conn.commit()
        except Exception as e:
            # Rollback the transaction in case of error
            conn.rollback()
            logger.error(f"An error occurred: {e}")
        finally:
            # Close the cursor and connection
            cur.close()
            conn.close()

# Run the DataPipe process
pipe = DataPipe(log_file='my_log.log', debug=True)
pipe.process_text_and_update_db()
