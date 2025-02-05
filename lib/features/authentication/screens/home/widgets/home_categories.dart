import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Effects/category_shimmer.dart';
import '../../../../book/controllers/category_controller.dart';
import 'image_text_widgets/vertical_image_text.dart';

class SHomeCategories extends StatelessWidget {
  const SHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.isLoading.value) return const SCategoryShimmer();
      if(categoryController.featuredCategories.isEmpty) {
        return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
      }
          return SizedBox(
            height: 80,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: categoryController.featuredCategories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final category = categoryController.featuredCategories[index];
                  return SVerticalImageText(
                    image: category.image,
                    title: category.name,
                    //uncomment to enable click
                    //onTap: () => Get.to(() => SubCategoriesScreen(category: category)),
                  );
                }),
          );
        }
    );
  }
}
