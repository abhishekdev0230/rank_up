import 'package:flutter/material.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';

class ConfirmDialog {
  static Future<bool?> show(
      BuildContext context, {
        String? title,
        required String message,
        String confirmText = "Confirm",
        String cancelText = "Cancel",
        Color confirmColor = MyColors.color19B287,
        Color cancelColor = Colors.transparent,
        Color messageColor = Colors.black,
        double messageSize = 20,
      }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: MyColors.whiteText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null && title.isNotEmpty) ...[
                  Text(
                    title,
                    style: semiBoldTextStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                ],
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: semiBoldTextStyle(fontSize: messageSize, color: messageColor),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: confirmColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          confirmText,
                          style: mediumTextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: confirmColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          cancelText,
                          style: mediumTextStyle(fontSize: 14, color: confirmColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

