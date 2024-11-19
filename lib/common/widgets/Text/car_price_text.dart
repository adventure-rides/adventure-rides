import 'package:flutter/material.dart';



class SCarPriceText extends StatelessWidget {
  const SCarPriceText({
    super.key,
    this.isLarge = false,
    this.maxLines = 1,
    this.lineThrough = false,
    this.currencySign = '\$',
    required this.price,
  });

  final bool isLarge;
  final int maxLines;
  final bool lineThrough;
  final String currencySign, price;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign + price,
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
