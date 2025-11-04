import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/views/FlashcardQ/flashcards_innner_1.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  int selectedTab = 0;

  final List<String> tabs = ["Class 11", "Class 12", "Achiever"];

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(

    title: "Flashcards",
      showBack: false,
      backgroundColor: MyColors.appTheme,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSized10,
              /// ---------------- Tabs ----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(tabs.length, (index) {
                  final bool isSelected = selectedTab == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedTab = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? MyColors.green
                            : MyColors.color295176,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        tabs[index],
                        style: mediumTextStyle(
                          color: Colors.white, fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }),
              ),
          
              const SizedBox(height: 28),
          
              /// ---------------- Featured Subjects ----------------
              Text(
                "Featured Subjects",
                style: semiBoldTextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
              const SizedBox(height: 16),
          
              Column(
                children: [
                  _subjectCard(
                    onTap:
                    () {
                      CustomNavigator.pushNavigate(context, FlashcardInnerPhysicsScreen());
                    },
                    title: "Biology",
                    subtitle:
                    "Organic, Inorganic, Physical, Zoology, Botany & Reproduction",
                    icon: Icons.biotech_rounded,
                  ),
                  const SizedBox(height: 12),
                  _subjectCard(
                    onTap: () {
          
                    },
                    title: "Physics",
                    subtitle: "Mechanics, Thermodynamics",
                    icon: Icons.science_rounded,
                  ),
                  const SizedBox(height: 12),
                  _subjectCard(
                    onTap: () {
          
          
                    },
                    title: "Chemistry",
                    subtitle:
                    "Organic, Inorganic, Physical, Zoology, Botany & Reproduction",
                    icon: Icons.ac_unit_rounded,
                  ),
                ],
              ),
          
              const SizedBox(height: 28),
          
              /// ---------------- Recently Viewed ----------------
              Text(
                "Recently Viewed",
                style: semiBoldTextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 14),
          
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _recentCard("Cell Cycle"),
                    _recentCard("Chemical Bonding"),
                    _recentCard("Motion in Plane"),
                    _recentCard("Gravitation"),
                  ],
                ),
              ),
              hSized15,
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- Subject Card ----------------
  Widget _subjectCard({
    required VoidCallback onTap,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: MyColors.color295176,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 28),
                wSized5,
                Text(
                  title,
                  style: semiBoldTextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: regularTextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- Recently Viewed Card ----------------
  Widget _recentCard(String title) {
    return Container(
      height: 93,
      width: 117,
      margin: const EdgeInsets.only(right: 12,),
      padding: const EdgeInsets.symmetric(horizontal: 8,),
      decoration: BoxDecoration(
        color: MyColors.color295176,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       SvgPicture.asset(IconsPath.flashQ),
          hSized20,
          Text(
            title,
            style: regularTextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
