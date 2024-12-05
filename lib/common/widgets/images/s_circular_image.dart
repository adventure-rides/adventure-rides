import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../features/Effects/shimmer.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class SCircularImage extends StatelessWidget {
  const SCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    this.width = 56,
    this.height = 56,
    this.padding = SSizes.sm,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
  });

  final BoxFit? fit;
  final double width, height, padding;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        //If image background color is null then switch it to light and dark mode color design
        color: backgroundColor ??
            (SHelperFunctions().isDarkMode(context)
                ? SColors.black
                : SColors.white),
        //borderRadius: BorderRadius.circular(100),
        shape: BoxShape.circle, // Ensures the container is circular
      ),
      child: ClipOval(
        child: isNetworkImage ? CachedNetworkImage( //Cached image for reusing default image whenever the image is not updated
          fit: fit,
            color: overlayColor,
            imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) => const SShimmerEffect(width: 55, height: 55),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        )
        : Image(
          fit: fit,
          image: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,
          color: overlayColor,
        ),
      ),
    );
  }
}
