class NotificationItem {

  final String title;
  final String message;
  final bool isAlert;
  final DateTime time;

  /// số lần lặp
  final int count;

  /// danh sách chi tiết khi bấm vào
  final List<NotificationItem>? children;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    this.isAlert = false,
    this.count = 1,
    this.children,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NotificationItem &&
              runtimeType == other.runtimeType &&
              title == other.title &&
              message == other.message;

  @override
  int get hashCode =>
      title.hashCode ^ message.hashCode;
}