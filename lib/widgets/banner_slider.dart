import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/data/model/banner_model.dart';
import 'package:ecommerce/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  List<BannerModel> bannerList;
  BannerSlider({super.key, required this.bannerList});

  @override
  Widget build(BuildContext context) {
    var controller = PageController(viewportFraction: 0.9);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          child: PageView.builder(
            controller: controller,
            itemCount: bannerList.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  child: CachedImage(
                    imageUrl: bannerList[index].thumbnail!,
                    radius: 15,
                  ));
            },
          ),
        ),
        Positioned(
          bottom: 10,
          child: SmoothPageIndicator(
            controller: controller,
            count: bannerList.length,
            effect: const ExpandingDotsEffect(
              expansionFactor: 4.5,
              dotHeight: 8,
              dotWidth: 8,
              dotColor: Colors.white,
              activeDotColor: CustomColors.blueIndicator,
            ),
          ),
        )
      ],
    );
  }
}
