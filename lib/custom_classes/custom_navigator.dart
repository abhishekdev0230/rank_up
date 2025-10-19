import 'package:flutter/material.dart';

class CustomNavigator {
  /// Push Replacement
  static pushReplacementNavigate(BuildContext context, Widget page, {bool withNavBar = false}) {
    if (!withNavBar) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(1.0, 0.0), // slide from right
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
    } else {
      // If using persistent bottom nav package, enable this:
      // PersistentNavBarNavigator.pushNewScreen(
      //   context,
      //   screen: page,
      //   withNavBar: true,
      // );
    }
  }

  /// Push Navigate (default slide from right)
  static Future<dynamic> pushNavigate(BuildContext context, Widget page, {bool withNavBar = false}) {
    if (!withNavBar) {
      return Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(1.0, 0.0), // slide from right
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
    } else {
      // For persistent bottom nav:
      // return PersistentNavBarNavigator.pushNewScreen(
      //   context,
      //   screen: page,
      //   withNavBar: true,
      // );
      return Future.value();
    }
  }

  /// Push From Bottom
  static Future<dynamic> bottomPushNavigate(BuildContext context, Widget page, {bool withNavBar = false}) {
    if (!withNavBar) {
      return Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(0.0, 1.0), // slide from bottom
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
    } else {
      // For persistent bottom nav:
      // return PersistentNavBarNavigator.pushNewScreen(
      //   context,
      //   screen: page,
      //   withNavBar: true,
      // );
      return Future.value();
    }
  }

  /// Push Remove Until
  static pushRemoveUntil(BuildContext context, Widget page, {bool withNavBar = false}) {
    if (!withNavBar) {
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(1.0, 0.0), // slide from right
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
            (route) => false,
      );
    } else {
      // For persistent bottom nav:
      // PersistentNavBarNavigator.pushNewScreen(
      //   context,
      //   screen: page,
      //   withNavBar: true,
      // );
    }
  }

  /// Pop Navigate
  static popNavigate(BuildContext context) {
    Navigator.of(context).pop(true);
  }
}
