import 'package:flutter/material.dart';
import 'package:qldt/ui/widgets/textfields/app_text_field.dart';

class AppEmailInput extends AppTextField {
  const AppEmailInput({
    Key? key,
    TextEditingController? controller,
    String? hintText,
    TextInputType? keyboardType,
  }) : super(
          key: key,
          controller: controller,
          hintText: hintText,
          keyboardType: keyboardType,
        );
}
