import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/provider/provider_classes/HomeProvider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<HomeProvider>(context);

    return CommonScaffold(
      backgroundColor: MyColors.appTheme,
      appBarVisible: false,
      padding: false,
      showBack: false,
      useSafeArea: false,
      body: SingleChildScrollView(
        child: Column(
          children: [_headerSection(provider), _mainBody(context, provider)],
        ),
      ),
    );
  }

  /// ---------------- Header Section ----------------
  Widget _headerSection(HomeProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 25),
      color: MyColors.appTheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerTop(provider),
          const SizedBox(height: 24),
          _progressSection(provider),
        ],
      ),
    );
  }

  Widget _headerTop(HomeProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(IconsPath.defultImage),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hello,",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                Text(
                  provider.username,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Icon(Icons.notifications_none, color: Colors.white, size: 28),
      ],
    );
  }

  Widget _progressSection(HomeProvider provider) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(23),
            value: provider.completedModules / 5,
            minHeight: 7,
            color: MyColors.color19B287,
            backgroundColor: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            "${provider.completedModules} Module Completed",
            style: semiBoldTextStyle(fontSize: 14, color: MyColors.whiteText),
          ),
        ),
      ],
    );
  }

  /// ---------------- Main Body ----------------
  Widget _mainBody(BuildContext context, HomeProvider provider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.horizontal),
      decoration: BoxDecoration(
        color: MyColors.rankBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hSized24,
          _title("Question/Flashcard of the Day"),
          hSized10,
          commonContainer(
            Row(
              children: [
                SvgPicture.asset(IconsPath.homeRevealImage),
                wSized7,
                Expanded(
                  child: Text(
                    "Q: ${provider.qotd}",
                    style: regularTextStyle(
                      fontSize: 16,
                      color: MyColors.color949494,
                    ),
                  ),
                ),
                wSized10,
                CommonButton(title: "Reveal", onPressed: () {}),
              ],
            ),
          ),
          hSized24,
          _sectionTitle("Featured Deck", 180),
          hSized10,
          _featuredDecks(provider),
          hSized24,
          _liveTestCard(provider),
          hSized24,
          _sectionTitle("Paused Module", 180),
          hSized10,
          _moduleCard("Module 1:", "Human Physiology", provider),
          hSized24,
          _sectionTitle("Solve Next", 180),
          hSized10,
          _moduleCard("Quiz:", "Human Physiology", provider),
          hSized24,
          _title("Important Topics"),
          hSized10,
          _importantTopics(provider),
          hSized20,
          _subscriptionButton(),
          hSized20,
        ],
      ),
    );
  }

  /// ---------- Reusable Widgets ----------
  Widget _title(String text) => Text(
    text,
    style: mediumTextStyle(fontSize: 18, color: MyColors.blackColor),
  );

  Widget _sectionTitle(String title, double width) {
    return Container(
      width: width,
      alignment: Alignment.center,
      height: 32,
      decoration: BoxDecoration(
        color: MyColors.appTheme,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFCDCED1)),
      ),
      child: Text(
        title,
        style: semiBoldTextStyle(fontSize: 14, color: MyColors.whiteText),
      ),
    );
  }

  Widget _featuredDecks(HomeProvider provider) {
    return StatefulBuilder(
      builder: (context, setState) {


        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(provider.featuredDecks.length, (index) {
              final deck = provider.featuredDecks[index];
              final bool isSelected =provider.selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() => provider.selectedIndex = index);
                },
                child: Container(
                  padding: const EdgeInsets.all(2), // border spacing
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? MyColors.appTheme : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Container(
                    height: 65,
                    width: 78,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(deck['color']),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Text(
                      deck['title'],
                      textAlign: TextAlign.center,
                      style: mediumTextStyle(
                        fontSize: 12,
                        color: MyColors.whiteText,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }


  Widget _liveTestCard(HomeProvider provider) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: _cardDecoration(MyColors.appTheme),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: "Live Test of the Day: ",
              style: semiBoldTextStyle(fontSize: 16, color: MyColors.whiteText),
              children: [
                TextSpan(
                  text: provider.liveTestTitle,
                  style: mediumTextStyle(
                    fontSize: 14,
                    color: MyColors.whiteText,
                  ),
                ),
              ],
            ),
          ),
          hSized10,
          Row(
            children: [
              const Icon(
                Icons.timer_outlined,
                size: 20,
                color: MyColors.whiteText,
              ),
              const SizedBox(width: 6),
              Text(
                "Starts in ${provider.liveTestTimer}",
                style: mediumTextStyle(fontSize: 14, color: MyColors.whiteText),
              ),
              const Spacer(),
              _outlineButton("Review"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _moduleCard(String title, String subtitle, HomeProvider provider) {
    return commonContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: semiBoldTextStyle(
                  fontSize: 16,
                  color: MyColors.blackColor,
                ),
              ),
              Text(
                subtitle,
                style: mediumTextStyle(
                  fontSize: 14,
                  color: MyColors.blackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(20),
                    value: provider.moduleProgress,
                    color: MyColors.appTheme,
                    backgroundColor: MyColors.rankBg,
                    minHeight: 8,
                  ),
                ),
              ),
              const Spacer(),
              _outlineButton(
                "Resume",
                borderColor: MyColors.appTheme,
                textColor: MyColors.appTheme,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _importantTopics(HomeProvider provider) {
    return commonContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            provider.quizTitle,
            style: semiBoldTextStyle(fontSize: 18, color: MyColors.blackColor),
          ),
          hSized5,
          Text(
            provider.quizDescription,
            style: mediumTextStyle(fontSize: 12, color: MyColors.blackColor),
          ),
        ],
      ),
    );
  }

  Widget _subscriptionButton() {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 121,
        height: 26,
        decoration: BoxDecoration(
          color: MyColors.color19B287,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "Subscription & Plan",
          style: boldTextStyle(fontSize: 10, color: MyColors.whiteText),
        ),
      ),
    );
  }

  /// ---------- Reusable Styles ----------
  BoxDecoration _cardDecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFCDCED1)),
    );
  }

  Widget _outlineButton(String text, {Color? borderColor, Color? textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor ?? MyColors.whiteText),
      ),
      child: Text(
        text,
        style: semiBoldTextStyle(
          fontSize: 10,
          color: textColor ?? MyColors.whiteText,
        ),
      ),
    );
  }
}

