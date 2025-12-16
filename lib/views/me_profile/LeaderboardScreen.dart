import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
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
  bool isLoading = true;

  List<List<LeaderboardUser>> leaderboardData = [[], [], []];

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
      final res = await ApiMethods().getMethod(
        method: url,
        body: {},
        header: ApiHeaders.defaultHeaders,
      );

      if (res.isNotEmpty) {
        final jsonData = jsonDecode(res);
        final list = jsonData['data'] as List;
        leaderboardData[i] = list
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
          ? const Center(child: CommonLoader(color: Colors.white))
          : Column(
              children: [
                const SizedBox(height: 20),

                SvgPicture.asset(IconsPath.appLogoWhite, height: 90),
                const SizedBox(height: 20),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        _tabs(),
                        const SizedBox(height: 10),

                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              ui(leaderboardData[0]),
                              ui(leaderboardData[1]),
                              ui(leaderboardData[2]),
                            ],
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

  Widget _tabs() {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.rankBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: TabBar(
        indicatorPadding: EdgeInsetsGeometry.symmetric(horizontal: -15),
        controller: tabController,
        indicator: BoxDecoration(
          color: MyColors.color19B287,
          borderRadius: BorderRadius.circular(14),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: const [
          Tab(text: "All Time"),
          Tab(text: "Last 30 Days"),
          Tab(text: "Last 7 Days"),
        ],
      ),
    );
  }

  // MAIN UI
  Widget ui(List<LeaderboardUser> users) {
    if (users.isEmpty) {
      return Center(
        child: Text(
          "No leaderboard data",
          style: mediumTextStyle(fontSize: 16),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              wSized12,
              if (users.length > 1) podiumSmall(users[1], Colors.pink),
              const SizedBox(width: 16),
              podiumLarge(users[0]),
              const SizedBox(width: 16),
              if (users.length > 2) podiumSmall(users[2], Colors.green),
            ],
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text(
                  "Players around you",
                  style: semiBoldTextStyle(fontSize: 16),
                ),
                // const Spacer(),
                // Text(
                //   "View all",
                //   style: mediumTextStyle(
                //     fontSize: 14,
                //     color: MyColors.appTheme,
                //   ),
                // ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // LIST
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: users.length > 3 ? (users.length - 3) : 0,
            itemBuilder: (context, index) {
              final user = users[index + 3];
              return listTile(user);
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // SMALL PODIUM USER
  Widget podiumSmall(LeaderboardUser user, Color ringColor) {
    return Column(
      children: [
        hSized40,
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(radius: 40, backgroundImage: _loadImage(user)),
            Positioned(
              bottom: -0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: ringColor,
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
          user.name.toString(),
          style: semiBoldTextStyle(fontSize: 12, color: Colors.black54),
        ),
        Text("${user.avgPercentage}%", style: semiBoldTextStyle(fontSize: 14)),
      ],
    );
  }

  // LARGE CENTER PODIUM EXACT LIKE IMAGE
  Widget podiumLarge(LeaderboardUser user) {
    return Column(
      children: [
        Text(
          user.name,
          style: mediumTextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 8),

        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xffFFB27D), Color(0xffFF7E5F)],
                ),
              ),
            ),
            CircleAvatar(radius: 55, backgroundImage: _loadImage(user)),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
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

        const SizedBox(height: 6),
        Text("${user.avgPercentage}%", style: semiBoldTextStyle(fontSize: 16)),
      ],
    );
  }

  Widget listTile(LeaderboardUser user) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            color: Colors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(user.rank.toString(), style: mediumTextStyle(fontSize: 15)),
          const SizedBox(width: 16),

          CircleAvatar(radius: 20, backgroundImage: _loadImage(user)),
          const SizedBox(width: 10),

          Expanded(
            child: Text(user.name, style: mediumTextStyle(fontSize: 15)),
          ),

          Text(
            "${user.avgPercentage}%",
            style: semiBoldTextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  ImageProvider _loadImage(LeaderboardUser u) {
    return (u.profilePicture != null && u.profilePicture!.isNotEmpty)
        ? NetworkImage(u.profilePicture!)
        : const AssetImage("assets/images/defultImage.png");
  }
}
