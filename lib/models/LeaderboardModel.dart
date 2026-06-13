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
      rank: _toInt(json['rank']),
      userId: json['userId']?.toString() ?? "",
      avgPercentage: _toInt(json['avg_percentage']),
      attempts: _toInt(json['attempts']),
      name: user['fullName'] ?? "Unknown",
      profilePicture: user['profilePicture'],
    );
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.round();
    return int.tryParse(value.toString()) ?? 0;
  }
}
