import 'package:flutter/material.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
        child: Column(
          children: const [

            _Header(),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    _Banner(),

                    SizedBox(height: 14),

                    _TutorialSlider(),

                    SizedBox(height: 16),

                    _ProductSlider(),

                    SizedBox(height: 16),

                    _CategoryGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [

          Image.asset(
            "assets/images/logo.png",
            height: 30,
          ),

          const Spacer(),

          const Icon(Icons.search, size: 22),
          const SizedBox(width: 16),

          const Icon(Icons.notifications_none, size: 22),
          const SizedBox(width: 16),

          const Icon(Icons.shopping_cart_outlined, size: 22),
        ],
      ),
    );
  }
}
class _Banner extends StatelessWidget {
  const _Banner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage("assets/images/banner_market.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
class _TutorialSlider extends StatelessWidget {
  const _TutorialSlider();

  @override
  Widget build(BuildContext context) {
    final images = [
      "assets/images/electric_pole.png",
      "assets/images/factory.png",
      "assets/images/solar_energy.png",
      "assets/images/mccb_3p.png",
    ];

    return SizedBox(
      height: 180,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                images[index],
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProductSlider extends StatefulWidget {
  const _ProductSlider();

  @override
  State<_ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<_ProductSlider> {

  final PageController controller = PageController();

  int current = 0;

  final products = [
    "assets/images/solar_energy.png",
    "assets/images/mccb_3p.png",
    "assets/images/factory.png",
  ];

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 140,
      child: Stack(
        children: [

          /// SLIDER
          PageView.builder(
            controller: controller,
            itemCount: products.length,
            onPageChanged: (index) {
              setState(() {
                current = index;
              });
            },
            itemBuilder: (context, index) {

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _ProductCard(image: products[index]),
              );
            },
          ),

          /// LEFT BUTTON
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.chevron_left, size: 32),
              onPressed: () {
                controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
            ),
          ),

          /// RIGHT BUTTON
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.chevron_right, size: 32),
              onPressed: () {
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class _ProductCard extends StatelessWidget {

  final String image;

  const _ProductCard({required this.image});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [
            Color(0xffe3a300),
            Color(0xfff6c542),
          ],
        ),
      ),
      child: Row(
        children: [

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Đồng hồ năng lượng",
                  style: TextStyle(fontSize: 12),
                ),

                SizedBox(height: 6),

                Text(
                  "Sản phẩm cho dân dụng",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "xem ngay",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),

          Image.asset(
            image,
            width: 90,
          )
        ],
      ),
    );
  }
}
class _HotProduct extends StatelessWidget {
  const _HotProduct();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.orange.shade200,
      ),
      child: Row(
        children: [

          const SizedBox(width: 16),

          const Expanded(
            child: Text(
              "Sản phẩm cho dân dụng",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Image.asset(
            "assets/images/device.png",
            width: 100,
          )
        ],
      ),
    );
  }
}
class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid();

  @override
  Widget build(BuildContext context) {

    final items = [
      {"icon": "assets/images/mccb_3p.png", "text": "Đồng hồ & đo lường"},
      {"icon": "assets/images/mm50h_1p.png", "text": "Bộ đóng ngắt"},
      {"icon": "assets/images/mm50h_2p.png", "text": "Cầu dao thông minh"},
      {"icon": "assets/images/mm50h_3p.png", "text": "Cổng thông minh"},
      {"icon": "assets/images/mm50h_4p.png", "text": "Thiết bị Tuya"},
      {"icon": "assets/images/solar_energy.png", "text": "Giải pháp viễn thông"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {

          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset(
                  items[index]["icon"]!,
                  height: 32,
                ),

                const SizedBox(height: 8),

                Text(
                  items[index]["text"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}