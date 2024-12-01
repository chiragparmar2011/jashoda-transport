import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/widgets/dialog/common_progress_indicator.dart';

class CustomButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final bool isLoading;
  final Key? imageKey;

  const CustomButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    required this.isLoading,
    this.imageKey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading ? _buildProgressIndicator() : _buildRow(),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return const CommonProgressIndicator(color: AppColors.white);
  }

  Widget _buildRow() {
    return Text(
      title,
      style: TextStyles().textStylesMontserrat(
        fontSize: 16,
      ),
    );
  }
}
