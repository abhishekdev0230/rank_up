import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rank_up/constraints/my_colors.dart';

/// 🔹 Fancy full-screen loader (semi-transparent background)
class CommonLoader extends StatelessWidget {
  final double size;
  final Color color;

  const CommonLoader({
    Key? key,
    this.size = 60.0,
    this.color = MyColors.appTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: LoadingAnimationWidget.hexagonDots(
          color: color,
          size: size,
        ),
      ),
    );
  }
}

/// 🔹 Simple loader dialog for API calls
class CommonLoaderApi {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: MyColors.appTheme,
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}

/// 🔹 Loader for partial sections (e.g., widgets / screens)
class CommonLoader1 extends StatelessWidget {
  final double height;

  const CommonLoader1({Key? key, this.height = 0.5}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
      child: const Center(
        child: CircularProgressIndicator(color: MyColors.appTheme),
      ),
    );
  }
}

/// 🔹 Loader used when selecting or uploading images
class CommonLoaderImagesSelect extends StatelessWidget {
  final double size;
  final double strokeWidth;

  const CommonLoaderImagesSelect({
    Key? key,
    this.size = 72,
    this.strokeWidth = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: MyColors.appTheme,
        ),
      ),
    );
  }
}
