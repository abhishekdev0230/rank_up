import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rank_up/custom_classes/AppPaddings.dart';

import '../constraints/icon_path.dart';
import '../constraints/my_colors.dart';
import '../constraints/my_fonts_style.dart';
import '../constraints/sizdebox_width.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? img;
  final Widget? title2;
  final bool centerTitle;
  final VoidCallback? onBack;
  final bool showBack;
  final List<Widget>? actions;
  final Color? backgroundColor;
  const CustomAppBar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.onBack,
    this.title2,
    this.actions,
    this.showBack = true,
    this.img,
    this.backgroundColor,

  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      backgroundColor: backgroundColor ?? MyColors.appTheme,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading: showBack
          ? GestureDetector(
        onTap: onBack ?? () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            IconsPath.backArow,
            width: 20,
            height: 20,
          ),
        ),
      )
          : null,

      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Flexible(
              child: Text(
                title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: boldTextStyle(fontSize: 18.0, color: MyColors.whiteText),
              ),
            ),
          if (title2 != null) ...[wSized5, title2!],
          if (img != null) SvgPicture.asset(img.toString(), height: 35),
        ],
      ),
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CommonScaffold extends StatelessWidget {
  final String? title;
  final String? img;
  final Widget? title2;
  final bool centerTitle;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? body;
  final List<Widget>? actions;
  final Widget? bottom;
  final Color? backgroundColor;
  final Color? appBarBackgroundColor;
  final bool appBarVisible;
  final bool useSafeArea;
  final bool padding;

  /// NEW: Floating Action Button support
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const CommonScaffold({
    super.key,
    this.title,
    this.title2,
    this.centerTitle = true,
    this.showBack = true,
    this.onBack,
    this.body,
    this.actions,
    this.bottom,
    this.backgroundColor,
    this.appBarBackgroundColor,
    this.appBarVisible = true,
    this.useSafeArea = true,
    this.img,
    this.padding = true,

    /// NEW
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = body ?? const SizedBox.shrink();

    if (padding) {
      content = Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.symmetricHorizontal,
        ),
        child: content,
      );
    }

    Widget scaffold = Scaffold(
      backgroundColor: backgroundColor ?? MyColors.bgBackgroundColor,

      /// NEW: FAB added here ⬇️
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation:
          floatingActionButtonLocation ?? FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: bottom == null
          ? null
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPaddings.symmetricHorizontal,
              ),
              child: bottom,
            ),

      appBar: appBarVisible
          ? CustomAppBar(
              actions: actions,
              img: img,
              title: title,
              title2: title2,
              centerTitle: centerTitle,
              showBack: showBack,
              onBack: onBack,
        backgroundColor: appBarBackgroundColor,
            )
          : null,

      body: content,
    );

    if (useSafeArea) {
      return Container(
        color: MyColors.appTheme,
        child: SafeArea(top: true, bottom: true, child: scaffold),
      );
    }

    return scaffold;
  }
}
