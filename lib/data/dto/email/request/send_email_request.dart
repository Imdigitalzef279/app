class SendEmailRequest {
  final String senderEmailAddress;
  final String targetEmailAddress;
  final String subject;
  final String body;

  SendEmailRequest({
    required this.senderEmailAddress,
    required this.targetEmailAddress,
    required this.subject,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return {
      "senderEmailAddress": senderEmailAddress,
      "targetEmailAddress": targetEmailAddress,
      "subject": subject,
      "body": body,
    };
  }
}