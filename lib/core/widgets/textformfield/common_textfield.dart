import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';

//ignore: must_be_immutable
class CommonTextField extends StatelessWidget {
  CommonTextField({
    required this.controller,
    this.hintText,
    this.enable = true,
    this.enabled = true,
    this.initialValue,
    this.labelText,
    this.suffixIconButton,
    this.obscureText = false,
    this.validator,
    this.isSetting = false,
    this.keyboardType,
    this.obscuringCharacter,
    this.errorMaxLines,
    this.maxLines,
    super.key,
    this.onTab,
    this.prefixIconButton,
    this.inputFormatters,
    this.hintFontSize = 14,
    this.onChanged,
    this.onFocusChange,
  });

  TextEditingController controller = TextEditingController();
  final Widget? suffixIconButton;
  final Widget? prefixIconButton;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? labelText;
  final bool obscureText;
  final bool enable;
  final bool enabled;
  final String? Function(String?)? validator;
  final bool isSetting;
  final String? obscuringCharacter;
  final int? errorMaxLines;
  final int? maxLines;
  final VoidCallback? onTab;
  List<TextInputFormatter>? inputFormatters;
  double hintFontSize;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChange;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: onFocusChange,
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: obscureText,
        obscuringCharacter: "*",
        onTap: onTab,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: (validator != null) ? validator : null,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        style: const TextStyle(
          decoration: TextDecoration.none,
          decorationThickness: 0,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: AppColors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: AppColors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: AppColors.grey,
            ),
          ),
          counterText: '',
          errorMaxLines: errorMaxLines,
          fillColor: AppColors.white,
          filled: true,
          hintText: hintText!,
          hintStyle: TextStyles().textStylesMontserrat(
            color: AppColors.darkGrey,
            fontSize: hintFontSize,
          ),
          suffixIcon: suffixIconButton,
          prefixIcon: prefixIconButton,
        ),
      ),
    );
  }
}