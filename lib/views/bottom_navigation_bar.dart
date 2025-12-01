import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/views/tests_screen/tests_screen.dart';
import 'FlashcardQ/flashcard_screen.dart';
import 'Home/home_view.dart';
import 'me_profile/me_profile.dart';

class BottomNavController extends StatefulWidget {
  final int initialIndex;

  const BottomNavController({super.key, this.initialIndex = 0});

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  late PersistentTabController _controller;

  /// last non-"Me" tab index
  late int _lastIndex;

  /// guard to prevent listener loop when we programmatically change tabs
  bool _suppressMeTap = false;

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: widget.initialIndex);
    _lastIndex = widget.initialIndex;

    _controller.addListener(() {
      if (_suppressMeTap) return;

      setState(() {}); // 👈 UI अब हर index change पर rebuild होगा

      final idx = _controller.index;

      if (idx == 3) {
        _suppressMeTap = true;

        _controller.jumpToTab(_lastIndex);

        _openMeProfileBottomSheet().whenComplete(() {
          Future.delayed(const Duration(milliseconds: 200), () {
            _suppressMeTap = false;
          });
        });
      } else {
        _lastIndex = idx;
      }
    });

  }

  /// Returns the Future from showModalBottomSheet so caller can await it
  Future<void> _openMeProfileBottomSheet() {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        return Container(
          margin: const EdgeInsets.only(top: 100),
          height: screenHeight - 100,
          decoration: const BoxDecoration(
            color: MyColors.rankBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: DraggableScrollableSheet(
            expand: true,
            initialChildSize: 1,
            minChildSize: 0.4,
            maxChildSize: 1.0,
            builder: (_, controller) => MeProfile(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      tabs: _buildTabs(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      margin: const EdgeInsets.only(bottom: 10, top: 16),
      navBarBuilder: (config) => Style1BottomNavBar(
        navBarConfig: config,
        navBarDecoration: NavBarDecoration(
          color: MyColors.appTheme,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        height: 65,
      ),
    );
  }

  List<PersistentTabConfig> _buildTabs() {
    return [
      PersistentTabConfig(
        screen: const HomeScreen(),
        item: _buildNavItem(IconsPath.homeBottomIcon, "Home", 0),
      ),
      PersistentTabConfig(
        screen: const FlashcardScreen(),
        item: _buildNavItem(IconsPath.bookBottomIcon, "FlashQ", 1),
      ),
      PersistentTabConfig(
        screen: TestLeaderboardScreen(),
        item: _buildNavItem(IconsPath.noteBooksBottomIcon, "Test", 2),
      ),
      PersistentTabConfig(
        screen: Container(),
        item: _buildNavItem(IconsPath.profileBottomIcon, "Me", 3),
      ),
    ];
  }

  ItemConfig _buildNavItem(String iconPath, String title, int index) {
    bool isActive = _controller.index == index;

    return ItemConfig(
      icon: Container(
        padding: isActive ? const EdgeInsets.all(6) : EdgeInsets.zero,
        decoration: isActive
            ? const BoxDecoration(color: Colors.white, shape: BoxShape.circle)
            : null,
        child: SvgPicture.asset(
          iconPath,
          height: isActive ? 20 : 24,
          width: isActive ? 20 : 24,
          color: isActive ? MyColors.color668BAD : MyColors.whiteText,
        ),
      ),
      title: title,
      activeForegroundColor: Colors.white,
      inactiveForegroundColor: MyColors.whiteText,
      activeColorSecondary: Colors.white,
      textStyle: semiBoldTextStyle(fontSize: 13),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
