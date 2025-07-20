import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';

class TruckViewWidget extends StatelessWidget {
  const TruckViewWidget({
    this.height = 130,
    this.width = 130,
    this.truckHeight = 110,
    this.truckWidth = 10,
    super.key,
  });

  final double height;
  final double width;
  final double truckHeight;
  final double truckWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyLightWhite,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ImageAssets(
          image: AssetsPath.deliveryTruckIcon,
          height: truckHeight,
          width: truckWidth,
        ),
      ),
    );
  }
}
