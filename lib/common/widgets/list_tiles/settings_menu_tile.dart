import 'package:flutter/material.dart';
import '../../../utils/constraints/colors.dart';

class SSettingsMenuTile extends StatelessWidget {
  const SSettingsMenuTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subTitle,
      this.trailing,
        this.onTap,
      });

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing; //? indicates that the widget is nullable
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: SColors.primary),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(subTitle, style: Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
      onTap: onTap,
    );
  }
}