import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:pinput/pinput.dart';

//ignore: must_be_immutable
class CustomCodeField extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final String? Function(String?)? validator;

  CustomCodeField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Pinput(
        validator: validator,
        length: 6,
        keyboardType: TextInputType.number,
        controller: controller,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        textInputAction: TextInputAction.next,
        showCursor: true,
        onCompleted: null,
        defaultPinTheme: PinTheme(
          width: 60,
          height: 60,
          textStyle: TextStyles().textStylesMontserrat(fontSize: 32),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey, width: 2),
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
          ),
        ),
        focusedPinTheme: PinTheme(
          width: 60,
          height: 60,
          textStyle: TextStyles().textStylesMontserrat(fontSize: 32),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryBlue,  width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}