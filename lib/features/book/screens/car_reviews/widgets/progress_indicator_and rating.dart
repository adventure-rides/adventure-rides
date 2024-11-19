import 'package:flutter/material.dart';

import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/device/device_utility.dart';


class SRatingProgressIdicator extends StatelessWidget {
  const SRatingProgressIdicator({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: SDevicesUtils.getScreenWidth(context) * 0.8,
            //takes the 80% of the screen
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: SColors.grey,
              valueColor: const AlwaysStoppedAnimation(SColors.primary),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ],
    );
  }
}
