import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({
    required this.avtarImage,
    required this.title,
    required this.onTap,
    super.key,
  });

  final String avtarImage;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.greyWhite),
        ),
        child: Row(
          children: [
            ImageAssets(image: avtarImage),
            Dimentions.sizedBox12W,
            Text(
              title,
              style: TextStyles().textStylesNunito(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
