import 'package:flutter/material.dart';

class CustomNavigator{

  /// Push Replacement..........................
  static pushReplacementNavigate(BuildContext context,var page){
    Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder:
            (context, animation, anotherAnimation) {
          return page;
        },
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder:
            (context, animation, anotherAnimation, child) {
          return SlideTransition(
            position: Tween(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        }));
  }


  /// Push ...................................................
  // static pushNavigate(BuildContext context,var page){
  //   Navigator.of(context).push(PageRouteBuilder(
  //       pageBuilder:
  //           (context, animation, anotherAnimation) {
  //         return page;
  //       },
  //       transitionDuration: const Duration(milliseconds: 300),
  //       transitionsBuilder:
  //           (context, animation, anotherAnimation, child) {
  //         return SlideTransition(
  //           position: Tween(
  //               begin: const Offset(1.0, 0.0),
  //               end: const Offset(0.0, 0.0))
  //               .animate(animation),
  //           child: child,
  //         );
  //       }));
  // }

  static Future<dynamic> pushNavigate(BuildContext context, Widget page) {
    return Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) {
        return page;
      },
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
    ));
  }

  /// bootom Push ...................................................
  // static bottomPushNavigate(BuildContext context,var page){
  //   Navigator.of(context).push(PageRouteBuilder(
  //       pageBuilder:
  //           (context, animation, anotherAnimation) {
  //         return page;
  //       },
  //       transitionDuration: const Duration(milliseconds: 300),
  //       transitionsBuilder:
  //           (context, animation, anotherAnimation, child) {
  //         return SlideTransition(
  //           position: Tween(
  //               begin: const Offset(0.0, 0.0),
  //               end: const Offset(0.0, 0.0))
  //               .animate(animation),
  //           child: child,
  //         );
  //       }));
  // }
  static Future<dynamic> bottomPushNavigate(BuildContext context, Widget page) {
    return Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) {
        return page;
      },
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0.0, 1.0), // push from bottom
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    ));
  }



  /// Push Removeuntil..........................................
  static pushRemoveUntil(BuildContext context, var page){
    Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(
        pageBuilder:
            (context, animation, anotherAnimation) {
          return page;
        },
        transitionDuration: const Duration(milliseconds:300),
        transitionsBuilder:
            (context, animation, anotherAnimation, child) {
          return SlideTransition(
            position: Tween(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        }), (route) => false);
  }

  /// Pop ..........................................
  static popNavigate(BuildContext context){
    Navigator.of(context).pop(true);
  }

}