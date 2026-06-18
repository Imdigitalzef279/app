import 'dart:async';
import 'package:solar_energy/data/mock/product_data.dart';
import 'package:flutter/material.dart';
import 'package:solar_energy/presentation/screen/market/product_search.dart';
import 'package:solar_energy/presentation/screen/market/notification_screen.dart';
import '../../../data/dto/product/product.dart';
import 'cart_screen.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'category_screen/category_screen.dart';
bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.width >= 600;
class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [

          ///  CONTENT
          SafeArea(
            child: Column(
              children: [
                _Header(),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _Banner(),

                        SizedBox(height: isTablet(context) ? 20 : 14),

                        _ProductSlider(),

                        SizedBox(height: isTablet(context) ? 24 : 16),

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
  int current = 0;
  final cs.CarouselSliderController controller = cs.CarouselSliderController();
  final banners = [
    "assets/images/matis/1.png",
    "assets/images/matis/2.png",
    "assets/images/matis/4.png",
    "assets/images/matis/5.png",
    "assets/images/matis/Enertrek System.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// SLIDER
        cs.CarouselSlider(
          carouselController: controller,
          options: cs.CarouselOptions(
            height: isTablet(context) ? 200 : 140,
            autoPlay: true,
            enlargeCenterPage: false,
            viewportFraction: 1, // full width
            onPageChanged: (index, reason) {
              setState(() {
                current = index;
              });
            },
          ),
          items: banners.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 6),

        /// DOT
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
                (index) => GestureDetector(
              onTap: () {
                controller.animateToPage(index);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: current == index ? 8 : 6,
                height: current == index ? 8 : 6,
                decoration: BoxDecoration(
                  color: current == index
                      ? Colors.black
                      : Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



class _ProductSlider extends StatefulWidget {
  const _ProductSlider();

  @override
  State<_ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<_ProductSlider> {

  late final PageController controller;
  late final Timer timer;
  int current = 0;

  static const int pageSize = 6;

  List<Product> get currentProducts {
    final start = current * pageSize;

    if (start >= allProducts.length) {
      return allProducts.take(pageSize).toList();
    }

    final end = (start + pageSize > allProducts.length)
        ? allProducts.length
        : start + pageSize;

    return allProducts.sublist(start, end);
  }

  @override
  void initState() {
    super.initState();

    controller = PageController();

    timer = Timer.periodic(
        const Duration(seconds: 15), (timer) {
      if (!mounted) return;

      final maxPage =
      (allProducts.length / pageSize).ceil();

      if (current < maxPage - 1) {
        current++;
      } else {
        current = 0;
      }

      controller.animateToPage(
        current,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 200,
      child: Stack(
        children: [

          /// SLIDER
          PageView.builder(
            controller: controller,
            itemCount: (allProducts.length / pageSize).ceil(),
            onPageChanged: (index) {
              setState(() {
                current = index;
              });
            },
              itemBuilder: (context, index) {
                final start = index * pageSize;

                final end = start + pageSize > allProducts.length
                    ? allProducts.length
                    : start + pageSize;

                final pageProducts =
                allProducts.sublist(start, end);

                return _ProductCard(
                  products: pageProducts,
                );
              }
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
                (allProducts.length / pageSize).ceil(),
                    (index) => GestureDetector(
                  onTap: () {
                    controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
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
          ),
        ],
      ),
    );
  }
}
class _ProductCard extends StatelessWidget {
  final List<Product> products;

  const _ProductCard({
    required this.products,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: isTablet(context) ? 180 : 170,
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

                 Text(
                  "Sản phẩm đa chất lượng",
                  style: TextStyle(
                      fontSize: isTablet(context) ? 15 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),

                const SizedBox(height: 4),

                 Text(
                  "Khám phá sản phẩm và lựa chọn cho bạn",
                  style: TextStyle(
                    fontSize: isTablet(context) ? 11 : 11,
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

          SizedBox(height: isTablet(context) ? 6 : 10),

          /// GRID ICON
          SizedBox(
            width: isTablet(context) ? 260 : 150,
            height: isTablet(context) ? 160 : 100,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTablet(context) ? 3 : 3,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(isTablet(context) ? 6 : 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    products[index].image,
                    fit: BoxFit.contain,
                    width: isTablet(context) ? 26 : null,
                    height: isTablet(context) ? 26 : null,
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
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet(context) ? 6 : 3,
          childAspectRatio: isTablet(context) ? 1.2 : 0.9,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
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
                padding: EdgeInsets.symmetric(
                  vertical: isTablet(context) ? 8 : 12,
                  horizontal: isTablet(context) ? 6 : 8,
                ),
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
                    Image.asset(
                      item["icon"]!,
                      height: isTablet(context) ? 48 : 60,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item["text"]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isTablet(context) ? 10 : 13,
                      ),
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
