//
// /// Old Code
// // import 'package:circular_menu/circular_menu.dart';
// // import 'package:flutter/material.dart';
// // import 'package:pairfect_02/constraints/my_colors.dart';
// // import 'package:pairfect_02/screen/chats/chats_inbox_screen.dart';
// // import 'package:pairfect_02/screen/home/home_screen.dart';
// // import 'package:pairfect_02/screen/matches/matches.dart';
// // import 'package:pairfect_02/screen/profile/profile_screen.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // String? type;
// //
// // class DashBordBottom extends StatefulWidget {
// //   const DashBordBottom({super.key});
// //
// //   @override
// //   State<DashBordBottom> createState() => _DashBordBottomState();
// // }
// //
// // class _DashBordBottomState extends State<DashBordBottom> {
// //   int _selectedIndex = 0;
// //   List<Widget>? _widgetOptions;
// //   SharedPreferences? preferences;
// //   bool _isMenuOpen = false; // State to manage menu open/close
// //
// //   // Create a GlobalKey for CircularMenu
// //   final GlobalKey<CircularMenuState> _menuKey = GlobalKey<CircularMenuState>();
// //
// //   void _onTabChanged(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //       // Close the menu when the tab is changed
// //       _isMenuOpen = !_isMenuOpen;
// //       // _menuKey.currentState?.closeMenu();
// //     });
// //   }
// //
// //
// //
// //   Future<void> getPreferences() async {
// //     preferences = await SharedPreferences.getInstance();
// //     _initializeWidgets();
// //   }
// //
// //   void _initializeWidgets() {
// //     setState(() {
// //       _widgetOptions =
// //           <Widget>[
// //         /// Page 1
// //         const HomeScreen(),
// //
// //         /// Page 2
// //         const YourMatchesScreen(),
// //
// //         /// Page 3
// //         const InboxScreen(),
// //
// //         /// Page 4
// //         const ProfileScreen(),
// //       ];
// //     });
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     getPreferences();
// //   }
// //
// //
// //   // Future<void> _onTabChanged(int index) async {
// //   //   setState(() {
// //   //     _selectedIndex = index;
// //   //     debugPrint("Selected Index: $_selectedIndex");
// //   //     _isMenuOpen = false; // Close the menu when a tab is changed
// //   //   });
// //   // }
// //   //
// //   // _toggleMenu() {
// //   //   setState(() {
// //   //     debugPrint("Changed");
// //   //     _isMenuOpen = true;
// //   //   });
// //   // }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // ignore: deprecated_member_use
// //     return WillPopScope(
// //       onWillPop: () async {
// //         if (_selectedIndex != 0) {
// //           setState(() {
// //             _selectedIndex = 0;
// //           });
// //           return false;
// //         }
// //         return true;
// //       },
// //       child: Scaffold(
// //         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// //         floatingActionButton: CircularMenu(
// //           key: _menuKey,
// //           // toggleButtonBoxShadow: [
// //           //   BoxShadow(color: Colors.black45, blurRadius: 5, spreadRadius: 1)
// //           // ],
// //           alignment: Alignment.bottomCenter,
// //           startingAngleInRadian: 3.4,
// //           endingAngleInRadian: 6.0,
// //           backgroundWidget:  _widgetOptions?[_selectedIndex],
// //           toggleButtonColor: MyColors.appTheme,
// //           toggleButtonAnimatedIconData: AnimatedIcons.menu_close,
// //           items: [
// //             CircularMenuItem(
// //                 icon: Icons.home_filled,
// //                 color: Colors.green,
// //                 onTap: () {
// //                   _onTabChanged(0);
// //                   setState(() {
// //                     _isMenuOpen = false;
// //                   });// Update selected index
// //                   // _toggleMenu();
// //                 }),
// //             CircularMenuItem(
// //                 icon: Icons.favorite,
// //                 color: Colors.blue,
// //                 onTap: () {
// //                   _onTabChanged(1);
// //                   setState(() {
// //                     _isMenuOpen = false;
// //                   });// Update selected index
// //                   // _toggleMenu();
// //                 }),
// //             CircularMenuItem(
// //                 icon: Icons.chat,
// //                 color: Colors.orange,
// //                 onTap: () {
// //                   _onTabChanged(2);
// //                   setState(() {
// //                     _isMenuOpen = false;
// //                   });// Update selected index
// //                   // _toggleMenu();
// //                 }),
// //             CircularMenuItem(
// //                 icon: Icons.person,
// //                 color: Colors.purple,
// //                 onTap: () {
// //                   _onTabChanged(3);
// //                   setState(() {
// //                     _isMenuOpen = false;
// //                   });// Update selected index
// //                   // _toggleMenu();
// //                 }),
// //           ],
// //         ),
// //         body: _widgetOptions?.elementAt(_selectedIndex),
// //       ),
// //     );
// //   }
// // }
//
// /// Circular Menu
//
// // import 'package:circular_menu/circular_menu.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/rendering.dart';
// // import 'package:pairfect_02/constraints/my_colors.dart';
// // import 'package:pairfect_02/screen/chats/chats_inbox_screen.dart';
// // import 'package:pairfect_02/screen/home/home_screen.dart';
// // import 'package:pairfect_02/screen/matches/matches.dart';
// // import 'package:pairfect_02/screen/profile/profile_screen.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // String? type;
// //
// // class DashBordBottom extends StatefulWidget {
// //   const DashBordBottom({super.key});
// //
// //   @override
// //   State<DashBordBottom> createState() => _DashBordBottomState();
// // }
// //
// // class _DashBordBottomState extends State<DashBordBottom> with SingleTickerProviderStateMixin {
// //   int _selectedIndex = 0;
// //   List<Widget>? _widgetOptions;
// //   SharedPreferences? preferences;
// //   bool _isMenuOpen = false;
// //   final ScrollController _scrollController = ScrollController();
// //   bool isVisible = true;
// //   // Create a GlobalKey for CircularMenu
// //   final GlobalKey<CircularMenuState> _menuKey = GlobalKey<CircularMenuState>();
// //
// //   void _onTabChanged(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //       _isMenuOpen = false; // Close the menu when the tab is changed
// //     });
// //   }
// //
// //   Future<void> getPreferences() async {
// //     preferences = await SharedPreferences.getInstance();
// //     _initializeWidgets();
// //   }
// //
// //   void _initializeWidgets() {
// //     setState(() {
// //       _widgetOptions = <Widget>[
// //         const HomeScreen(),
// //         const YourMatchesScreen(),
// //         const InboxScreen(),
// //         const ProfileScreen(),
// //       ];
// //     });
// //   }
// //
// //   void show() {
// //     if (!isVisible) {
// //       isVisible = true;
// //       setState(() {
// //
// //       });
// //     }
// //   }
// //
// //   void hide() {
// //     if (isVisible) {
// //       isVisible = false;
// //       setState(() {
// //
// //       });
// //     }
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     getPreferences();
// //
// //   }
// //
// //   @override
// //   void dispose() {
// //     _scrollController.dispose();
// //     super.dispose();
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         if (_selectedIndex != 0) {
// //           setState(() {
// //             _selectedIndex = 0;
// //           });
// //           return false;
// //         }
// //         return true;
// //       },
// //       child: Scaffold(
// //
// //         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// //         floatingActionButton: CircularMenu(
// //           toggleButtonOnPressed: () {
// //             setState(() {
// //               _isMenuOpen = !_isMenuOpen; // Toggle the menu state
// //             });
// //           },
// //           key: _menuKey,
// //           alignment: Alignment.bottomCenter,
// //           startingAngleInRadian: 3.4,
// //           endingAngleInRadian: 6.0,
// //           // backgroundWidget: _widgetOptions?[_selectedIndex],
// //           toggleButtonColor: MyColors.appTheme,
// //           toggleButtonAnimatedIconData: AnimatedIcons.menu_close,
// //           items: [
// //             CircularMenuItem(
// //               icon: Icons.home_filled,
// //               color: Colors.green,
// //               onTap: () {
// //                 _menuKey.currentState?.reverseAnimation();
// //                 _onTabChanged(0);
// //                 //closeMenu(); // Close the menu when an item is tapped
// //               },
// //             ),
// //             CircularMenuItem(
// //               icon: Icons.favorite,
// //               color: Colors.blue,
// //               onTap: () {
// //                 _menuKey.currentState?.reverseAnimation();
// //                 _onTabChanged(1);
// //                 //closeMenu(); // Close the menu when an item is tapped
// //               },
// //             ),
// //             CircularMenuItem(
// //               icon: Icons.chat,
// //               color: Colors.orange,
// //               onTap: () {
// //                 _menuKey.currentState?.reverseAnimation();
// //                 _onTabChanged(2);
// //                 //closeMenu(); // Close the menu when an item is tapped
// //               },
// //             ),
// //             CircularMenuItem(
// //               icon: Icons.person,
// //               color: Colors.purple,
// //               onTap: () {
// //                 _menuKey.currentState?.reverseAnimation();
// //                 _onTabChanged(3);
// //                 //closeMenu(); // Close the menu when an item is tapped
// //               },
// //             ),
// //           ],
// //         ),
// //         body: _widgetOptions?.elementAt(_selectedIndex),
// //         //_widgetOptions?.elementAt(_selectedIndex),
// //       ),
// //     );
// //   }
// // }
// //
//
//
// /// newwww
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pairfect_02/screen/chats/chats_inbox_screen.dart';
// import 'package:pairfect_02/screen/home/home.dart';
// import 'package:pairfect_02/screen/matches/matches.dart';
// import 'package:pairfect_02/screen/profile/profile_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// String? type;
//
// class DashBordBottom extends StatefulWidget {
//   const DashBordBottom({super.key});
//
//   @override
//   State<DashBordBottom> createState() => _DashBordBottomState();
// }
//
// class _DashBordBottomState extends State<DashBordBottom> {
//   int _selectedIndex = 0;
//   List<Widget>? _widgetOptions;
//   SharedPreferences? preferences;
//
//
//   Future<void> getPreferences() async {
//     preferences = await SharedPreferences.getInstance();
//     _initializeWidgets();
//   }
//
//   void _initializeWidgets() {
//     setState(() {
//       _widgetOptions =
//       <Widget>[
//
//         /// Page 1
//         const HomeScreen(),
//
//         /// Page 2
//          YourMatchesScreen(),
//
//         /// Page 3
//         const InboxScreen(),
//
//         /// Page 4
//         const ProfileScreen(),
//       ] ;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getPreferences();
//   }
//
//   Future<void> _onTabChanged(int index) async {
//     setState(() {
//       _selectedIndex = index;
//       debugPrint("Selected Index: $_selectedIndex");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // ignore: deprecated_member_use
//     return WillPopScope(
//       onWillPop: () async {
//         if (_selectedIndex != 0) {
//           setState(() {
//             _selectedIndex = 0;
//           });
//           return false;
//         }
//         return true;
//       },
//       child: Scaffold(
//         bottomNavigationBar: BottomNavigationBar(
//           elevation: 20,
//           selectedItemColor: MyColors.appTheme,
//           selectedLabelStyle: const TextStyle(fontSize: 14, color: MyColors.appTheme, fontFamily: FontFamily.manropeSemiBold),
//           unselectedLabelStyle: const TextStyle(fontSize: 14, color: MyColors.unselectedLabelColor, fontFamily: FontFamily.manropeSemiBold),
//           showSelectedLabels: true,
//           showUnselectedLabels: true,
//           currentIndex: _selectedIndex,
//           unselectedItemColor: Color(0xff404040),
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: MyColors.whiteText,
//           items:
//           // type == "Friend" ?
//           [
//             /// Item 1
//             BottomNavigationBarItem(
//               icon: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: SvgPicture.asset(
//                   _selectedIndex == 0
//                       ? IconsPath.home1Image
//                       : IconsPath.home0Image,
//                   width: 25,
//                   height: 25,
//                 ),
//               ),
//               label: 'Home',
//             ),
//
//             /// Item 2
//             BottomNavigationBarItem(
//               icon: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: SvgPicture.asset(
//                   _selectedIndex == 1
//                       ? IconsPath.matches1Image
//                       : IconsPath.matches0Image,
//                   width: 25,
//                   height: 25,
//                 ),
//               ),
//               label: 'Matches',
//             ),
//
//             /// Item 3
//             BottomNavigationBarItem(
//               icon: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: SvgPicture.asset(
//                   _selectedIndex == 2
//                       ? IconsPath.chat1Image
//                       : IconsPath.chat0Image,
//                   width: 25,
//                   height: 25,
//                 ),
//               ),
//               label: 'Chats',
//             ),
//
//             /// Item 4
//             BottomNavigationBarItem(
//               icon: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: SvgPicture.asset(
//                   _selectedIndex == 3
//                       ? IconsPath.profile1Image
//                       : IconsPath.profile0Image,
//                   width: 25,
//                   height: 25,
//                 ),
//               ),
//               label: 'Profile',
//             ),
//           ],
//           onTap: (index) {
//             _onTabChanged(index);
//
//           },
//         ),
//         body: _widgetOptions?.elementAt(_selectedIndex),
//       ),
//     );
//   }
//
//   void updateOnCallBack() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Future.delayed(Duration.zero, () async {
//         // Additional logic can be added here if needed
//       });
//     });
//   }
//
//   Future<bool> onCallBack() async {
//     Navigator.of(context).pop();
//     setState(() {});
//     return true;
//   }
// }
//
