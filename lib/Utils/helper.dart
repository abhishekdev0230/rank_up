import 'dart:io';
import 'dart:math' as math;
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rank_up/services/local_storage.dart';

import '../constraints/my_colors.dart';

class Helper {
  ///.......Email validation...............
  static bool emailValidation(String email) {
    final bool emailValid =
        RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
            .hasMatch(email);

    return emailValid;
  }

  ///--------------Access Token-------------------
  static Future<String> getAccessToken() async {
    String access = await StorageManager.readData(StorageManager.accessToken);
    return access;
  }

  ///.......Password validation...............
  static String? isPasswordValidationTest(String em) {
    String? msg;

    String repExpCount = r'.{6,}';
    RegExp regExpC = RegExp(repExpCount);

    // String repExpUpper = r'(?=.*[A-Z])';
    // RegExp regExpU = RegExp(repExpUpper);
    //
    // String repExpLower = r'(?=.*[a-z])';
    // RegExp regExpL = RegExp(repExpLower);
    //
    // String repExpDigit = r'(?=.*?[0-9])';
    // RegExp regExpD = RegExp(repExpDigit);
    //
    // String repExpSpecial = r'(?=.*?[!@#\$&*~])';
    // RegExp regExpS = RegExp(repExpSpecial);

    if (!regExpC.hasMatch(em)) {
      msg = "Password must be of at least 6 characters in length";
    }
    // else if (!regExpU.hasMatch(em)) {
    //   msg = "Password must contain upper";
    // } else if (!regExpL.hasMatch(em)) {
    //   msg = "Password must contain lower case";
    // } else if (!regExpD.hasMatch(em)) {
    //   msg = "Password must contain digit";
    // } else if (!regExpS.hasMatch(em)) {
    //   msg = "Password must contain Special character";
    // }
    else {
      msg = null;
    }
    return msg;
  }

  ///.........Toast..........
  // static customToast(String msg) {
  //   return Fluttertoast.showToast(
  //     msg: msg,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 0,
  //     backgroundColor: MyColors.appTheme,
  //     textColor: Colors.white,
  //     fontSize: 16.0,
  //   );
  // }
  static customToast(String msg, {ToastGravity gravity = ToastGravity.BOTTOM}) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 0,
      backgroundColor: MyColors.blackColor,
      textColor: MyColors.whiteText,

      fontSize: 15.0,
    );
  }


  ///--------------Access Token-------------------
  // static Future<String> getAccessToken() async{
  //   String access = await StorageManager.readData(StorageManager.accessToken);
  //   return access;
  // }

  /// Date Format
  static String getDateFormatAccording(DateTime date) {
    var formatter = DateFormat('yyyy-dd-MM');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  ///--------------InternetConnection------------

  static Future<bool> checkInternetConnection() async {
    bool isConnected = true;
    // final List<ConnectivityResult> connectivityResult =
    //  await (Connectivity().checkConnectivity());
    //  // debugPrint("asdfg : ${connectivityResult.contains(ConnectivityResult.wifi)}");
    //  if (connectivityResult.contains(ConnectivityResult.mobile)) {
    //    isConnected = true;
    //  }
    //  else if(connectivityResult.contains(ConnectivityResult.wifi)){
    //    isConnected = true;
    //  }
    //  else {
    //    Helper.customToast("No Internet Connection");
    //  }
    return isConnected;
  }

  ///--------------  Loader  -----------------------
  static progressLoadingDialog(BuildContext context, bool status) {
    if (status) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.appTheme,
            ),
          );
        },
      );
      // return pr.show();
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      // return pr.hide();
    }
  }


  static void showError(String message, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}



///........image cumpresser.....
// Future<File?> compressImage(File file) async {
//   // Generate unique target path
//   final dir = file.parent.path;
//   final fileName = path.basenameWithoutExtension(file.path);
//   final targetPath = '$dir/${fileName}_compressed.jpg';
//
//   final result = await FlutterImageCompress.compressAndGetFile(
//     file.absolute.path,
//     targetPath,
//     quality: 70,
//     minWidth: 800,
//     minHeight: 800,
//   );
//
//   return result != null ? File(result.path) : null;
// }



class CommonUtils {
  static void showSnackBar(BuildContext context, String message,
      { Color textColor = Colors.white}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            style: TextStyle(color: textColor),
          ),
        ),
        backgroundColor: Colors.black,
        // behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}




/// ✅ Custom dotted line painter
class DottedLine extends StatelessWidget {
  const DottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedLinePainter(),
      size: const Size(double.infinity, 1),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double dotWidth = 2;
    const double space = 4;
    final paint = Paint()
      ..color = MyColors.color949494
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dotWidth, 0),
        paint,
      );
      startX += dotWidth + space;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
class HalfCirclePainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;

  HalfCirclePainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
    this.strokeWidth = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 1.6;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi, // start angle (left side)
      math.pi, // sweep angle (180° for half circle)
      false,
      backgroundPaint,
    );

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi * progress, // progress-based sweep
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
class RoundedCircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  RoundedCircularProgressPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint basePaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // smooth edge

    final Paint progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // 👈 rounded progress ends

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (strokeWidth / 2);

    // Draw background circle
    canvas.drawCircle(center, radius, basePaint);

    // Draw progress arc
    final sweepAngle = 2 * 3.1415926535 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.1415926535 / 0.8, // start from top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
