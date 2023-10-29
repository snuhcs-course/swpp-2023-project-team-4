part of '../search_stock_screen.dart';

class _SearchedTile extends StatelessWidget {
  final StockVM stock;
  final String searchKeyword;

  const _SearchedTile({
    super.key,
    required this.stock,
    required this.searchKeyword,
  });

  @override
  Widget build(BuildContext context) {
    String companyName = stock.name;
    int index = companyName.indexOf(searchKeyword);
    String first = companyName.substring(0, index);
    String second = companyName.substring(index, index + searchKeyword.length);
    String third = companyName.substring(index + searchKeyword.length);
    return InkWell(
      onTap: () {
        MyNavigator.push(StockRegisterScreen(stock));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        child: Row(
          children: [
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                width: 38,
                height: 38,
                fit: BoxFit.fill,
                imageUrl: stock.imageUrl,
                errorWidget: (context, url, error) => Container(
                  width: 38,
                  height: 38,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 13),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: first,
                    style: OtherTextStyle.button.writeText,
                  ),
                  TextSpan(
                    text: second,
                    style: OtherTextStyle.button.writeText.copyWith(
                      color: IconColor.selected,
                    ),
                  ),
                  TextSpan(
                    text: third,
                    style: OtherTextStyle.button.writeText,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
