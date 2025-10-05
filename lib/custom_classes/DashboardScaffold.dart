// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:privee_club/constraints/font_family.dart';
// import 'package:privee_club/constraints/icon_path.dart';
// import 'package:privee_club/constraints/my_colors.dart';
//
// class DashboardScaffold extends StatelessWidget {
//   final Widget child;
//   final bool showBackgroundImage;
//   final GlobalKey<FormState>? formKey;
//   final bool enableForm;
//   final Widget? bottom;
//   final bool showBackButton;
//
//   const DashboardScaffold({
//     super.key,
//     required this.child,
//     this.showBackgroundImage = true,
//     this.formKey,
//     this.bottom,
//     this.enableForm = false,
//     this.showBackButton = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     Widget content = Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: AppPaddings.symmetricHorizontal,
//       ),
//       child: child,
//     );
//
//     if (enableForm) {
//       content = Form(
//         key: formKey,
//         child: content,
//       );
//     }
//
//     return Stack(
//       children: [
//         Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: MyColors.bg,
//           child: SafeArea(
//             top: false,
//             child: Scaffold(
//               body: SingleChildScrollView(
//                 child: Stack(
//                   children: [
//                     Column(
//                       children: [
//                         if (showBackgroundImage) Image.asset(IconsPath.onboardingBg),
//                         content,
//                       ],
//                     ),
//                     if (showBackButton)
//                       SafeArea(
//                         child: GestureDetector(
//                           onTap: () => Navigator.pop(context),
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 12.0),
//                             child: SvgPicture.asset(
//                               IconsPath.backIconOb,
//                               width: 39,
//                               height: 39,
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//               bottomNavigationBar: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: AppPaddings.symmetricHorizontal,
//                 ),
//                 child: bottom,
//               ),
//             ),
//           ),
//         ),
//
//       ],
//     );
//   }
// }
