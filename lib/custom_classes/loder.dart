import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
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
      useRootNavigator: true, // always use rootNavigator explicitly
      builder: (context) {
        return const Center(
          child: CommonLoader(
            color: MyColors.whiteText,
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    try {
      Navigator.of(context, rootNavigator: true).pop(); // match rootNavigator
    } catch (e) {
      // Already closed or not shown, ignore
      print("Loader hide error: $e");
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


/// Usage:
/// LeaderboardChart(
///   averageScore: 72,
///   solved: 1200,
///   total: 1500,
///   size: 120,
/// )

class LeaderboardChart extends StatelessWidget {
  final int averageScore;
  final int solved;
  final int total;
  final double size;

  const LeaderboardChart({
    Key? key,
    required this.averageScore,
    required this.solved,
    required this.total,
    this.size = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remaining = (total - solved).clamp(0, total);
    final solvedPct = total > 0 ? solved / total : 0.0;
    final remainingPct = total > 0 ? remaining / total : 0.0;

    // Colors (professional palette)
    final gradientStart = Color(0xFF19B287); // teal-green
    final gradientMid = Color(0xFF2AB7D9); // cyan-blue
    final backgroundArc = Color(0xFFE8F6F3); // very light teal
    final remainingColor = Color(0xFFF1F5F9); // light grey

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Donut chart
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _DonutPainter(
              solvedPct: solvedPct,
              solvedColorStart: gradientStart,
              solvedColorEnd: gradientMid,
              bgColor: backgroundArc,
              remainingColor: remainingColor,
              strokeWidth: size * 0.14, // proportional stroke
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$solved",
                    style: TextStyle(
                      fontSize: size * 0.16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "/ $total",
                    style: TextStyle(
                      fontSize: size * 0.10,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${averageScore.toString()}% avg",
                    style: TextStyle(
                      fontSize: size * 0.10,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Legend / stats (right side)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _legendRow(gradientStart, gradientMid, "Solved", solved, total, solvedPct),
              const SizedBox(height: 8),
              _statRow("Remaining", remaining, "${(remainingPct * 100).toStringAsFixed(0)}%"),
              const SizedBox(height: 8),
              _statRow("Average Score", averageScore, "${averageScore.toString()}%"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _legendRow(Color start, Color end, String title, int value, int total, double pct) {
    return Row(
      children: [
        // gradient box mimic
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [start, end]),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: start.withOpacity(0.12), blurRadius: 6, offset: Offset(0, 2)),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          "$value (${(pct * 100).toStringAsFixed(0)}%)",
          style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _statRow(String title, int value, String trailing) {
    return Row(
      children: [
        Container(width: 18, height: 18, decoration: BoxDecoration(color: Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 10),
        Expanded(child: Text(title, style: TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w600))),
        Text(trailing, style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double solvedPct;
  final Color solvedColorStart;
  final Color solvedColorEnd;
  final Color bgColor;
  final Color remainingColor;
  final double strokeWidth;

  _DonutPainter({
    required this.solvedPct,
    required this.solvedColorStart,
    required this.solvedColorEnd,
    required this.bgColor,
    required this.remainingColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);

    // Background arc (full)
    final bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi, false, bgPaint);

    // Remaining arc - subtle overlay if any (optional)
    final remainingPaint = Paint()
      ..color = remainingColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final remainingSweep = (1.0 - solvedPct.clamp(0.0, 1.0)) * 2 * math.pi;
    if (remainingSweep > 0) {
      canvas.drawArc(rect, -math.pi / 2 + solvedPct.clamp(0.0, 1.0) * 2 * math.pi, remainingSweep, false, remainingPaint);
    }

    // Solved arc with gradient
    final solvedSweep = solvedPct.clamp(0.0, 1.0) * 2 * math.pi;
    if (solvedSweep > 0) {
      final shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: -math.pi / 2 + solvedSweep,
        colors: [solvedColorStart, solvedColorEnd],
      ).createShader(rect);

      final solvedPaint = Paint()
        ..shader = shader
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(rect, -math.pi / 2, solvedSweep, false, solvedPaint);
    }

    // Inner subtle shadow ring (to give depth)
    final innerPaint = Paint()
      ..color = Colors.black.withOpacity(0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final innerRect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2 - 2);
    canvas.drawArc(innerRect, 0, 2 * math.pi, false, innerPaint);
  }

  @override
  bool shouldRepaint(covariant _DonutPainter old) {
    return old.solvedPct != solvedPct ||
        old.solvedColorStart != solvedColorStart ||
        old.solvedColorEnd != solvedColorEnd ||
        old.bgColor != bgColor;
  }
}
