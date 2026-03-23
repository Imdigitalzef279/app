import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  final ScrollController _controller = ScrollController();
  bool isRead = false;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent) {
        setState(() {
          isRead = true; // ✅ scroll tới cuối mới enable
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Điều khoản"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _controller,
              padding: EdgeInsets.all(16.w),
              child: Text(
                """ĐIỀU KHOẢN SỬ DỤNG VÀ CHÍNH SÁCH BẢO MẬT ỨNG DỤNG IoT

Văn bản này quy định Điều khoản sử dụng (Terms of Service) và Chính sách bảo mật (Privacy Policy) dành cho ứng dụng quản lý thiết bị IoT được phát triển trên nền tảng Flutter và phát hành trên Google Play. Khi người dùng cài đặt, đăng ký tài khoản hoặc sử dụng ứng dụng, người dùng được xem là đã đọc, hiểu và đồng ý với các nội dung trong tài liệu này.

PHẦN 1: ĐIỀU KHOẢN SỬ DỤNG (TERMS OF SERVICE)

1. Phạm vi áp dụng
Điều khoản này áp dụng cho tất cả người dùng sử dụng ứng dụng quản lý và giám sát thiết bị IoT.
Ứng dụng cho phép người dùng kết nối, giám sát và điều khiển thiết bị từ xa thông qua internet, bao gồm nhưng không giới hạn ở các chức năng: theo dõi trạng thái thiết bị, nhận dữ liệu đo lường, cảnh báo và điều khiển từ xa.

2. Đăng ký tài khoản
Người dùng phải cung cấp thông tin chính xác khi đăng ký tài khoản. Người dùng chịu trách nhiệm bảo mật thông tin đăng nhập của mình và chịu trách nhiệm đối với mọi hoạt động diễn ra dưới tài khoản.
Người dùng phải thông báo ngay cho nhà cung cấp dịch vụ nếu phát hiện việc sử dụng trái phép tài khoản.

3. Sử dụng dịch vụ
Người dùng cam kết sử dụng ứng dụng đúng mục đích, không thực hiện các hành vi gây ảnh hưởng đến hệ thống, máy chủ hoặc quyền lợi của người dùng khác. Người dùng không được sử dụng ứng dụng cho các hoạt động vi phạm pháp luật.

4. Kết nối thiết bị IoT
Người dùng chịu trách nhiệm về việc cấu hình và vận hành các thiết bị IoT được kết nối với ứng dụng.
Ứng dụng chỉ đóng vai trò là nền tảng giám sát và điều khiển. Nhà cung cấp không chịu trách nhiệm đối với thiệt hại do lỗi phần cứng, lỗi điện, hoặc sai sót trong quá trình lắp đặt thiết bị.

5. Quyền của nhà cung cấp
Nhà cung cấp có quyền nâng cấp, thay đổi hoặc tạm ngừng một phần dịch vụ để bảo trì hệ thống.
Trong trường hợp phát hiện hành vi vi phạm điều khoản, nhà cung cấp có quyền tạm khóa hoặc chấm dứt tài khoản người dùng.

6. Giới hạn trách nhiệm
Nhà cung cấp không chịu trách nhiệm đối với các thiệt hại phát sinh do:
- Mất kết nối internet hoặc lỗi mạng
- Sự cố phần cứng thiết bị IoT
- Sử dụng sai mục đích của người dùng
- Các yếu tố bất khả kháng ngoài khả năng kiểm soát.

7. Thay đổi điều khoản
Điều khoản sử dụng có thể được cập nhật theo thời gian để phù hợp với quy định pháp luật và hoạt động của hệ thống. Người dùng nên kiểm tra nội dung điều khoản định kỳ.

PHẦN 2: CHÍNH SÁCH BẢO MẬT (PRIVACY POLICY)

8. Thông tin thu thập
Ứng dụng có thể thu thập các thông tin sau:
- Thông tin tài khoản (email, số điện thoại, tên người dùng)
- Dữ liệu thiết bị IoT (trạng thái thiết bị, dữ liệu cảm biến, nhật ký hoạt động)
- Thông tin kỹ thuật (địa chỉ IP, loại thiết bị, phiên bản hệ điều hành).

9. Mục đích sử dụng dữ liệu
Dữ liệu được sử dụng để:
- Cung cấp và vận hành dịch vụ IoT
- Hiển thị trạng thái và dữ liệu thiết bị cho người dùng
- Gửi thông báo cảnh báo hoặc thông báo hệ thống
- Cải thiện hiệu năng và độ ổn định của ứng dụng.

10. Lưu trữ và bảo mật
Chúng tôi áp dụng các biện pháp kỹ thuật và tổ chức hợp lý để bảo vệ dữ liệu người dùng.
Dữ liệu có thể được lưu trữ trên máy chủ cloud để phục vụ hoạt động của hệ thống IoT.

11. Chia sẻ thông tin
Chúng tôi không bán hoặc chia sẻ dữ liệu cá nhân của người dùng cho bên thứ ba,
ngoại trừ khi cần thiết để vận hành hệ thống hoặc theo yêu cầu của cơ quan pháp luật.

12. Quyền của người dùng
Người dùng có quyền:
- Yêu cầu truy cập dữ liệu của mình
- Yêu cầu chỉnh sửa hoặc xóa thông tin cá nhân
- Ngừng sử dụng dịch vụ và xóa tài khoản.

13. Quyền riêng tư của trẻ em
Ứng dụng không hướng tới người dùng dưới 13 tuổi. Chúng tôi không cố ý thu thập thông tin cá nhân từ trẻ em dưới độ tuổi này.

14. Liên hệ
Nếu có câu hỏi liên quan đến điều khoản hoặc chính sách bảo mật, người dùng có thể liên hệ với nhà phát triển thông qua email hỗ trợ được công bố trên Google Play.
""",
                style: TextStyle(
                  fontSize: 12.sp,
                  height: 1.5,
                ),
              ),
            ),
          ),

          /// 🔥 BUTTON
          Padding(
            padding: EdgeInsets.all(16.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isRead
                    ? () {
                  Navigator.pop(context, true); // 🔥 QUAN TRỌNG
                }
                    : null,
                child: const Text("Đồng ý"),
              ),
            ),
          )
        ],
      ),
    );
  }
}