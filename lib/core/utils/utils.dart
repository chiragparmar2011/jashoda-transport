import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';

class Utils {
  static successMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyles().textStyle14Black),
        backgroundColor: AppColors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static errorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyles().textStyle14Black),
        backgroundColor: AppColors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String? requiredValidator(String value) {
    if ((value).isEmpty) {
      return 'Required field';
    }
    return null;
  }

  String? emailValidator(String value) {
    RegExp emailRegexp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if ((value).isEmpty) {
      return 'Required field';
    } else if (!emailRegexp.hasMatch(value)) {
      return 'Please enter valid email';
    }
    return null;
  }

  String? numberValidator(String value) {
    RegExp mobileNoRegex = RegExp(r'^[6-9]\d{9}$');

    if ((value).isEmpty) {
      return 'Required field';
    } else if (!mobileNoRegex.hasMatch(value)) {
      return 'Please enter valid number';
    }
    return null;
  }

  String formattedDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }
}
