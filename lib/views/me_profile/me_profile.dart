import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/views/me_profile/setting.dart';

import 'BlogScreen.dart';
import 'FaqScreen.dart';
import 'MyQueriesScreen.dart';
import 'NotificationScreen.dart';

class MeProfile extends StatefulWidget {
  const MeProfile({super.key});

  @override
  State<MeProfile> createState() => _MeProfileState();
}

class _MeProfileState extends State<MeProfile> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: CommonScaffold(
        backgroundColor: MyColors.rankBg,
        showBack: false,
        appBarVisible: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Header ----------
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(IconsPath.closeIcon),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Profile",
                        style: mediumTextStyle(
                          fontSize: 17,
                          color: MyColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              hSized20,

              // ---------- User info ----------
              Container(
                decoration: BoxDecoration(
                  color: MyColors.appTheme,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage(
                        'assets/images/defultImage.png',
                      ),
                    ),
                    wSized10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Guy Hawkins",
                            style: semiBoldTextStyle(
                              fontSize: 16,
                              color: MyColors.whiteText,
                            ),
                          ),
                          Text(
                            "guyhawkins12@gmail.com",
                            style: mediumTextStyle(
                              fontSize: 12,
                              color: MyColors.whiteText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),

              hSized20,

              // ---------- Subscription ----------
              Container(
                decoration: BoxDecoration(
                  color: MyColors.whiteText,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(IconsPath.premiumSubscription),
                    wSized5,
                    Text(
                      "Premium Subscription",
                      style: mediumTextStyle(
                        fontSize: 14,
                        color: MyColors.blackColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Inactive",
                      style: mediumTextStyle(
                        fontSize: 14,
                        color: MyColors.blackColor,
                      ),
                    ),
                    wSized7,
                    const Icon(Icons.arrow_forward_ios_sharp, size: 13),
                  ],
                ),
              ),

              hSized10,

              // ---------- Bookmarked / Suspended cards ----------
              Row(
                children: [
                  Expanded(
                    child: _smallInfoCard(
                      title: "Bookmarked Cards",
                      subtitle: "0 Cards",
                      icon: SvgPicture.asset(IconsPath.suspendedCards),
                    ),
                  ),
                  wSized10,
                  Expanded(
                    child: _smallInfoCard(
                      title: "Suspended Cards",
                      subtitle: "0 Cards",
                      icon: SvgPicture.asset(IconsPath.bookmarkedCards),
                    ),
                  ),
                ],
              ),

              hSized10,

              // ---------- Menu options ----------
              Column(
                children: [
                  _menuContainer("Leaderboard", Icons.leaderboard_outlined),
                  hSized10,
                  _menuContainer("Deck Setting", Icons.layers_outlined),
                  hSized10,
                  _menuContainer(
                    "My Queries",
                    Icons.chat_bubble_outline,
                    onTap: () {
                      CustomNavigator.pushNavigate(context, MyQueriesScreen());
                    },
                  ),
                  hSized10,
                  _menuContainer(
                    "Blog",
                    Icons.article_outlined,

                    onTap: () {
                      CustomNavigator.pushNavigate(context, BlogScreen());
                    },
                  ),
                  hSized10,
                  _menuContainer(
                    "FAQ",
                    Icons.help_outline,
                    onTap: () {
                      CustomNavigator.pushNavigate(context, FaqScreen());
                    },
                  ),
                  hSized10,
                  _menuContainer(
                    "Notification",
                    Icons.notifications_none,
                    onTap: () {
                      CustomNavigator.pushNavigate(
                        context,
                        NotificationScreen(),
                      );
                    },
                  ),
                  hSized10,
                  _menuContainer(
                    "Setting",
                    Icons.settings_outlined,
                    onTap: () => SettingsSheet.show(context),
                  ),
                ],
              ),

              hSized20,

              // ---------- Logout ----------
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Log out",
                        style: mediumTextStyle(
                          fontSize: 16,
                          color: MyColors.blackColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.logout, color: Colors.black, size: 18),
                    ],
                  ),
                ),
              ),
              hSized20,
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuContainer(String title, IconData icon, {VoidCallback? onTap}) {
    return Container(
      height: 43, // fixed height
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 20),
            const SizedBox(width: 10),
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
            const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 14),
          ],
        ),
      ),
    );
  }

  Widget _smallInfoCard({
    required String title,
    required String subtitle,
    required Widget icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.whiteText,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          const SizedBox(height: 6),
          Text(
            title,
            style: mediumTextStyle(fontSize: 14, color: MyColors.blackColor),
          ),
          Text(
            subtitle,
            style: mediumTextStyle(fontSize: 10, color: MyColors.blackColor),
          ),
        ],
      ),
    );
  }
}
