import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/LeaderboardModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<List<LeaderboardUser>> leaderboardData = [[], [], []];
  bool isLoading = true;

  final filters = ["all", "30", "7"];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    _fetchLeaderboard();
  }

  Future<void> _fetchLeaderboard() async {
    setState(() => isLoading = true);

    for (int i = 0; i < filters.length; i++) {
      final url = "${ApiUrls.baseUrl}leaderboard/?filter=${filters[i]}";
      final response = await ApiMethods().getMethod(
        method: url,
        body: {},
        header: ApiHeaders.defaultHeaders,
      );

      if (response.isNotEmpty) {
        final jsonData = jsonDecode(response);
        final data = jsonData['data'] as List;
        leaderboardData[i] = data
            .map((e) => LeaderboardUser.fromJson(e))
            .toList();
      }
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBarBackgroundColor: MyColors.darkBlue,
      padding: false,
      title: "Leaderboard",
      backgroundColor: MyColors.darkBlue,
      body: isLoading
          ? const Center(child: CommonLoader(color: Colors.white,))
          : Column(
              children: [
                const SizedBox(height: 50),

                // ---------- LOGO ----------
                SvgPicture.asset(IconsPath.appLogoWhite, height: 110),

                const SizedBox(height: 10),

                // ---------- White Rounded Container ----------
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: MyColors.rankBg,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // ---------- Tabs + TabBarView ----------
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: Column(
                              children: [
                                hSized10,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: TabBar(
                                    indicatorPadding: EdgeInsets.symmetric(
                                      horizontal: -15,
                                    ),
                                    labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    dividerColor: Colors.transparent,
                                    controller: tabController,
                                    indicator: BoxDecoration(
                                      color: MyColors.color19B287,

                                      borderRadius: BorderRadius.circular(10),
                                    ),

                                    labelColor: Colors.white,
                                    labelStyle: mediumTextStyle(fontSize: 12),
                                    unselectedLabelColor: Colors.black87,
                                    tabs: const [
                                      Tab(text: "All Time"),
                                      Tab(text: "Last 30 Days"),
                                      Tab(text: "Last 7 Days"),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),

                                // ---- TAB CONTENT ----
                                Expanded(
                                  child: TabBarView(
                                    controller: tabController,
                                    children: [
                                      leaderboardUI(leaderboardData[0]),
                                      leaderboardUI(leaderboardData[1]),
                                      leaderboardUI(leaderboardData[2]),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget leaderboardUI(List<LeaderboardUser> users) {
    // ----------- EMPTY CHECK -----------
    if (users.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "No leaderboard data available",
            style: semiBoldTextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // ----------- NORMAL UI -----------
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (users.length > 1) podiumUserSmall(users[1]),
              const SizedBox(width: 10),
              if (users.isNotEmpty) podiumUserLarge(users[0]),
              const SizedBox(width: 10),
              if (users.length > 2) podiumUserSmall(users[2]),
            ],
          ),

          const SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Player around you",
                  style: semiBoldTextStyle(
                    fontSize: 16,
                    color: MyColors.blackColor,
                  ),
                ),
                const Spacer(),
                Text(
                  "View all",
                  style: mediumTextStyle(fontSize: 14, color: Colors.green),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: users.length > 3 ? users.length - 3 : 0,
            itemBuilder: (context, i) {
              final user = users[i + 3];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    Text("${user.rank}",
                        style: mediumTextStyle(fontSize: 15)),
                    const SizedBox(width: 15),
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: user.profilePicture != null
                          ? NetworkImage(user.profilePicture!)
                          : const AssetImage("assets/images/defultImage.png")
                      as ImageProvider,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        user.name,
                        style: mediumTextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      "${user.avgPercentage}%",
                      style:
                      semiBoldTextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }


  Widget podiumUserLarge(LeaderboardUser user) {
    return Column(
      children: [
        Text(user.name, style: mediumTextStyle(
          fontSize: 11,
          color: MyColors.color969696,
        ),),
        hSized10,
        Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Container(
              height: 130,
              width: 130,
              child: Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.orange, Colors.redAccent],
                      ),
                    ),
                  ),

                  CircleAvatar(
                    radius: 53,
                    backgroundImage: user.profilePicture != null
                        ? NetworkImage(user.profilePicture!)
                        : const AssetImage("assets/images/defultImage.png")
                              as ImageProvider,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  user.rank.toString(),
                  style: semiBoldTextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          "  ${user.avgPercentage}%",
          style: semiBoldTextStyle(fontSize: 15, color: Colors.black87),
        ),
      ],
    );
  }

  Widget podiumUserSmall(LeaderboardUser user) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            const CircleAvatar(
              radius: 33,
              backgroundImage: AssetImage("assets/images/defultImage.png"),
            ),
            Positioned(
              bottom: -4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  user.rank.toString(),
                  style: semiBoldTextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          "${user.avgPercentage}%",
          style: semiBoldTextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }
}
