part of '../main_indexed_stack_screen.dart';

class _SelectableBottomNavigationBarItem extends StatelessWidget {
  final String asset;
  final bool isSelected;

  const _SelectableBottomNavigationBarItem({
    super.key,
    required this.asset,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: isSelected ? 33 : 28,
      height: isSelected ? 33 : 28,
      fit: BoxFit.fill,
      color: isSelected ? IconColor.selected : null,
    );
  }
}
