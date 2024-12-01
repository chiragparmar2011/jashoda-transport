import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';

class ImageAssets extends StatelessWidget {
  const ImageAssets({
    required this.image,
    this.height = 24,
    this.width = 24,
    this.color,
    this.boxFit = BoxFit.scaleDown,
    super.key,
  });

  final String image;
  final double height;
  final double width;
  final Color? color;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    if (image.startsWith('https://') && image.endsWith('svg')) {
      return SvgPicture.network(
        image,
        height: height,
        width: width,
        fit: BoxFit.scaleDown,
        semanticsLabel:
            image.substring(image.lastIndexOf('/') + 1, image.length),
        placeholderBuilder: (BuildContext context) => _buildErrorWidget(),
      );
    }
    if (image.startsWith('https://')) {
      return Image.network(
        image,
        width: width,
        height: height,
        fit: boxFit,
        loadingBuilder: (
          BuildContext context,
          Widget child,
          ImageChunkEvent? loadingProgress,
        ) {
          if (loadingProgress == null) {
            return child;
          }
          return _buildErrorWidget();
        },
        errorBuilder: (
          BuildContext context,
          Object exception,
          StackTrace? stackTrace,
        ) {
          return _buildErrorWidget();
        },
      );
    }
    if (image.endsWith('svg')) {
      return SvgPicture.asset(
        image,
        height: height,
        width: width,
        fit: BoxFit.scaleDown,
        semanticsLabel:
            image.substring(image.lastIndexOf('/') + 1, image.length),
        placeholderBuilder: (BuildContext context) => _buildErrorWidget(),
      );
    }
    if (color != null) {
      return Image.asset(
        image,
        height: height,
        width: width,
        fit: boxFit,
        color: color,
        errorBuilder: (
          BuildContext? context,
          Object? exception,
          StackTrace? stackTrace,
        ) {
          return _buildErrorWidget();
        },
      );
    }
    return Image.asset(
      image,
      height: height,
      width: width,
      fit: boxFit,
      errorBuilder: (
        BuildContext? context,
        Object? exception,
        StackTrace? stackTrace,
      ) {
        return _buildErrorWidget();
      },
    );
  }

  Widget _buildErrorWidget() {
    return SizedBox(
      width: width,
      height: height,
      child: ImageAssets(
        image: AssetsPath.avtar,
        color: AppColors.white,
        boxFit: BoxFit.cover,
      ),
    );
  }
}
