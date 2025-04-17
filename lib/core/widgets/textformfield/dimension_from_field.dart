import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';

class DimensionFromField extends StatelessWidget {
  DimensionFromField({
    required this.controller,
    required this.hintText,
    required this.label,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles().textStylesMontserrat(
            fontSize: 14,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
            scrollPadding: EdgeInsets.zero,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.black),
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
              hintStyle: TextStyles().textStylesMontserrat(
                fontSize: 12,
                color: AppColors.darkGrey,
              ),
              fillColor: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
