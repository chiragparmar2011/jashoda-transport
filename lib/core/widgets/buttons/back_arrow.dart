import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';

class BackArrowWidget extends StatelessWidget {
  const BackArrowWidget({
    this.onTap,
    super.key,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.topLeft,
        child: ImageAssets(
          image: AssetsPath.backArrow,
        ),
      ),
    );
  }
}
