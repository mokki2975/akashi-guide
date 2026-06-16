import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail_screen.dart';
import 'side_trip_screen.dart';

/// アプリ全体で共通して使用する色
class AppColors {
  static const Color primaryNavy = Color(0xFF1A237E);
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color highlightGold = Color(0xFFB8860B);
  static const Color backgroundBlue = Color(0xFFE3F2FD);
  static const Color surfaceWhite = Color(0xFFF8F9FA);
}

/// データモデル
class GuideItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String imagePath;
  final String description;
  final String locationQuery;
  final bool showSimulation;
  final bool showRecommendation;

  const GuideItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.imagePath,
    required this.description,
    required this.locationQuery,
    this.showSimulation = false,
    this.showRecommendation = false,
  });
}

// 王道データ
final List<GuideItem> guideItems = [
  const GuideItem(
    title: '歴史',
    subtitle: '日本の時を刻む\n「天文科学館と子午線」',
    icon: Icons.museum_outlined,
    imagePath: 'assets/images/history.jpg',
    description: '明石市は「日本標準時子午線（東経135度）」が通る「時のまち」として知られています。この基準は1884年、アメリカのワシントンDCで開催された国際会議で定められました。イギリスのグリニッジ天文台を基準（本初子午線）とし、ちょうど15度ごとに1時間の時差が生じる計算から、日本はこの135度線を採用しました。\n\nその象徴が「明石市立天文科学館」です。ここにそびえ立つ大時計は、日本標準時を刻む非常に重要な役割を担っています。特筆すべきは、この時計の歴史です。初代は戦火で失われ、2代目は1995年の阪神・淡路大震災で止まってしまいました。現在の3代目は、震災を乗り越え、明石の復興とともに歩み続けているシンボルでもあります。\n\n明石を訪れる際、「日本の時間はここから始まっている」という事実は、これからの人生を豊かにする知的なエピソードの1つにきっとなるはずです。一秒の重みを感じる、明石ならではの歴史をぜひ体感してください。',
    locationQuery: 'J2X2+QH 明石市、兵庫県',
  ),
  const GuideItem(
    title: '食物',
    subtitle: 'たこ焼きの先祖\n「明石焼（玉子焼）」',
    icon: Icons.restaurant_menu_outlined,
    imagePath: 'assets/images/food.jpg',
    description: '大阪名物の「たこ焼き」のルーツが、実は明石にあることをご存知でしょうか。その名は「明石焼（地元では玉子焼と呼ばれます）」。江戸時代末期、明石の特産品であった「明石玉（人工珊瑚）」という工芸品を作る際、接着剤として卵白が大量に使われました。その際に余った「卵黄」を無駄にしないために生まれたのが、この料理の始まりです。\n\n1935年、大阪のラヂオ焼店が「明石ではタコを入れている」という噂を聞き、中身をタコに変えたことが、現在のたこ焼きの誕生に繋がりました。つまり、明石焼こそがタコ入り粉もん文化のパイオニアなのです。\n\n特徴は、たっぷりの卵と「じん粉（浮き粉）」を使ったふわふわの食感。ソースではなく、上品な出汁に浸して食べるスタイルは、一口食べれば、庶民的なたこ焼きとは一線を画す、工芸品の歴史から生まれた「気品」を感じることができるでしょう。',
    locationQuery: 'JXWV+69 明石市、兵庫県',
    showRecommendation: true,
  ),
  const GuideItem(
    title: '自然',
    subtitle: '震災が生んだ奇跡\n「明石海峡大橋」',
    icon: Icons.landscape_outlined,
    imagePath: 'assets/images/nature.jpg',
    description: '神戸と淡路島を繋ぐ、世界最大級の吊り橋「明石海峡大橋」。この巨大な構造物には、エンジニアリングの粋を集めた驚くべきエピソードが隠されています。\n\n建設中の1995年、この地を阪神・淡路大震災が襲いました。震源に極めて近い場所に位置していたものの、橋脚自体は最新の耐震技術により致命的な損傷を免れました。しかし、激しい地殻変動の影響で、地盤そのものが動き、なんと橋の全長が当初の設計よりも「約1メートル」伸びてしまったのです。\n\n絶望的な状況かと思われましたが、設計段階で持たせていた十分な「遊び（マージン）」と、柔軟な設計変更により、そのまま工事が続行されました。この「伸びた1メートル」こそが、日本の土木技術の高さと、どんな困難にも折れない柔軟な強さの証拠です。\n\nまた、夜には季節や時間によって変化する鮮やかなライトアップが施され、別名「パールブリッジ」とも呼ばれます。一目見たときに移る鮮やかな光が、これからの活力としてきっと映るでしょう。',
    locationQuery: 'J2FG+5P 神戸市、兵庫県',
    showSimulation: true,
  ),
  const GuideItem(
    title: '文化',
    subtitle: '宮本武蔵の町割りが残る\n「魚の棚商店街」',
    icon: Icons.palette_outlined,
    imagePath: 'assets/images/culture.jpg',
    description: '明石駅のすぐそば、約400年の歴史を誇る「魚の棚（うおんたな）商店街」。この活気ある商店街の土台を作ったのは、あの伝説の剣豪・宮本武蔵だという伝説が残っています。当時、武蔵が明石の町割（都市計画）を行った際に、この商店街もその設計の一部に組み込まれていたとされています。\n\nここ最大の特徴は、全国的にも珍しい「昼網（ひるあみ）」の文化です。通常の市場は早朝にセリが行われますが、漁場が目と鼻の先にある明石では、正午過ぎにもセリが行われます。そのため、夕方には「さっきまで海で泳いた魚」が店頭に並ぶことで、夕飯には非常に新鮮な魚をいただくことができます。\n\nアーケードの下を歩けば、威勢の良い掛け声とともに、明石鯛や明石ダコといった高級ブランド魚が所狭しと並ぶ光景に出会えます。港町特有の活気あるエネルギーを感じたいなら、ここは外せません。古い歴史と最新の鮮度が共存する、まさに「明石の台所」とも言える場所です。',
    locationQuery: 'JXWR+RW 明石市、兵庫県',
  ),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AKASHI Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundBlue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryNavy,
          primary: AppColors.accentGold,
        ),
        textTheme: GoogleFonts.notoSansJpTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth > 800;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryNavy,
        title: Text(
          'AKASHI GUIDE',
          style: GoogleFonts.notoSerifJp(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body:Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isWideScreen ? 1200 : 500),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: isWideScreen ? _buildWideLayout() : _buildMobileLayout(),
            ),
          ),
        ),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      children: [
        Expanded(child: MenuTile(item: guideItems[0])),
        const SizedBox(width: 16),
        Expanded(child: MenuTile(item: guideItems[1])),
        const SizedBox(width: 16),
        Expanded(child: MenuTile(item: guideItems[2])),
        const SizedBox(width: 16),
        Expanded(child: MenuTile(item: guideItems[3])),
        const SizedBox(width: 16),
        const Expanded(child: SideTripMenuTile()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.95,
          children: [
            MenuTile(item: guideItems[0]),
            MenuTile(item: guideItems[1]),
            MenuTile(item: guideItems[2]),
            MenuTile(item: guideItems[3]),
          ],
        ),
        const SizedBox(height: 16),
        const SizedBox(
          width: double.infinity,
          height: 120,
          child: SideTripMenuTile(),
        ),
      ],
    );
  }
}

class MenuTile extends StatelessWidget {
  final GuideItem item;
  const MenuTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: item.title,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.accentGold.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(item: item),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon, color: AppColors.accentGold, size: 36),
                  const SizedBox(height: 16),
                  Text(
                    item.title,
                    style: GoogleFonts.notoSerifJp(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSansJp(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SideTripMenuTile extends StatelessWidget {
  const SideTripMenuTile({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen =
        MediaQuery.of(context).size.width > 800;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryNavy.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SideTripScreen(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: isWideScreen
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.explore_outlined,
                        color: AppColors.accentGold,
                        size: 36,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '寄り道',
                        style: GoogleFonts.notoSerifJp(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.primaryNavy,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '地元民お勧め\nサクッと巡るスポット',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoSansJp(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.explore_outlined,
                        color: AppColors.accentGold,
                        size: 40,
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '寄り道',
                            style: GoogleFonts.notoSerifJp(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.primaryNavy,
                            ),
                          ),
                          Text(
                            '地元民お勧め・サクッと巡るスポット',
                            style: GoogleFonts.notoSansJp(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}