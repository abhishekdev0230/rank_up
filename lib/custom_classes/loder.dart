// import 'package:flutter/material.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:privee_club/constraints/my_colors.dart';
//
// class CommonLoader extends StatelessWidget {
//   final double size;
//   final Color color;
//
//   const CommonLoader({
//     Key? key,
//     this.size = 60.0,
//     this.color = MyColors.appTheme,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black.withOpacity(0.4),
//       child: Center(
//         child: LoadingAnimationWidget.hexagonDots(
//           color: color,
//           size: size,
//         ),
//       ),
//     );
//
//   }
// }
//
// class CommonLoaderApi {
//   static void show(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return const Center(
//           child: CircularProgressIndicator(color: MyColors.appTheme,),
//         );
//       },
//     );
//   }
//
//   static void hide(BuildContext context) {
//     Navigator.of(context, rootNavigator: true).pop();
//   }
// }
//
//
// class CommonLoader1 extends StatelessWidget {
//   final double height;
//
//   const CommonLoader1({super.key, this.height = 0.5});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * height,
//       child: const Center(
//         child: CircularProgressIndicator(color: MyColors.appTheme),
//       ),
//     );
//   }
// }
//
//
// ///...............images select loder.................
//
// class CommonLoaderImagesSelect extends StatelessWidget {
//   final double size;
//   final double strokeWidth;
//
//   const CommonLoaderImagesSelect({
//     super.key,
//     this.size = 72,
//     this.strokeWidth = 2,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: size,
//       height: size,
//       child: Center(
//         child: CircularProgressIndicator(
//           strokeWidth: strokeWidth,
//         ),
//       ),
//     );
//   }
// }