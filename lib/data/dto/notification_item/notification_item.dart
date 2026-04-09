class NotificationItem {
  final String title;
  final String message;
  final bool isAlert; // đỏ
  final DateTime time;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    this.isAlert = false,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NotificationItem &&
              runtimeType == other.runtimeType &&
              message == other.message;

  @override
  int get hashCode => message.hashCode;
}
