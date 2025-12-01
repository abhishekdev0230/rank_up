import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/custom_classes/my_textfield.dart';
import 'package:rank_up/provider/provider_classes/otp_provider.dart';

import '../../custom_classes/custom_navigator.dart';
import '../../provider/provider_classes/LoginOptionContainer.dart';
import '../../services/local_storage.dart';
import '../bottom_navigation_bar.dart';
import 'ProfileSetupContainer.dart';

class PhoneNumberContainer extends StatefulWidget {
  final dynamic lang;
  final Function(String phone, String countryCode, bool rememberMe)? onSignInTap;

  const PhoneNumberContainer({
    super.key,
    required this.lang,
    this.onSignInTap,
  });

  @override
  State<PhoneNumberContainer> createState() => _PhoneNumberContainerState();
}

class _PhoneNumberContainerState extends State<PhoneNumberContainer> {
  final TextEditingController phoneController = TextEditingController();

  bool rememberMeBu = false;
  String countryCode = '+91';

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.lang;
    final otpProvider = Provider.of<OtpProvider>(context);

    return Container(
      key: const ValueKey('otpContainer'),
      height: context.hp(0.60),
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(
        horizontal: context.wp(0.05),
        vertical: context.hp(0.03),
      ),
      decoration: const BoxDecoration(
        color: MyColors.whiteText,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 👋 Header Texts
                  Text(
                    lang.helloThere,
                    style: semiBoldTextStyle(
                      fontSize: 28,
                      color: MyColors.blackColor,
                    ),
                  ),
                  hSized8,
                  Text(
                    lang.pleaseEnterYour,
                    style: mediumTextStyle(
                      fontSize: 18,
                      color: MyColors.color949494,
                    ),
                  ),
                  hSized30,

                  /// 📱 Phone Number Field with Country Code
                  CommonTextField(
                    maxLength: 10,
                    controller: phoneController,
                    label: lang.phoneNumber,
                    keyboardType: TextInputType.phone,
                    prefixIcon: SizedBox(
                      width: 90,
                      child: CountryCodePicker(
                        padding: EdgeInsets.zero,
                        onChanged: (code) {
                          setState(() {
                            countryCode = code.dialCode ?? '+91';
                          });
                        },
                        initialSelection: 'IN',
                        favorite: const ['+91', 'US'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                        textStyle: mediumTextStyle(
                          fontSize: 16,
                          color: MyColors.blackColor,
                        ),
                      ),
                    ),
                  ),

                  hSized10,

                  /// ☑️ Remember Me Checkbox
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        child: Checkbox(
                          value: rememberMeBu,
                          activeColor: MyColors.appTheme,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (value) {
                            setState(() {
                              rememberMeBu = value ?? false;

                            });
                          },
                        ),
                      ),
                      wSized10,
                      Text(
                        lang.rememberMe,
                        style: mediumTextStyle(
                          fontSize: 16,
                          color: MyColors.blackColor,
                        ),
                      ),
                    ],
                  ),

                  hSized20,

                  /// 🔘 Sign In Button
                  CommonButton(
                    borderRadius: 30,
                    text: otpProvider.isLoading
                        ? "Please wait..."
                        : lang.signIn,
                    textColor: MyColors.whiteText,
                    backgroundColor: MyColors.appTheme,
                    onTap: otpProvider.isLoading
                        ? () {}
                        : () async {
                      final success = await otpProvider.sendOtp(
                        context: context,
                        phoneNumber: phoneController.text,
                        countryCode: countryCode,
                      );

                      if (success) {
                        widget.onSignInTap?.call(
                          phoneController.text,
                          countryCode,
                          rememberMeBu,
                        );
                      }
                    },
                  ),

                  hSized20,

                  /// --- OR CONTINUE WITH ---
                  Row(
                    children: [
                      const Expanded(child: DottedLine()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          lang.orContinueWith,
                          style: boldTextStyle(
                            fontSize: 14,
                            color: MyColors.color949494,
                          ),
                        ),
                      ),
                      const Expanded(child: DottedLine()),
                    ],
                  ),

                  hSized20,

                  /// 🔹 Google Sign-In Button
                  CommonButton(
                    borderRadius: 30,
                    text: lang.signInWithGoogle,
                    icon: SvgPicture.asset(
                      IconsPath.googleWithColore,
                      height: context.hp(0.025),
                    ),
                    textColor: MyColors.whiteText,
                    backgroundColor: MyColors.appTheme,
                    onTap: () async {
                      final authProvider = Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      );

                      final result = await authProvider.login(context);

                      if (result != null && result["success"] == true) {
                        final data = result["data"];
                        final profileComplete = data != null
                            ? (data["profileComplete"] ?? false)
                            : false;

                        if (profileComplete.toString().toLowerCase() == "true") {
                          await StorageManager.savingData(StorageManager.isLogin, true);
                          if (!context.mounted) return;
                          CustomNavigator.pushRemoveUntil(
                            context,
                            BottomNavController(initialIndex: 0),
                          );
                        } else {
                          if (!context.mounted) return;
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => ProfileSetupContainer(lang: lang),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Google Sign-In canceled or failed.'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
