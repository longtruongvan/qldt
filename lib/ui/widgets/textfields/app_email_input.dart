import 'package:flutter/material.dart';
import 'package:qldt/ui/widgets/textfields/app_text_field.dart';

class AppEmailInput extends AppTextField {
  const AppEmailInput({
    Key? key,
    TextEditingController? controller,
    String? hintText,
    String? errorText,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
  }) : super(
          key: key,
          controller: controller,
          hintText: hintText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          errorText: null,
        );
}
