import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';

class CommonProgressIndicator extends StatelessWidget {
  const CommonProgressIndicator({this.color = AppColors.white, super.key});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: color);
  }
}
