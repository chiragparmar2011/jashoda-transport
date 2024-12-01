import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';

class DimensionWidget extends StatelessWidget {
  const DimensionWidget({
    required this.unitName,
    required this.selectedTextColor,
    required this.selectBgColor,
    required this.onTap,
    super.key,
  });

  final String unitName;
  final Color selectedTextColor;
  final Color selectBgColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.greyWhite),
          color: selectBgColor,
        ),
        child: Text(
          unitName,
          style: TextStyles().textStylesMontserrat(
            fontSize: 12,
            color: selectedTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
