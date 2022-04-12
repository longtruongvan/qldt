import 'package:flutter/material.dart';
import 'package:qldt/common/app_text_style.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;

  const AppTextField({
    Key? key,
    this.controller,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          cursorColor: Colors.red,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyle.color10182BS56,
              // isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  )
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.green,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.yellow,
                ),
              )
          ),
        ),
        TextFormField(
          controller: controller,
          cursorColor: Colors.red,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 56
              ),
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  )
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.green,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.yellow,
                ),
              )
          ),
        )
      ],
    );
  }
}
