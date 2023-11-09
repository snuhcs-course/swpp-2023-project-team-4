part of '../record_emotion_screen.dart';

class _TransactionTile extends StatelessWidget {
  final StockTransactionVM transaction;

  const _TransactionTile(
    this.transaction, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: EmotionColor.notFilled,
          ),
        ),
        const SizedBox(width: 10),
        Text(transaction.name, style: PretendardTextStyle.regular14.black),
        Spacer(),
        Text(
          "${transaction.quantity}주 ${transaction.buy ? "구매" : "판매"}",
          style: PretendardTextStyle.regular14.black,
        ),
      ],
    );
  }
}
