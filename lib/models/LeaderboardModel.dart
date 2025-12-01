class LeaderboardUser {
  final int rank;
  final String userId;
  final int avgPercentage;
  final int attempts;
  final String name;
  final String? profilePicture;

  LeaderboardUser({
    required this.rank,
    required this.userId,
    required this.avgPercentage,
    required this.attempts,
    required this.name,
    this.profilePicture,
  });
  factory LeaderboardUser.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    return LeaderboardUser(
      rank: json['rank'] ?? 0,
      userId: json['userId'] ?? "",
      avgPercentage: json['avg_percentage'] ?? 0,
      attempts: json['attempts'] ?? 0,
      name: user['fullName'] ?? "Unknown",
      profilePicture: user['profilePicture'],
    );
  }

}
