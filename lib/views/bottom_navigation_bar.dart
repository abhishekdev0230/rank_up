import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
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

      final idx = _controller.index;

      if (idx == 3) {
        // user tapped "Me"
        _suppressMeTap = true;

        // immediately jump back to previous tab so UI doesn't show empty screen
        _controller.jumpToTab(_lastIndex);

        // show bottom sheet and wait for it to close
        _openMeProfileBottomSheet().whenComplete(() {
          // re-enable listener after bottom sheet is dismissed
          // small delay ensures nav state settled before we accept further taps
          Future.delayed(const Duration(milliseconds: 200), () {
            _suppressMeTap = false;
          });
        });
      } else {
        // store last non-Me index
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
        height: 60,
      ),
    );
  }

  List<PersistentTabConfig> _buildTabs() {
    return [
      PersistentTabConfig(
        screen: const HomeScreen(),
        item: _buildNavItem(IconsPath.homeBottomIcon, "Home"),
      ),
      PersistentTabConfig(
        screen: const FlashcardScreen(),
        item: _buildNavItem(IconsPath.bookBottomIcon, "FlashQ"),
      ),
      PersistentTabConfig(
        screen: Container(color: Colors.blue),
        item: _buildNavItem(IconsPath.noteBooksBottomIcon, "Test"),
      ),

      // "Me" tab — placeholder screen; actual UI shown via bottom sheet listener
      PersistentTabConfig(
        screen: Container(),
        item: _buildNavItem(IconsPath.profileBottomIcon, "Me"),
      ),
    ];
  }

  ItemConfig _buildNavItem(String iconPath, String title) {
    return ItemConfig(
      icon: SvgPicture.asset(iconPath, height: 24, width: 24, color: MyColors.color668BAD),
      inactiveIcon: SvgPicture.asset(iconPath, height: 24, width: 24, color: MyColors.whiteText),
      title: title,
      activeForegroundColor: MyColors.color668BAD,
      inactiveForegroundColor: MyColors.whiteText,
      activeColorSecondary: MyColors.color668BAD,
      textStyle: semiBoldTextStyle(fontSize: 13),
      iconSize: 26.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
