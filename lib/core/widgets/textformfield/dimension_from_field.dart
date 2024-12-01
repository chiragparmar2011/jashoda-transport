import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';

class DimensionFromField extends StatelessWidget {
  DimensionFromField({
    required this.controller,
    required this.hintText,
    super.key,
  });

  TextEditingController controller = TextEditingController();
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        scrollPadding: EdgeInsets.zero,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 16,bottom: 0,right: 0,top: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.black)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: AppColors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: AppColors.black,
            ),
          ),
          filled: true,
          hintText: hintText,
          helperStyle: TextStyles().textStylesMontserrat(
            fontSize: 12,
            color: AppColors.darkGrey,
          ),
          fillColor: AppColors.white,
        ),
      ),
    );
  }
}
