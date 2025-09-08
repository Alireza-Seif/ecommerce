import 'package:ecommerce/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 60,
        width: 60,
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
          colors: [CustomColors.blueIndicator],
        ),
      ),
    );
  }
}
