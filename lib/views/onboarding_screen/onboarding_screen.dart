import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/Utils/CommonButton.dart';
import 'package:rank_up/Utils/languages.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/provider/provider_classes/OnboardingProvider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../authentication/RankUpLoginScreen.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final lang = context.lang;

    final onboardingData = [
      {
        "image": IconsPath.onboarding1,
        "title": lang.onboardingTitle1,
        "title1": lang.onboardingTitle11,
        "desc": lang.onboardingDesc1,
      },
      {
        "image": IconsPath.onboarding2,
        "title": lang.onboardingTitle2,
        "title1": lang.onboardingTitle22,
        "desc": lang.onboardingDesc2,
      },
      {
        "image": IconsPath.onboarding3,
        "title": lang.onboardingTitle3,
        "title1": lang.onboardingTitle33,
        "desc": lang.onboardingDesc3,
      },
      {
        "image": IconsPath.onboarding4,
        "title": lang.onboardingTitle4,
        "title1": lang.onboardingTitle44,
        "desc": lang.onboardingDesc4,
      },
    ];

    void _nextPage(OnboardingProvider provider) {
      if (provider.currentPage < onboardingData.length - 1) {
        _controller.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    }

    return Scaffold(
      backgroundColor: MyColors.rankBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: Consumer<OnboardingProvider>(
                  builder: (context, provider, _) {
                    return PageView.builder(
                      controller: _controller,
                      itemCount: onboardingData.length,
                      onPageChanged: (index) => provider.setPage(index),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            hSized25,
                            SvgPicture.asset(
                              IconsPath.appLogoAppTheme,
                              height: 78,
                            ),
                            hSized25,
                            Flexible(
                              flex: 4,
                              child: Image.asset(
                                onboardingData[index]["image"]!,
                                fit: BoxFit.contain,
                              ),
                            ),
                            hSized15,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  onboardingData[index]["title"]!,
                                  style: semiBoldTextStyle(
                                    fontSize: 27,
                                    color:
                                        (provider.currentPage !=
                                            onboardingData.length - 1)
                                        ? MyColors.color19B287
                                        : MyColors.blackColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                wSized5,
                                Text(
                                  onboardingData[index]["title1"]!,
                                  style: semiBoldTextStyle(
                                    fontSize: 27,
                                    color:
                                        (provider.currentPage !=
                                            onboardingData.length - 1)
                                        ? MyColors.blackColor
                                        : MyColors.color19B287,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            hSized8,
                            Text(
                              onboardingData[index]["desc"]!,
                              style: semiBoldTextStyle(
                                fontSize: 16,
                                color: MyColors.color949494,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),

              // Bottom Buttons
              Consumer<OnboardingProvider>(
                builder: (context, provider, _) {
                  return Column(
                    children: [
                      if (provider.currentPage != onboardingData.length - 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => CustomNavigator.pushRemoveUntil(
                                context,
                                RankUpLoginScreen(),
                              ),
                              child: Text(
                                lang.skip,
                                style: semiBoldTextStyle(
                                  color: MyColors.color0036A4,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            CommonButton(
                              borderRadius: 30,
                              iconRight: Icon(Icons.arrow_forward_ios_sharp,color: MyColors.whiteText,size: 12,),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              text: lang.next,

                              onPressed: () => _nextPage(provider),
                            ),

                          ],
                        ),
                      if (provider.currentPage == onboardingData.length - 1)
                        CommonButton(
                          text: lang.signIn,
                          onPressed: () {
                            CustomNavigator.pushRemoveUntil(
                              context,
                              RankUpLoginScreen(),
                            );
                          },
                        ),
                      hSized30,
                      SmoothPageIndicator(
                        controller: _controller,
                        count: onboardingData.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: context.wp(0.02),
                          dotWidth: context.wp(1 / 8.6),
                          expansionFactor: 4.5,
                          spacing: context.wp(0.02),
                          dotColor: MyColors.whiteText,
                          activeDotColor: MyColors.appTheme,
                        ),
                      ),
                      hSized15,
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
