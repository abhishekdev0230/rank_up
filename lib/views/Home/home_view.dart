import 'dart:math';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/custom_classes/CommonProfileImage.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/custom_classes/validators.dart';
import 'package:rank_up/models/HomeDataModel.dart';
import 'package:rank_up/provider/provider_classes/HomeProvider.dart';
import 'package:rank_up/views/FlashcardQ/NeetPYQsFlashcardsInner.dart';
import 'package:rank_up/views/Home/ImportantTopicsScreen.dart';
import '../../models/LeaderboardModel.dart';
import '../../provider/provider_classes/leaderboard_provider.dart';
import '../FlashcardQ/DimensionalAnalysis/dimensional_analysis.dart';
import '../me_profile/LeaderboardScreen.dart';
import '../me_profile/NotificationScreen.dart';
import '../me_profile/ProfileScreen.dart';
import '../me_profile/SubscriptionScreen/SubscriptionScreen.dart';
import '../tests_screen/ShowInstructionDialog.dart';
import 'feature_deck_questions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() {
        context.read<LeaderboardProvider>().fetchLeaderboard();
      });
      Provider.of<HomeProvider>(
        context,
        listen: false,
      ).fetchHomeData(context).then((_) => _initializeDeckColors());
    });
  }

  Map<int, Color> deckColors = {};

  void _initializeDeckColors() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    final decks = provider.homeData?.data?.featuredDecks ?? [];
    final colorList = [
      MyColors.appTheme,
      MyColors.color32B790,
      MyColors.color19B287,
      MyColors.color375EC2,
      MyColors.color7358BC,
      MyColors.colorFF5F37,
      MyColors.color9696,
      MyColors.colorFA81C3,
    ];
    final random = Random();

    setState(() {
      for (int i = 0; i < decks.length; i++) {
        deckColors[i] = colorList[random.nextInt(colorList.length)];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    final data = provider.homeData?.data;

    return CommonScaffold(
      backgroundColor: MyColors.appTheme,
      appBarVisible: false,
      padding: false,
      showBack: false,
      useSafeArea: false,
      body: RefreshIndicator(
        color: MyColors.appTheme,
        onRefresh: () async =>
            await provider.fetchHomeData(context, showLoader: false),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _headerSection(data, provider),
              _mainBody(data, provider),

            ],
          ),
        ),
      ),
    );
  }
  ///,..............Leaderboard................

  Widget _homeLeaderboardSection() {
    return Consumer<LeaderboardProvider>(
      builder: (context, lbProvider, _) {
        final users = lbProvider.leaderboardData[0]; // All time
        if (users.isEmpty) return const SizedBox();

        final top3 = users.take(3).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _sectionTitle("Leaderboard", 140),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    CustomNavigator.pushNavigate(
                      context,
                      const LeaderboardScreen(),
                    );
                  },
                  child: Text(
                    "See more",
                    style: TextStyle(color: MyColors.darkBlue),
                  ),
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: MyColors.whiteText,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: MyColors.colorCBCBCB),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  top3.length,
                      (index) => _leaderboardUser(top3[index]),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  Widget _leaderboardUser(LeaderboardUser user) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundImage: (user.profilePicture != null &&
                  user.profilePicture!.isNotEmpty)
                  ? NetworkImage(user.profilePicture!)
                  : const AssetImage("assets/images/defultImage.png")
              as ImageProvider,
            ),

            /// Rank Badge
            Positioned(
              bottom: -6, // ✅ allowed here
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: MyColors.color19B287,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "#${user.rank}",
                  style: semiBoldTextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          user.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: mediumTextStyle(fontSize: 12),
        ),
      ],
    );
  }


  /// ---------------- Header Section ----------------
  Widget _headerSection(HomeData? data, HomeProvider provider) {
    final user = data?.user;
    final progress = (data?.moduleProgress?.progressPercentage ?? 0) / 100;
    final completedModules = data?.moduleProgress?.completedModules ?? 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 25),
      color: MyColors.appTheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerTop(user,provider),
          const SizedBox(height: 24),
          _progressSection(progress, completedModules),
        ],
      ),
    );
  }

  Widget _headerTop(User? user,provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {

            CustomNavigator.pushNavigate(context, ProfileScreen());
          },
          child: Row(
            children: [
              CommonProfileImage(
                imageUrl: user?.profilePicture ?? "",
                placeholderAsset: IconsPath.defultImage,
                radius: 24,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${provider.getGreeting()},",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),

                  Text(
                    user?.name ?? "",
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
        ),
         GestureDetector(



             onTap: (){
               pushScreen(
                 context,
                 screen: NotificationScreen(),
                 withNavBar: false,
               );

             },
             child: Icon(Icons.notifications_none, color: Colors.white, size: 28)),
      ],
    );
  }

  Widget _progressSection(double progress, int completedModules) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress.clamp(0, 1),
            minHeight: 7,
            color: MyColors.color19B287,
            backgroundColor: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "$completedModules Module Completed",
          style: semiBoldTextStyle(fontSize: 14, color: MyColors.whiteText),
        ),
      ],
    );
  }

  /// ---------------- Main Body ----------------
  Widget _mainBody(HomeData? data, HomeProvider provider) {
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
          if (data?.dailyQuestion != null) _qotdSection(data!.dailyQuestion!),
          hSized24,

          if (data?.featuredDecks?.isNotEmpty == true)     Text(
            "Featured Deck",
            style: semiBoldTextStyle(fontSize: 19, color: MyColors.blackColor),
          ),
          if (data?.featuredDecks?.isNotEmpty == true)  hSized10,
          if (data?.featuredDecks?.isNotEmpty == true)
            featuredDecks(data!.featuredDecks!, provider),
          hSized24,
          if (data?.liveTest != null) _liveTestCard(data!.liveTest!),
          hSized24,

          if (data?.pausedModule != null) _moduleCard(data!.pausedModule!),
          hSized24,

          if (data?.solveNext != null) solveNext(data!.solveNext!),
          hSized24,
          Row(
            children: [
              _sectionTitle("Important Topics", 180),
              Spacer(),
              TextButton(
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ImportantTopicsScreen(),
                      ),
                    );
                  });
                },
                child: Text(
                  "See all",
                  style: TextStyle(color: MyColors.darkBlue),
                ),
              ),

            ],
          ),
          if (data?.importantTopics?.isNotEmpty == true)
            _importantTopicsSection(data!.importantTopics!),
          hSized20,
          _homeLeaderboardSection(),
          hSized20,

          _subscriptionButton(),
          hSized20,
        ],
      ),
    );
  }

  /// ---------------- Title Widget ----------------
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

  /// ---------------- QOTD ----------------
  Widget _qotdSection(DailyQuestion qotd) {
    return commonContainer(
      Row(
        children: [
          if (qotd.icon != null)
            CommonNetworkImage(imageUrl: qotd.icon!, height: 24, width: 24),
          wSized7,
          Expanded(
            child: Text(
              "Q: ${qotd.questionText ?? ''}",
              style: regularTextStyle(
                fontSize: 16,
                color: MyColors.color949494,
              ),
            ),
          ),
          wSized10,
          CommonButton(title: "Reveal", onPressed: () {


            pushScreen(
              context,
              screen: DimensionalAnalysis(
                title: qotd.chapter?.name ?? "",
                type: "TackQuiz",
                totalFlashcards: "0",
                totalQuizzes: qotd.chapter?.id.toString() ?? "0",
                totalQuestions: "1",
                topicId: qotd.topic?.id.toString() ?? "",
              ),
              withNavBar: true,
              pageTransitionAnimation:
              PageTransitionAnimation.cupertino,
            );

          }),
        ],
      ),
    );
  }

  /// ---------------- Featured Decks ----------------
  Widget featuredDecks(List<FeaturedDeck> decks, HomeProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(decks.length, (index) {
          final deck = decks[index];

          final isSelected = provider.selectedDeckIndex == index;

          return GestureDetector(
            onTap: () {
              provider.setSelectedDeckIndex(index);
              if (deck != null) {
                CustomNavigator.pushNavigate(
                  context,
                  FeaturedDeckFlashcardsScreen(deckId:deck.id.toString(), deckName: deck.name.toString(),),
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: deckColors[index] ?? MyColors.appTheme,
                border: Border.all(
                  color: isSelected ? MyColors.colorFA81C3 : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              height: 65,
              width: 78,
              alignment: Alignment.center,
              child: Text(
                deck.name.toString() ?? "",
                textAlign: TextAlign.center,
                style: mediumTextStyle(fontSize: 12, color: MyColors.whiteText),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// ---------------- Live Test ----------------
  Widget _liveTestCard(LiveTest test) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    return commonContainer(
      containerBgColor: MyColors.appTheme,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: "Live Test of the Day: ",
              style: semiBoldTextStyle(fontSize: 16, color: MyColors.whiteText),
              children: [
                TextSpan(
                  text: test.title ?? "",
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
                "Start in: ${CommonValidators.formatTime(provider.remainingSeconds)}",
                style: mediumTextStyle(fontSize: 14, color: MyColors.whiteText),
              ),

              const Spacer(),
              _outlineButton(
                test.isLive == true ? "Review" : "Starting Soon",
                borderColor: Colors.white,
                textColor: Colors.white,
                onTap: test.isLive == true
                    ? () {
                        ShowInstructionDialog.showDetailedInstructions(
                          context,
                          test.id.toString(),
                          test.title ?? "",
                          totalQuetion:test.totalQuestions,
                          true,
                        );
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ---------------- Paused Module ----------------
  Widget _moduleCard(PausedModule module) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Paused Module", 180),
        hSized10,
        commonContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Module : ",
                    style: semiBoldTextStyle(
                      fontSize: 16,
                      color: MyColors.blackColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 2,
                      module.topicName ?? "---",
                      style: mediumTextStyle(
                        fontSize: 16,
                        color: MyColors.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (module.progressPercentage ?? 0) / 100,
                        color: MyColors.appTheme,
                        backgroundColor: MyColors.rankBg,
                        minHeight: 8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _outlineButton(
                    "Resume",
                    borderColor: MyColors.appTheme,
                    textColor: MyColors.appTheme,
                    onTap: () {
                      CustomNavigator.pushNavigate(
                        context,
                        NeetPYQsFlashcardsInner(
                          topicId: module.topicId.toString(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// ---------------- solveNext Module ----------------
  Widget solveNext(SolveNext module) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Solve Next", 180),
        hSized10,
        commonContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "Quiz : ",
                    style: semiBoldTextStyle(
                      fontSize: 16,
                      color: MyColors.blackColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 2,
                      module.topicName ?? "---",
                      style: mediumTextStyle(
                        fontSize: 16,
                        color: MyColors.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (module.progressPercentage ?? 0) / 100,
                        color: MyColors.appTheme,
                        backgroundColor: MyColors.rankBg,
                        minHeight: 8,
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  _outlineButton(
                    onTap: () {
                      pushScreen(
                        context,
                        screen: DimensionalAnalysis(
                          title: module.chapterName ?? "",
                          type: "TackQuiz",
                          totalFlashcards: "0",
                          totalQuizzes: module.id.toString() ?? "0",
                          totalQuestions: "1",
                          topicId: module.topicId.toString(),
                        ),
                        withNavBar: true,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    "Resume",
                    borderColor: MyColors.appTheme,
                    textColor: MyColors.appTheme,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// ---------------- Important Topics ----------------
  Widget _importantTopicsSection(List<ImportantTopic> topics) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: topics.map((topic) {
          return GestureDetector(
            onTap: () {

              if (topic.id != null) {
                CustomNavigator.pushNavigate(
                  context,
                  NeetPYQsFlashcardsInner(topicId: topic.id.toString()),
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              child: _importantTopicCard(
                topic.name ?? "",
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// ---------------- Important Topic Card ----------------
  Widget _importantTopicCard(String title, ) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12),
      height: 80,
      width: 180,
      decoration: BoxDecoration(
        color: MyColors.whiteText,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.colorCBCBCB),
      ),
      child: Text(
        textAlign: TextAlign.center,
        title,
        maxLines: 1,
        style: semiBoldTextStyle(fontSize: 18, color: MyColors.blackColor),
      ),
    );
  }

  /// ---------------- Subscription Button ----------------
  Widget _subscriptionButton() {
    return Center(
      child: GestureDetector(
        onTap: (){

          CustomNavigator.pushNavigate(context, SubscriptionScreen());
        },
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
      ),
    );
  }











  /// ---------------- Common Container ----------------
  Widget commonContainer(Widget child, {Color? containerBgColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: containerBgColor ?? MyColors.whiteText,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.colorCBCBCB),
      ),
      child: child,
    );
  }

  /// ---------------- Common Button ----------------
  Widget CommonButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
        decoration: BoxDecoration(
          color: MyColors.appTheme,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: MyColors.whiteText),
        ),
        child: Text(
          title,
          style: semiBoldTextStyle(fontSize: 12, color: MyColors.whiteText),
        ),
      ),
    );
  }

  /// ---------------- Outline Button ----------------
  Widget _outlineButton(
    String title, {
    Color? borderColor,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: borderColor ?? MyColors.appTheme),
        ),
        child: Text(
          title,
          style: semiBoldTextStyle(color: textColor ?? MyColors.appTheme),
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
  final double? borderRadius;

  const CommonButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.fontSize,
    this.textColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
        decoration: BoxDecoration(
          color: MyColors.appTheme,
          borderRadius: BorderRadius.circular(borderRadius ?? 19),
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
  final VoidCallback? onPressed;
  final double? fontSize;
  final Color? textColor;
  final double? borderRadius;
  final Color? bgColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const CommonButton1({
    super.key,
    required this.title,
    this.onPressed,
    this.fontSize,
    this.textColor,
    this.borderRadius,
    this.bgColor,
    this.borderColor,
    this.height,
    this.width,
    this.padding, // <-- ADD THIS
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        height: height,
        width: width,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDisabled
              ? Colors.grey.withOpacity(0.4)
              : (bgColor ?? MyColors.color32B790),
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          border: Border.all(
            color: borderColor ?? bgColor ?? MyColors.color32B790,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: semiBoldTextStyle(
            fontSize: fontSize ?? 12,
            color: isDisabled
                ? Colors.black54
                : (textColor ?? MyColors.whiteText),
          ),
        ),
      ),
    );
  }
}
