import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/utils/utils.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';
import 'package:jashoda_transport/core/widgets/textformfield/common_textfield.dart';

//ignore: must_be_immutable
class CompanyNameWidget extends StatelessWidget {
  CompanyNameWidget({required this.controller, super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.companyName,
          style: TextStyles().textStylesMontserrat(
            fontSize: 16,
          ),
        ),
        Dimentions.sizedBox4H,
        CommonTextField(
          controller: controller,
          hintText: AppStrings.enterCompanyName,
          prefixIconButton: ImageAssets(image: AssetsPath.companyIcon),
          validator: (value) {
            return Utils().requiredValidator(value ?? '');
          },
        )
      ],
    );
  }
}
