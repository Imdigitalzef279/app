import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class EmailRepository {
  final Dio _dio = GetIt.instance<Dio>();

  Future<void> sendEmail({
    required String senderEmailAddress,
    required String targetEmailAddress,
    required String subject,
    required String body,
  }) async {

    print("CALL SEND EMAIL API");

    final response = await _dio.post(
      "/api/setting-management/emailing/send-test-email",
      data: {
        "senderEmailAddress": senderEmailAddress,
        "targetEmailAddress": targetEmailAddress,
        "subject": subject,
        "body": body,
      },
    );

    print("EMAIL RESPONSE: ${response.statusCode}");
    print("EMAIL DATA: ${response.data}");
  }
}