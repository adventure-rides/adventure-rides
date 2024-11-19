import 'package:flutter/material.dart';



class SGuideFeeText extends StatelessWidget {
  const SGuideFeeText({
    super.key,
    this.isLarge = false,
    this.maxLines = 1,
    this.lineThrough = false,
    this.currencySign = '\$',
    required this.fee,
  });

  final bool isLarge;
  final int maxLines;
  final bool lineThrough;
  final String currencySign, fee;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign + fee,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
          decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.titleLarge!.apply(
          decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}
