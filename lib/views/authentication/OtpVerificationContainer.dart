
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/provider/provider_classes/otp_provider.dart';
import 'package:rank_up/services/local_storage.dart';
import 'package:rank_up/views/bottom_navigation_bar.dart';

class OtpVerificationContainer extends StatefulWidget {
  final dynamic lang;
  final String phoneNumber;
  final String countryCode;
  final String rememberMe;
  final VoidCallback onOtpVerified;

  const OtpVerificationContainer({
    super.key,
    required this.lang,
    required this.phoneNumber,
    required this.countryCode,
    required this.rememberMe,
    required this.onOtpVerified,
  });

  @override
  State<OtpVerificationContainer> createState() =>
      _OtpVerificationContainerState();
}

class _OtpVerificationContainerState extends State<OtpVerificationContainer> {
  int _secondsRemaining = 48;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    print("rememberMeBu${widget.rememberMe}");
  }

  void _startTimer() {
    _secondsRemaining = 48;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.lang;
    final otpProvider = Provider.of<OtpProvider>(context);

    return Container(
      height: context.hp(0.49),
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
              style: semiBoldTextStyle(
                fontSize: 26,
                color: MyColors.blackColor,
              ),
            ),
            SizedBox(height: context.hp(0.03)),
            Text(
              lang.otpSentMessage.replaceAll(
                '{phone}',
                '${widget.countryCode} ${widget.phoneNumber}',
              ),
              style: mediumTextStyle(
                fontSize: 18,
                color: MyColors.color949494,
              ),
            ),
            SizedBox(height: context.hp(0.03)),

            /// OTP Input Fields
            OtpTextField(
              numberOfFields: 6,
              borderColor: MyColors.appTheme,
              cursorColor: MyColors.appTheme,
              enabledBorderColor: MyColors.color949494,
              focusedBorderColor: MyColors.appTheme,
              showFieldAsBox: true,
              contentPadding: EdgeInsets.zero,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              onSubmit: (String code) async {
                otpProvider.setOtp(code);

                final result = await otpProvider.verifyOtp(
                  context: context,
                  phoneNumber: widget.phoneNumber,
                  rememberMe: widget.rememberMe,
                );

                if (result?["success"] == true) {
                  if (result?["profileComplete"] == true) {
                    await StorageManager.savingData(StorageManager.isLogin, true);
                    CustomNavigator.pushRemoveUntil(
                      context,
                      BottomNavController(initialIndex: 0),
                    );
                  } else {
                    widget.onOtpVerified();
                  }
                }
              },

            ),

            SizedBox(height: context.hp(0.03)),
            Text(
              lang.didntReceiveCode,
              style: boldTextStyle(
                fontSize: 16,
                color: MyColors.blackColor,
              ),
            ),
            SizedBox(height: context.hp(0.03)),

            /// ✅ Timer or Resend text
            GestureDetector(
              onTap: _canResend
                  ? () async {
                final sent = await otpProvider.sendOtp(
                  context: context,
                  phoneNumber: widget.phoneNumber,
                  countryCode: widget.countryCode,
                );

                if (sent) {
                  if (mounted) {
                    setState(() {
                      _secondsRemaining = 48;
                      _canResend = false;
                    });
                    _startTimer();
                  }
                }
              }
                  : null,

              child: Text(
                _canResend
                    ? "Resend Code"
                    : '${lang.resendCodeIn} $_secondsRemaining s',
                style: mediumTextStyle(
                  fontSize: 16,
                  color: _canResend
                      ? MyColors.appTheme
                      : MyColors.color949494,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
