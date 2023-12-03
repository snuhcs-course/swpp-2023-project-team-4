part of '../settings_screen.dart';

class _ContentBox extends StatelessWidget {
  final String title;
  final List<_ContentVM> contents;

  const _ContentBox({super.key, required this.title, required this.contents});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(title, style: HeaderTextStyle.nanum18.writeText),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: StrokeColor.writeText, width: 1),
          ),
          child: Column(
            children: _buildChildren(contents),
          ),
        )
      ],
    );
  }

  List<Widget> _buildChildren(List<_ContentVM> contents) {
    List<Widget> list = [];
    for (var content in contents) {
      int index = contents.indexOf(content);
      if (content.buttonText != null) {
        list.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Icon(content.icon, size: 24, color: Colors.black.withOpacity(0.7)),
                const SizedBox(width: 10),
                Text(content.text, style: BodyTextStyle.nanum15.writeText),
                Spacer(),
                GestureDetector(
                  onTap: content.onTap,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      content.buttonText!,
                      style: BodyTextStyle.nanum15.copyWith(color: StrokeColor.sell),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        list.add(
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(index == 0 ? 15 : 0),
                topRight: Radius.circular(index == 0 ? 15 : 0),
                bottomLeft: Radius.circular(index == contents.length - 1 ? 15 : 0),
                bottomRight: Radius.circular(index == contents.length - 1 ? 15 : 0),
              ),
              onTap: content.onTap,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20).copyWith(
                  top: index == 0 ? 20 : 15,
                  bottom: index == contents.length - 1 ? 20 : 15,
                ),
                child: Row(
                  children: [
                    Icon(content.icon, size: 24, color: Colors.black.withOpacity(0.7)),
                    const SizedBox(width: 10),
                    Text(content.text, style: BodyTextStyle.nanum15.writeText),
                  ],
                ),
              ),
            ),
          ),
        );
      }
      list.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            width: double.infinity,
            height: 1,
            color: StrokeColor.writeText,
          ),
        ),
      );
    }
    list.removeLast();
    return list;
  }
}

class _ContentVM {
  final IconData icon;
  final String text;
  final String? buttonText;
  final void Function() onTap;

  const _ContentVM({
    required this.icon,
    required this.text,
    this.buttonText,
    required this.onTap,
  });
}
