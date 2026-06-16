import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';

class DetailScreen extends StatefulWidget {
  final GuideItem item;

  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isAnimating = false;

  void _handleAnimationStatus(AnimationStatus status) async {
    if (status == AnimationStatus.completed && _isAnimating) {
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted && _isAnimating) {
        _controller.reset();
        _controller.forward();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener(_handleAnimationStatus);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchMap() async {
    final String encodedQuery = Uri.encodeComponent(widget.item.locationQuery);
    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$encodedQuery";
    final Uri uri = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('マップを開けませんでした: $googleMapsUrl');
    }
  }

  Widget _buildFormattedDescription(String text) {
    final List<InlineSpan> spans = [];
    final RegExp regExp = RegExp(r'「[^」]+」');
    int lastIndex = 0;

    for (final Match match in regExp.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(text: text.substring(lastIndex, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(0),
        style: GoogleFonts.notoSansJp(
          fontWeight: FontWeight.bold,
          color: AppColors.highlightGold,
        ),
      ));
      lastIndex = match.end;
    }
    if (lastIndex < text.length) {
      spans.add(TextSpan(text: text.substring(lastIndex)));
    }

    return Text.rich(
      TextSpan(children: spans),
      textAlign: TextAlign.justify,
      style: GoogleFonts.notoSansJp(fontSize: 16, height: 1.8, color: AppColors.primaryNavy),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBlue,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.backgroundBlue,
            elevation: 0,
            leading: const BackButton(color: AppColors.primaryNavy),
            title: Text(
              widget.item.title,
              style: GoogleFonts.notoSerifJp(
                color: AppColors.primaryNavy,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: widget.item.title,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.asset(
                              widget.item.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (widget.item.showSimulation) ...[
                        _BridgeSimulationSection(
                          controller: _controller,
                          isAnimating: _isAnimating,
                          onToggle: () {
                            setState(() {
                              if (_isAnimating) {
                                _controller.stop();
                              } else {
                                _controller.forward();
                              }
                              _isAnimating = !_isAnimating;
                            });
                          },
                        ),
                      ],
                      _buildFormattedDescription(widget.item.description),
                      const SizedBox(height: 40),
                      if (widget.item.showRecommendation) ...[
                        const _RecommendationNote(),
                        const SizedBox(height: 12),
                      ],
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton.icon(
                          onPressed: _launchMap,
                          icon: const Icon(Icons.map_outlined),
                          label: Text(
                            "ここへ行く（Googleマップ）",
                            style: GoogleFonts.notoSansJp(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryNavy,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BridgeSimulationSection extends StatelessWidget {
  final AnimationController controller;
  final bool isAnimating;
  final VoidCallback onToggle;

  const _BridgeSimulationSection({
    required this.controller,
    required this.isAnimating,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "震災の地殻変動による「1mの伸び」を再現（シミュレーション）",
          style: GoogleFonts.notoSerifJp(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.accentGold,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              final double lengthCm = controller.value * 100;
              return Text(
                "${lengthCm.toInt()} cm",
                style: GoogleFonts.robotoMono(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: lengthCm >= 100 ? Colors.redAccent : AppColors.primaryNavy,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return CustomPaint(
                size: const Size(double.infinity, 100),
                painter: BridgeStretchPainter(controller.value),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton.icon(
            onPressed: onToggle,
            icon: Icon(isAnimating ? Icons.pause : Icons.play_arrow),
            label: Text(isAnimating ? "停止する" : "シミュレーション開始"),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.primaryNavy,
            ),
          ),
        ),
        const Divider(height: 32, color: AppColors.accentGold),
      ],
    );
  }
}

class _RecommendationNote extends StatelessWidget {
  const _RecommendationNote();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.recommend, color: Colors.redAccent, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "マップの場所は、地元でも評判の「個人的におススメの店舗」に設定しています。",
            style: GoogleFonts.notoSansJp(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}

class BridgeStretchPainter extends CustomPainter {
  final double progress;
  BridgeStretchPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accentGold
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final double centerX = size.width / 2;
    final double baseY = size.height - 30;
    
    double baseWidth = size.width * 0.5;
    double currentWidth = baseWidth + (progress * 80);

    double startX = centerX - (currentWidth / 2);
    double endX = centerX + (currentWidth / 2);

    double pierOffset = 50 + (progress * 10);
    canvas.drawLine(Offset(centerX - pierOffset, baseY), Offset(centerX - pierOffset, baseY - 50), paint);
    canvas.drawLine(Offset(centerX + pierOffset, baseY), Offset(centerX + pierOffset, baseY - 50), paint);

    canvas.drawLine(Offset(startX, baseY - 45), Offset(endX, baseY - 45), paint);
    
    final path = Path();
    path.moveTo(startX, baseY - 45);
    path.quadraticBezierTo(centerX, baseY - 90, endX, baseY - 45);
    canvas.drawPath(path, paint);

    if (progress > 0) {
      final arrowPaint = Paint()..color = Colors.redAccent..strokeWidth = 2;
      canvas.drawLine(Offset(startX, baseY - 20), Offset(startX - 15, baseY - 20), arrowPaint);
      canvas.drawLine(Offset(endX, baseY - 20), Offset(endX + 15, baseY - 20), arrowPaint);
    }
  }

  @override
  bool shouldRepaint(BridgeStretchPainter oldDelegate) => oldDelegate.progress != progress;
}