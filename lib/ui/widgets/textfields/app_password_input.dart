import 'package:flutter/material.dart';
import 'package:qldt/ui/widgets/textfields/app_text_field.dart';

class AppPasswordInput extends AppTextField {
  const AppPasswordInput({
    Key? key,
    TextEditingController? controller,
    String? hintText,
    String? errorText,
    TextInputType? keyboardType,
    bool? obscureText, // properties text input password
    bool? enableSuggestions, // properties text input password
    bool? autoCorrect, // properties text input password
    String? obscuringCharacter,
    Widget? suffixIcon,
    TextInputAction? textInputAction,
  }) : super(
    key: key,
    controller: controller,
    hintText: hintText,
    keyboardType: keyboardType,
    obscureText: obscureText,
    enableSuggestions: enableSuggestions,
    autoCorrect: autoCorrect,
    suffixIcon: suffixIcon,
    textInputAction: textInputAction,
    errorText: null,
  );
}
