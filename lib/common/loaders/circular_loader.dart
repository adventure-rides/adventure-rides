import 'package:flutter/material.dart';

import '../../utils/constraints/colors.dart';
import '../../utils/constraints/sizes.dart';

class SCircularLoader extends StatelessWidget {
  const SCircularLoader({
    super.key,
    required this.text,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(SColors.dark),
            strokeWidth: 4.0,
          ),
          const SizedBox(height: SSizes.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: SSizes.defaultSpace),
          showAction
              ? SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: onActionPressed,
              style: OutlinedButton.styleFrom(backgroundColor: SColors.dark),
              child: Text(
                actionText!,
                style: Theme.of(context).textTheme.bodyMedium!.apply(color: SColors.light),
              ),
            ),
          )
              : const SizedBox(),
        ],
      ),
    );
  }
}
