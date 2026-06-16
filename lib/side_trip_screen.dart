import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';

class ExtraSpot {
  final String name;
  final String comment;
  final IconData icon;
  final String plusCode;

  const ExtraSpot({
    required this.name,
    required this.comment,
    required this.icon,
    required this.plusCode,
  });
}

final List<ExtraSpot> extraSpots = [
  const ExtraSpot(
    name: '明石市立文化博物館',
    comment: '明石の歴史や豊かな文化を、豊富な資料で深く楽しく学べるスポットです。',
    icon: Icons.account_balance_outlined,
    plusCode: 'MX2W+M5 明石市、兵庫県',
  ),
  const ExtraSpot(
    name: '明石公園・明石城跡',
    comment: '美しい2基の三重櫓がそびえ立つ、歴史と豊かな自然が調和した広大な公園です。',
    icon: Icons.castle_outlined,
    plusCode: 'MX3R+MV 明石市、兵庫県',
  ),
  const ExtraSpot(
    name: 'イオン明石ショッピングセンター',
    comment: '買い物から映画、食事まで何でも揃う、地元の人々で賑わう便利な複合施設です。',
    icon: Icons.local_mall_outlined,
    plusCode: 'MWHP+C2 明石市、兵庫県',
  ),
  const ExtraSpot(
    name: '明石原人まつり湯 龍の湯',
    comment: '明石海峡大橋を一望できる露天風呂が最高！疲れを癒やす極上の天然温泉です。',
    icon: Icons.hot_tub_outlined,
    plusCode: 'J2V7+44 明石市、兵庫県',
  ),
];

class SideTripScreen extends StatelessWidget {
  const SideTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBlue,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundBlue,
        elevation: 0,
        leading: const BackButton(color: AppColors.primaryNavy),
        title: Text(
          '明石の寄り道',
          style: GoogleFonts.notoSerifJp(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '- Akashi Side-Trip -',
                      style: GoogleFonts.robotoMono(
                        fontSize: 14,
                        color: AppColors.accentGold,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'アプリ製作者がこっそりおススメする、画像なしでサクッと確認できる魅力スポット一覧。',
                  style: GoogleFonts.notoSansJp(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: extraSpots.length,
                    itemBuilder: (context, index) {
                      return ExtraSpotTile(spot: extraSpots[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExtraSpotTile extends StatelessWidget {
  final ExtraSpot spot;
  const ExtraSpotTile({super.key, required this.spot});

  Future<void> _launchMap() async {
    final String encodedQuery = Uri.encodeComponent(spot.plusCode);
    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$encodedQuery";
    final Uri uri = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('マップを開けませんでした: $googleMapsUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryNavy.withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppColors.backgroundBlue,
            shape: BoxShape.circle,
          ),
          child: Icon(spot.icon, color: AppColors.accentGold, size: 24),
        ),
        title: Text(
          spot.name,
          style: GoogleFonts.notoSerifJp(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.primaryNavy,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            spot.comment,
            style: GoogleFonts.notoSansJp(
              fontSize: 12,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.map_outlined, color: AppColors.primaryNavy),
          tooltip: 'Googleマップで開く',
          onPressed: _launchMap,
        ),
      ),
    );
  }
}