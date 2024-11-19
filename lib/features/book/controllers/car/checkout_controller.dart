import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/payment/payment_tile.dart';
import '../../../../common/widgets/Text/section_heading.dart';
import '../../../../utils/constraints/enums.dart';
import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../models/payment_method_model.dart';

class CheckOutController extends GetxController {
  static CheckOutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: PaymentMethods.paypal.name, image: SImages.paypal);
    super.onInit();
  }
  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(SSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SSectionHeading(title: 'Select Payment Method', showActionButton: false),
                const SizedBox(height: SSizes.spaceBtwSections),
                SPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: SImages.paypal)),
                const SizedBox(height: SSizes.spaceBtwItems / 2),
                SPaymentTile(paymentMethod: PaymentMethodModel(name: 'Google Pay', image: SImages.googlePay)),
                const SizedBox(height: SSizes.spaceBtwItems / 2),
                SPaymentTile(paymentMethod: PaymentMethodModel(name: 'Apple Pay', image: SImages.applePay)),
                const SizedBox(height: SSizes.spaceBtwItems / 2),
                SPaymentTile(paymentMethod: PaymentMethodModel(name: 'VISA', image: SImages.visa)),
                const SizedBox(height: SSizes.spaceBtwItems / 2),
                SPaymentTile(paymentMethod: PaymentMethodModel(name: 'Master Card', image: SImages.mastercard)),
                const SizedBox(height: SSizes.spaceBtwItems / 2),
                SPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paytm', image: SImages.paytm)),
                const SizedBox(height: SSizes.spaceBtwItems / 2),
                SPaymentTile(paymentMethod: PaymentMethodModel(name: 'PayStack', image: SImages.payStack)),
                const SizedBox(height: SSizes.spaceBtwItems / 2),
                SPaymentTile(paymentMethod: PaymentMethodModel(name: 'Credit Card', image: SImages.creditCard)),
                const SizedBox(height: SSizes.spaceBtwItems / 2),
                const SizedBox(height: SSizes.spaceBtwSections),
              ],
            ),
          ),
        ),
    );
  }
}