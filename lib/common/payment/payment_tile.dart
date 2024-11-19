import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../features/book/controllers/car/checkout_controller.dart';
import '../../features/book/models/payment_method_model.dart';
import '../../utils/constraints/colors.dart';
import '../../utils/constraints/sizes.dart';
import '../../utils/helpers/helper_functions.dart';
import '../container/rounded_container.dart';

class SPaymentTile extends StatelessWidget {
  const SPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckOutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: (){
        controller.selectedPaymentMethod.value =paymentMethod;
        Get.back();
      },
      leading: SRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: SHelperFunctions().isDarkMode(context) ? SColors.light : SColors.white,
        padding: const EdgeInsets.all(SSizes.sm),
        child: Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
