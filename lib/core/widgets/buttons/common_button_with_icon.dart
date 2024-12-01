import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';

class CustomButtonWithIconWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final Key? imageKey;
  final double height;
  final Widget? iconWidget;

  const CustomButtonWithIconWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.imageKey,
    required this.height,
    this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _buildRow(),
      ),
    );
  }

  Widget _buildRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconWidget ?? const SizedBox.shrink(),
        Dimentions.sizedBox12W,
        Text(
          title,
          style: TextStyles().textStylesMontserrat(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
