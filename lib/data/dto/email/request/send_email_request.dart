class SendEmailRequest {
  final String targetAddress;
  final String subject;
  final String body;
  final bool isBodyHtml;

  SendEmailRequest({
    required this.targetAddress,
    required this.subject,
    required this.body,
    this.isBodyHtml = true,
  });

  Map<String, dynamic> toJson() {
    return {
      "targetAddress": targetAddress,
      "subject": subject,
      "body": body,
      "isBodyHtml": isBodyHtml,
    };
  }
}