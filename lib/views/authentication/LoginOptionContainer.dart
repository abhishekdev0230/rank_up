import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rank_up/Utils/CommonButton.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';

class LoginOptionContainer extends StatelessWidget {
  final dynamic lang;
  final VoidCallback onMobileLoginTap;

  const LoginOptionContainer({
    super.key,
    required this.lang,
    required this.onMobileLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('loginOption'),
      height: context.hp(0.37),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: MyColors.whiteText,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.wp(0.05),
        vertical: context.hp(0.03),
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              lang.signIn,
              style: semiBoldTextStyle(
                fontSize: 28,
                color: MyColors.blackColor,
              ),
            ),
          ),
          SizedBox(height: context.hp(0.03)),

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
            text: lang.signInWithMobileNumber,
            iconLeft: SvgPicture.asset(
              IconsPath.phoneIcon,
              height: context.hp(0.028),
            ),
            color: MyColors.rankBg,
            textColor: MyColors.blackColor,
            onPressed: onMobileLoginTap,
          ),

          const Spacer(),

          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.hp(0.04)),
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
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: lang.privacyPolicy,
                      style: regularTextStyle(
                        color: MyColors.appTheme,
                        fontSize: 14,
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
    );
  }
}
