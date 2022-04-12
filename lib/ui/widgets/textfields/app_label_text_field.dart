import 'package:flutter/material.dart';
import 'package:qldt/common/app_text_style.dart';
import 'package:qldt/ui/widgets/textfields/app_text_field.dart';

class AppLabelTextField extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final String? hintText;
  final TextEditingController? controller;

  const AppLabelTextField({
    Key? key,
    required this.title,
    this.titleStyle,
    this.hintText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: titleStyle ?? AppTextStyle.color10182BS14w500,
        ),
        const SizedBox(height: 5,),
        AppTextField(
          hintText: hintText,
          controller: controller,
        ),
      ],
    );
  }
}
