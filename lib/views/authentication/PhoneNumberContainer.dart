import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import '../../custom_classes/my_textfield.dart';

class PhoneNumberContainer extends StatefulWidget {
  final dynamic lang;
  final Function(String phone, String countryCode)? onSignInTap;


  const PhoneNumberContainer({super.key, required this.lang, this.onSignInTap});

  @override
  State<PhoneNumberContainer> createState() => _PhoneNumberContainerState();
}

class _PhoneNumberContainerState extends State<PhoneNumberContainer> {
  final TextEditingController phoneController = TextEditingController();
  bool rememberMe = false;
  String countryCode = '+91';

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.lang;

    return Container(
      key: const ValueKey('otpContainer'),
      height: context.hp(0.60),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: MyColors.whiteText,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(
        horizontal: context.wp(0.05),
        vertical: context.hp(0.03),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Top Section (Scrollable content)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

                  /// ✅ Phone Number Field
                  CommonTextField(
                    maxLength: 10,
                    controller: phoneController,
                    label: lang.phoneNumber,
                    keyboardType: TextInputType.phone,
                    prefixIcon: Container(
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

                  /// ✅ "Remember Me" checkbox
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        child: Checkbox(
                          value: rememberMe,
                          activeColor: MyColors.appTheme,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value ?? false;
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
                  CommonButton(
                    borderRadius: 30,
                    text: lang.signIn,
                    textColor: MyColors.whiteText,
                    backgroundColor: MyColors.appTheme,
                    onTap: () {
                      if (widget.onSignInTap != null) {
                        widget.onSignInTap!(phoneController.text, countryCode); // pass phone + country code
                      }
                    },
                  ),

                  hSized20,
                  /// ✅ "Or Continue With" — with dotted lines

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
                  CommonButton(
                    borderRadius: 30,
                    text: lang.signInWithGoogle,
                    icon: SvgPicture.asset(
                      IconsPath.googleWithColore,
                      height: context.hp(0.025),
                    ),
                    textColor: MyColors.whiteText,
                    backgroundColor: MyColors.appTheme,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),



          /// 🔹 Bottom Fixed Button

        ],
      ),
    );
  }
}