/// ---------- Common Container ----------
Widget commonContainer(Widget child) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: MyColors.whiteText,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: MyColors.colorCBCBCB),
    ),
    child: child,
  );
}

/// ---------- Common Button ----------
class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? fontSize;
  final Color? textColor;
  final double? borderRadius; // 👈 added this

  const CommonButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.fontSize,
    this.textColor,
    this.borderRadius, // 👈 added this
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
        decoration: BoxDecoration(
          color: MyColors.appTheme,
          borderRadius: BorderRadius.circular(borderRadius ?? 19), // 👈 use custom or default
          border: Border.all(color: MyColors.whiteText),
        ),
        child: Text(
          title,
          style: semiBoldTextStyle(
            fontSize: fontSize ?? 12,
            color: textColor ?? MyColors.whiteText,
          ),
        ),
      ),
    );
  }
}
class CommonButton1 extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? fontSize;
  final Color? textColor;
  final double? borderRadius;
  final Color? bgColor;
  final double? height;
  final double? width;

  const CommonButton1({
    super.key,
    required this.title,
    required this.onPressed,
    this.fontSize,
    this.textColor,
    this.borderRadius,
    this.bgColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
        decoration: BoxDecoration(
          color: bgColor ?? MyColors.color32B790,
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          border: Border.all(color: bgColor ?? MyColors.color32B790),
        ),
        alignment: Alignment.center,
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: semiBoldTextStyle(
            fontSize: fontSize ?? 12,
            color: textColor ?? MyColors.whiteText,
          ),
        ),
      ),
    );
  }
}


