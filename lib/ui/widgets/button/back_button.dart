import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_images.dart';

class AppBackButton extends StatelessWidget {
  final Function() eventHandler;

  const AppBackButton({
    Key? key,
    required this.eventHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        eventHandler();
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.whiteColor,
          border: Border.all(
            color: AppColors.grayColor,
            width: 1,
          ),
        ),
        child: Image.asset(
          AppImages.icBack,
          width: 16,
          height: 16,
        ),
      ),
    );
  }
}
