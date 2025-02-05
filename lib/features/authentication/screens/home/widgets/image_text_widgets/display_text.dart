import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constraints/colors.dart';

class DisplayText extends StatelessWidget {
  const DisplayText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: SColors.accent,
        ),
        children: [
          const TextSpan(
            text: 'Your Adventure Starts Here –\nTap, Book, Go!\n\n',
            style: TextStyle(
              fontSize: 32,
              height: 1.3,
              shadows: [
                Shadow(
                  color: SColors.black,
                  blurRadius: 10,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
          TextSpan(
            text: 'Let’s make every mile magic ✨\nBook now and drive into delight! 🚗💨',
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: SColors.accent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}