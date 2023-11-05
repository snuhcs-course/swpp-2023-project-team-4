import enum


class TransactionType(enum.Enum):
    BUY = "buy"
    SELL = "sell"


class MarketType(enum.Enum):
    KOSDAQ = "KOSDAQ"
    KOSPI = "KOSPI"
