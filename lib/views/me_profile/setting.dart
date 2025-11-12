import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rank_up/Utils/ConfirmDialog.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/services/local_storage.dart';
import 'package:rank_up/views/authentication/RankUpLoginScreen.dart';

import 'StaticPageScreenPriTermAbout.dart';

class SettingsSheet {
  /// Show the settings bottom sheet
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          decoration: BoxDecoration(
            color: MyColors.rankBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ---------- Header ----------
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(IconsPath.closeIcon),
                      ),
                    ),
                    Text(
                      "Setting",
                      style: mediumTextStyle(
                        fontSize: 17,
                        color: MyColors.blackColor,
                      ),
                    ),
                  ],
                ),

                hSized20,

                // ---------- Options ----------
                _menuContainer("Share", Icons.share_outlined),
                _menuContainer(
                  "About App",
                  Icons.info_outline,
                  onTap: () {
                    Navigator.pop(context);
                    CustomNavigator.pushNavigate(
                      context,
                      const StaticPageScreen(title: "About App", slug: "about"),
                    );
                  },
                ),
                _menuContainer(
                  "Terms & Conditions",
                  Icons.description_outlined,
                  onTap: () {
                    Navigator.pop(context);
                    CustomNavigator.pushNavigate(
                      context,
                      const StaticPageScreen(title: "Terms & Conditions", slug: "terms"),
                    );
                  },
                ),
                _menuContainer(
                  "Privacy Policy",
                  Icons.privacy_tip_outlined,
                  onTap: () {
                    Navigator.pop(context);
                    CustomNavigator.pushNavigate(
                      context,
                      const StaticPageScreen(title: "Privacy Policy", slug: "privacy"),
                    );
                  },
                ),
                _menuContainer(
                  "Refund Policy",
                  Icons.receipt_long_outlined,
                  onTap: () {
                    Navigator.pop(context);
                    CustomNavigator.pushNavigate(
                      context,
                      const StaticPageScreen(title: "Refund Policy", slug: "refund"),
                    );
                  },
                ),

                _menuContainer("Reset Account", Icons.restart_alt_outlined),
                _menuContainer(
                  "Log out",
                  Icons.logout_outlined,
                  onTap: () async {
                    print("ddddddddddddd");
                    final result = await ConfirmDialog.show(
                      context,
                      title: "Logout Confirmation",
                      message: "Are you sure you want to logout?",
                      messageColor: MyColors.color969696,
                      messageSize: 12,
                      confirmColor: MyColors.color19B287,
                    );

                    // Navigator.pop(context);

                    if (result == true) {
                      // Logout logic
                      await StorageManager.clearData();

                      // ✅ Navigate to Login screen (clear all previous routes)
                      CustomNavigator.pushRemoveUntil(
                        context,
                        RankUpLoginScreen(),
                      );
                    }
                  },
                ),

                hSized35,

                // ---------- Delete Account ----------
                GestureDetector(
                  onTap: () async {
                    final result = await ConfirmDialog.show(
                      context,
                      title: "",
                      message: "Do you really want to\n delete your account?",
                      confirmText: "Yes, delete",
                      confirmColor: MyColors.color19B287,
                    );

                    if (result == true) {
                      print("Account Deleted");
                    }
                  },
                  child: Text(
                    "Delete Account",
                    style: mediumTextStyle(
                      fontSize: 16,
                      color: MyColors.blackColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Static menu container wrapper
  static Widget _menuContainer(
    String title,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 43,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: MyColors.whiteText,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          children: [
            Icon(icon, color: MyColors.blackColor, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: mediumTextStyle(
                  fontSize: 14,
                  color: MyColors.blackColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
