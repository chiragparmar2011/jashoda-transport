import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';

class ConfirmationButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final double height;
  final double width;
  final Widget? iconWidget;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const ConfirmationButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height = 48,
    required this.width,
    this.iconWidget,
    this.foregroundColor = AppColors.primaryBlue,
    this.backgroundColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: foregroundColor,
          foregroundColor: backgroundColor,
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
