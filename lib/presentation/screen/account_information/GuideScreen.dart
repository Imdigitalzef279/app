import 'package:flutter/material.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  int selectedIndex = 0;
  late PageController _pageController;

  final List<String> categories = [
    "Webcam",
    "Đèn",
    "Máy lọc",
    "Robot"
  ];

  final List<List<Map<String, String>>> data = [
    [
      {"img": "assets/cam1.png", "name": "Camera thường"},
      {"img": "assets/cam2.png", "name": "Camera Basic"},
      {"img": "assets/cam3.png", "name": "Camera 360"},
    ],
    [
      {"img": "assets/light.png", "name": "Đèn LED"},
      {"img": "assets/light.png", "name": "Đèn ngủ"},
    ],
    [
      {"img": "assets/air.png", "name": "Xiaomi Air"},
    ],
    [
      {"img": "assets/robot.png", "name": "Robot hút bụi"},
    ],
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        title: const Text("Trợ lý thoại"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Trợ lý thoại",
                style: TextStyle(fontSize: 18),
              ),
            ),

            /// ASSISTANT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _AssistantItem("assets/alexa.png", "Amazon Alexa"),
                  _AssistantItem("assets/google.png", "Google Assistant"),
                  _AssistantItem("assets/clova.png", "NAVER Clova"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// TITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Các thiết bị hỗ trợ điều khiển bằng giọng nói",
              ),
            ),

            const SizedBox(height: 12),

            /// CATEGORY
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(categories.length, (index) {
                  final isActive = selectedIndex == index;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });

                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: isActive
                              ? Border.all(color: Colors.green, width: 1.5)
                              : null,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.devices,
                              color: isActive
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              categories[index],
                              style: TextStyle(
                                fontSize: 12,
                                color: isActive
                                    ? Colors.green
                                    : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 16),

            /// 🔥 PAGE VIEW (FIX CHUẨN)
            SizedBox(
              height: 180,
              child: PageView.builder(
                controller: _pageController,
                physics: const PageScrollPhysics(), // QUAN TRỌNG
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                itemCount: data.length,
                itemBuilder: (context, pageIndex) {
                  final list = data[pageIndex];

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(), //  FIX XUNG ĐỘT
                    primary: false,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];

                      return Container(
                        width: 130,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Image.asset(item["img"]!, height: 80),
                            const SizedBox(height: 8),
                            Text(
                              item["name"]!,
                              textAlign: TextAlign.center,
                              style:
                              const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// COMPONENT
class _AssistantItem extends StatelessWidget {
  final String icon;
  final String title;

  const _AssistantItem(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset(icon),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 12))
      ],
    );
  }
}