import 'package:flutter/material.dart';
import '../../../../../utils/constraints/sizes.dart';

class SGuideLanguages extends StatelessWidget {
  final Map<String, String> languages;

  const SGuideLanguages({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Languages',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: SSizes.spaceBtwItems),
        Wrap(
          spacing: SSizes.spaceBtwItems,
          children: languages.entries.map((entry) {
            return Chip(
              label: Text(
                '${entry.key} - ${entry.value}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            );
          }).toList(),
        ),
      ],
    );
  }
}
