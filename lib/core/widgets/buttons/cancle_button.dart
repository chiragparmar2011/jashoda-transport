import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';

class CancelButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final double height;
  final double width;

  const CancelButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height = 48,
    required this.width,
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
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.greyLightWhite,
          side: const BorderSide(color: AppColors.greyLight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _buildRow(),
      ),
    );
  }

  Widget _buildRow() {
    return Text(
      title,
      style: TextStyles().textStylesMontserrat(
        fontSize: 16,
        color: AppColors.black
      ),
    );
  }
}
