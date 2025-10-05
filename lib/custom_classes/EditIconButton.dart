// import 'package:flutter/material.dart';
// import 'package:privee_club/constraints/my_colors.dart';
// import 'package:privee_club/constraints/my_fonts_style.dart';
//
// class EditIconButton extends StatelessWidget {
//   final VoidCallback onTap;
//   final Color backgroundColor;
//   final IconData icon;
//   final double height;
//   final double width;
//   final double iconSize;
//   final String text;
//   final TextStyle? textStyle;
//
//   const EditIconButton({
//     super.key,
//     required this.onTap,
//     this.backgroundColor = MyColors.appTheme,
//     this.icon = Icons.mode_edit_outline_outlined,
//     this.height = 40,
//     this.width = 100,
//     this.iconSize = 20,
//     this.text = "",
//     this.textStyle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: height,
//         width: width,
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(11),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: MyColors.blackColor, size: iconSize),
//             if (text.isNotEmpty) ...[
//               const SizedBox(width: 5),
//               Text(
//                 text,
//                 style: textStyle ??
//                     semiBoldTextStyle(
//                       fontSize: 12,
//                       color: MyColors.blackColor,
//                     ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
