import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rank_up/Utils/CommonButton.dart';
import 'package:rank_up/Utils/languages.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/font_family.dart';

class RankUpLoginScreen extends StatelessWidget {
  const RankUpLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.lang;

    return Scaffold(
      backgroundColor: MyColors.appTheme,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: context.hp(0.05)),
            SvgPicture.asset(IconsPath.appLogoWhite, height: 135),

            Text(
              lang.subjectPractice,
              style: mediumTextStyle(
                fontSize: context.hp(0.018),
                color: MyColors.whiteText.withOpacity(0.7),
              ),
            ),

            SizedBox(height: context.hp(0.08)),
            Text(
              lang.welcomeRankUp,
              style: semiBoldTextStyle(
                fontSize: 28,
                color: MyColors.whiteText,
              ),
            ),

            SizedBox(height: context.hp(0.02)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                lang.buildKnowledge,
                textAlign: TextAlign.center,
                style: regularTextStyle(
                  fontSize: 18,
                  color: MyColors.whiteText,
                ),
              ),
            ),

            Spacer(),
            Container(
              height: context.hp(0.45),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: MyColors.whiteText,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: context.wp(0.05),
                vertical: context.hp(0.03),
              ),
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      lang.signIn,
                      style: semiBoldTextStyle(
                        fontSize: context.hp(0.022),
                        color: MyColors.blackColor,
                      ),
                    ),
                  ),
                  SizedBox(height: context.hp(0.03)),

                  // Google Sign-In Button
                  CommonButton(
                    borderRadius: 30,
                    text: lang.signInWithGoogle,
                    iconLeft: SvgPicture.asset(
                      IconsPath.googleIcon,
                      height: context.hp(0.025),
                    ),
                    textColor: MyColors.whiteText,
                    borderColor: Colors.transparent,
                    onPressed: () {},
                  ),
                  SizedBox(height: context.hp(0.02)),

                  CommonButton(
                    borderRadius: 30,
                    text: lang.signInWithApple,
                    iconLeft: SvgPicture.asset(
                      IconsPath.appleIcon,
                      height: context.hp(0.028),
                    ),
                    color: MyColors.rankBg,
                    textColor: MyColors.blackColor,
                    onPressed: () {},
                  ),
                  SizedBox(height: context.hp(0.02)),

                  CommonButton(
                    borderRadius: 30,
                    text: lang.signInWithGithub,
                    iconLeft: SvgPicture.asset(
                      IconsPath.githubIcon,
                      height: context.hp(0.028),
                    ),
                    color: MyColors.rankBg,
                    textColor: MyColors.blackColor,
                    onPressed: () {},
                  ),

                  const Spacer(),

                  // Terms Text
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: context.hp(0.01,),right:context.hp(0.04,),left:context.hp(0.04,) ),
                      child: Text.rich(
                        TextSpan(
                          text: lang.bySigningUpText,
                          style: regularTextStyle(
                            color: MyColors.color949494,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: lang.termsAndConditions,
                              style: regularTextStyle(
                                color: MyColors.appTheme,
                                fontSize: 14,
                              ),
                            ),
                            const TextSpan(text: 'and '),
                            TextSpan(
                              text: lang.privacyPolicy,
                              style: regularTextStyle(
                                color: MyColors.appTheme,
                                fontSize:14,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
