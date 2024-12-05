import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../advert/controllers/advert_controller.dart';

class AdvertDisplayScreen extends StatelessWidget {
  final AdvertController controller = Get.put(AdvertController());

  AdvertDisplayScreen({super.key}) {
    controller.fetchAdverts();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.adverts.isEmpty) {
        return Center(child: Text('No adverts to display.'));
      }
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.adverts.length,
        itemBuilder: (context, index) {
          final advert = controller.adverts[index];

          // Track impressions
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.logImpression(advert.id);
          });

          return GestureDetector(
            onTap: () {
              controller.logClick(advert.id);
              // Redirect user to advert URL
              launchUrl(Uri.parse(advert.redirectUrl));
            },
            child: Card(
              child: Column(
                children: [
                  Image.network(advert.imageUrl, width: 60, height: 100, fit: BoxFit.cover),
                  Text(advert.advertTitle, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}