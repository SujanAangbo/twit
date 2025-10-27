import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:twit/theme/color_palette.dart';

class AppCachedNetworkImage extends StatelessWidget {
  const AppCachedNetworkImage({
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.borderRadius = 10,
    this.color,
    this.isRounded = false,
    this.showLoadingError,
    super.key,
  });

  final double? height;
  final double? width;
  final String imageUrl;
  final BoxFit? fit;
  final double borderRadius;
  final Color? color;
  final bool isRounded;
  final bool? showLoadingError;

  @override
  Widget build(final BuildContext context) => CachedNetworkImage(
    height: height,
    width: width,
    imageUrl: imageUrl,
    imageBuilder: (final context, final provider) => Container(
      constraints: const BoxConstraints(minHeight: 50, minWidth: 50),
      decoration: BoxDecoration(
        image: DecorationImage(image: provider, fit: fit),
        borderRadius: isRounded ? null : BorderRadius.circular(borderRadius),
        color: color,
        shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
      ),
    ),
    placeholder: (final context, final str) => Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalette.greyColor,
          shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    ),
    errorWidget: (final context, final url, final error) => Container(
      decoration: BoxDecoration(
        color: ColorPalette.greyColor,
        shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Center(
        child: showLoadingError != null
            ? const CircularProgressIndicator()
            : Icon(Icons.error, color: Colors.red[300]),
      ),
    ),
  );
}
