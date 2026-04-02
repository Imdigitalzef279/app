import 'package:flutter/material.dart';
import 'package:solar_energy/presentation/screen/market/product_search.dart';

import '../general_device/notification/notification_screen.dart';
import 'cart_screen.dart';
import 'category_screen/category_screen.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            height: 220, // vùng màu (có thể chỉnh 180-260)
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF50CD5A), // 🟢 xanh lá RẤT NHẸ
                  Colors.transparent,
                ],
              ),
            ),
          ),

          /// 📱 CONTENT
          SafeArea(
            child: Column(
              children: [
                _Header(),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _Banner(),

                        SizedBox(height: 14),

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
        ],
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

          IconButton(
            icon: const Icon(Icons.search, size: 22),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(),
              );
            },
          ),
          const SizedBox(width: 16),

          /// 🔔 Notification
          IconButton(
            icon: const Icon(Icons.notifications_none, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationScreen(),
                ),
              );
            },
          ),

          const SizedBox(width: 16),

          /// 🛒 Cart
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
class _Banner extends StatefulWidget {
  const _Banner();

  @override
  State<_Banner> createState() => _BannerState();
}

class _BannerState extends State<_Banner> {
  final PageController _controller = PageController();
  int current = 0;

  final banners = [
    "assets/images/matis/1.png",
    "assets/images/matis/2.png",
    "assets/images/matis/4.png",
    "assets/images/matis/5.png",
    "assets/images/matis/Enertrek System.png",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                current = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    banners[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          /// DOT
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
                    (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: current == index ? 8 : 6,
                  height: current == index ? 8 : 6,
                  decoration: BoxDecoration(
                    color: current == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
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

class _ProductSlider extends StatefulWidget {
  const _ProductSlider();

  @override
  State<_ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<_ProductSlider> {

  final PageController controller = PageController();

  int current = 0;

  final products = [
    "assets/icons/icons_new/icon_smart_breaker.png",
    "assets/icons/icons_new/icon_circuit_breaker.png",
    "assets/icons/icons_new/icon_energy_meter.png",
    "assets/icons/icons_new/icon_gateway.png",
    "assets/icons/icons_new/icon_kra_smart_safety.png",
    "assets/icons/icons_new/icon_heat_pump.png",
  ];

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 200,
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
                child: _ProductCard(icons: products),
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
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                products.length,
                    (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: current == index ? 8 : 6,
                  height: current == index ? 8 : 6,
                  decoration: BoxDecoration(
                    color: current == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
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
class _ProductCard extends StatelessWidget {
  final List<String> icons;

  const _ProductCard({required this.icons});

  @override
  Widget build(BuildContext context) {
    final images = icons;

    return Container(
      height: 170,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffcf8c00),
            Color(0xfff4c74d),
          ],
        ),
      ),
      child: Row(
        children: [

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "HÀNG ĐÃ BÁN ỔN",
                    style: TextStyle(fontSize: 10),
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Sản phẩm đa chất lượng",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),

                const SizedBox(height: 4),

                const Text(
                  "Khám phá sản phẩm và lựa chọn cho bạn",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Xem ngay",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          /// GRID ICON
          SizedBox(
            width: 150,
            height: 100,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: images.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ),
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
      {
        "icon": "assets/icons/icons_new/icon_energy_meter.png",
        "text": "Đồng hồ & đo lường"
      },
      {
        "icon": "assets/icons/icons_new/icon_smart_breaker.png",
        "text": "Cầu dao thông minh"
      },
      {
        "icon": "assets/icons/icons_new/icon_circuit_breaker.png",
        "text": "Bộ đóng ngắt"
      },
      {
        "icon": "assets/icons/icons_new/icon_gateway.png",
        "text": "Cổng thông minh"
      },
      {
        "icon": "assets/icons/icons_new/icon_environment.png",
        "text": "Thiết bị môi trường"
      },
      {
        "icon": "assets/icons/icons_new/icon_kra_smart_safety.png",
        "text": "KRA Smart Safety"
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 cột đẹp hơn
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.9, // chỉnh tỉ lệ ô
        ),
          itemBuilder: (context, index) {
            final item = items[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryScreen(
                      title: item["text"]!,
                      type: index,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(item["icon"]!, height: 60),
                    const SizedBox(height: 10),
                    Text(
                      item["text"]!,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
