import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/views/Home/home_view.dart';

import 'FlashcardCompletionScreen.dart';

class NeetPYQsFlashcardsInner extends StatefulWidget {
  const NeetPYQsFlashcardsInner({super.key});

  @override
  State<NeetPYQsFlashcardsInner> createState() =>
      _NeetPYQsFlashcardsInnerState();
}

class _NeetPYQsFlashcardsInnerState extends State<NeetPYQsFlashcardsInner> {
  bool _showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: MyColors.appTheme,
      title: "Neet PYQs-Biology",
      body: SingleChildScrollView(
        child: Column(
          children: [
            hSized20,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 16),
              width: double.infinity,
              // height: 430,
              decoration: BoxDecoration(
                color: MyColors.rankBg,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _showAnswer ? _buildAnswerCard() : _buildQuestionCard(),
              ),
            ),
            hSized30,
            if (_showAnswer)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circularButton("Don’t\nKnow", MyColors.color1BB287),
                  _circularButton("Suspend", MyColors.colorF8CB52),
                  _circularButton("Know", MyColors.colorD84B48),
                ],
              ),
            hSized15,
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: SvgPicture.asset(IconsPath.woldCupIcon, height: 30),
        ),
        Container(
          alignment: Alignment.center,
          height: 230,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "Q: What the full form of SI Units?",
            style: semiBoldTextStyle(color: MyColors.blackColor, fontSize: 22),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "1/15 Flashcards in Deck",
              style: regularTextStyle(color: MyColors.blackColor, fontSize: 14),
            ),
            hSized10,
            CommonButton(
              borderRadius: 8,
              title: "Reveal answer",
              onPressed: () {
                setState(() {
                  _showAnswer = true;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnswerCard() {
    return Column(
      key: const ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(IconsPath.woldCupIcon, height: 38),
            Spacer(),
            SvgPicture.asset(IconsPath.bokMarkSave, height: 27),
          ],
        ),
        hSized8,
        Text(
          "Friction",
          style: semiBoldTextStyle(color: MyColors.blackColor, fontSize: 20),
        ),
        Text(
          "Card 1/15",
          style: regularTextStyle(color: MyColors.color949494, fontSize: 16),
        ),
        hSized10,
        // ---------- Question ----------
        Text(
          "Q: What the full form of SI Units?",
          style: semiBoldTextStyle(color: MyColors.blackColor, fontSize: 22),
        ),
        hSized10,
        // ---------- Answer Paragraph ----------
        Container(
          height: 150,
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt "
            "ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco "
            "laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in "
            "voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
            style: regularTextStyle(color: MyColors.color949494, fontSize: 15),
          ),
        ),
        hSized15,
        // ---------- Tag Buttons ----------
        Row(children: [_tagButton("PYQ"), wSized10, _tagButton("PYQ")]),

        hSized15,
        // ---------- Navigation Arrows ----------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(IconsPath.backCart),

            GestureDetector(
              onTap: () {
                CustomNavigator.pushNavigate(
                  context,
                  FlashcardCompletionScreen(),
                );
              },
              child: SvgPicture.asset(IconsPath.next),
            ),
          ],
        ),
      ],
    );
  }

  // ---------- Small Green Tag Buttons (PYQ etc.) ----------
  Widget _tagButton(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: MyColors.color1BB287,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: semiBoldTextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }

  Widget _circularButton(String title, Color color) {
    return Container(
      width: 86,
      height: 86,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: semiBoldTextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
