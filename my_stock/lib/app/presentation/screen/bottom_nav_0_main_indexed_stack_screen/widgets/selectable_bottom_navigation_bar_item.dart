part of '../main_indexed_stack_screen.dart';

class _SelectableBottomNavigationBarItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;

  const _SelectableBottomNavigationBarItem({
    super.key,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: isSelected ? 30 : 24,
      color: isSelected ? IconColor.selected.withOpacity(0.5) : Colors.grey,
    );
  }
}
