import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/utils/utils.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';
import 'package:jashoda_transport/core/widgets/textformfield/common_textfield.dart';

//ignore: must_be_immutable
class EmailAddressWidget extends StatelessWidget {
  EmailAddressWidget({required this.controller, super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.emailAddress,
          style: TextStyles().textStylesMontserrat(
            fontSize: 16,
          ),
        ),
        Dimentions.sizedBox4H,
        CommonTextField(
          controller: controller,
          hintText: 'eg. mansi@gmail.com',
          prefixIconButton: ImageAssets(image: AssetsPath.emailIcon),
          validator: (value) {
            return Utils().emailValidator(value ?? '');
          },
        )
      ],
    );
  }
}
