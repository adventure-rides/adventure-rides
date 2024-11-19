import 'package:flutter/material.dart';

import '../../../utils/constraints/sizes.dart';
import '../../../utils/constraints/text_strings.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../styles/spacing_styles.dart';

  class SuccessScreen extends StatelessWidget {
    const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

    final String image, title, subTitle;
    final VoidCallback onPressed;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: SSPacingStyle.paddingWithAppBarHeight * 2,
              child: Column(
                  children: [
              ///Image
                    Image(image: AssetImage(image), width: SHelperFunctions.screenWidth() * 0.6,),
                    const SizedBox(height: SSizes.spaceBtwSections),

                    ///Title & Subtitle
                    Text(title,
                        style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
                    const SizedBox(height: SSizes.spaceBtwItems),
                    Text(subTitle,
                        style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
                    const SizedBox(height: SSizes.spaceBtwSections),

                    ///Buttons
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: onPressed, child: const Text(SText.sContinue))),

        ],
        ),
          ),

        ),
      );
    }
  }
