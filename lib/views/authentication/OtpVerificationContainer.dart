import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';

class OtpVerificationContainer extends StatefulWidget {
  final dynamic lang;
  final String phoneNumber;
  final String countryCode;
  final VoidCallback onOtpVerified;

  const OtpVerificationContainer({
    super.key,
    required this.lang,
    required this.phoneNumber,
    required this.countryCode,
    required this.onOtpVerified,
  });

  @override
  State<OtpVerificationContainer> createState() =>
      _OtpVerificationContainerState();
}

class _OtpVerificationContainerState extends State<OtpVerificationContainer> {
  String otpCode = "";
  int resendCountdown = 48;

  @override
  Widget build(BuildContext context) {
    final lang = widget.lang;

    return Container(
      height: context.hp(0.45),
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lang.verifyAccountWithOTP,
              style: semiBoldTextStyle(fontSize: 28, color: MyColors.blackColor),
            ),
            SizedBox(height: 8),
            Text(
              lang.otpSentMessage.replaceAll(
                '{phone}',
                '${widget.countryCode} ${widget.phoneNumber}',
              ),
              style: mediumTextStyle(fontSize: 18, color: MyColors.color949494),
            ),
            SizedBox(height: 40),
        
            /// OTP 4-box field
            OtpTextField(
              numberOfFields: 4,
              borderColor: MyColors.appTheme,
              cursorColor: MyColors.appTheme,
              enabledBorderColor: MyColors.color949494,
              focusedBorderColor: MyColors.appTheme,
              showFieldAsBox: true,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              fieldWidth: 67,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              fieldHeight: 57,
              onSubmit: (String verificationCode) {
                widget.onOtpVerified();
              },
            ),
            SizedBox(height: 30),
            Text(
              lang.didntReceiveCode,
              style: boldTextStyle(fontSize: 16, color: MyColors.blackColor),
            ),
            SizedBox(height: 30),
            Text(
              '${lang.resendCodeIn} $resendCountdown s',
              style: mediumTextStyle(fontSize: 16, color: MyColors.blackColor),
            ),
          ],
        ),
      ),
    );
  }
}
