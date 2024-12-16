import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';

class CheckButton extends StatelessWidget {
  final void Function()? onChanged;
  final String title;
  final Key? imageKey;
  final double height;
  final Widget? iconWidget;
  final Color backGroundColor;
  final Color borderColor;
  final Color textColor;

  const CheckButton({
    super.key,
    required this.onChanged,
    required this.title,
    this.imageKey,
    required this.height,
    this.iconWidget,
    this.backGroundColor = AppColors.primaryBlue,
    this.borderColor = AppColors.greyLight,
    this.textColor = AppColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: height,
      child: TextButton(
        onPressed: onChanged,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: backGroundColor,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: borderColor)
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
      mainAxisSize: MainAxisSize.min,
      children: [
        iconWidget ?? const SizedBox.shrink(),
        Text(
          title,
          style: TextStyles().textStylesMontserrat(
            fontSize: 14,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}