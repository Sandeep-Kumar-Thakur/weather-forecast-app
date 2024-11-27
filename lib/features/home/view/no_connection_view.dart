import 'package:flutter/material.dart';

import '../../../core/app_strings.dart';
import '../../../core/app_text_style.dart';

class NoConnectionView extends StatelessWidget {
  const NoConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.network_wifi_rounded,
              size: 50,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              AppStrings.noInternet,
              style: AppTextStyle.s18w500,
            ),
          ],
        ));
  }
}
