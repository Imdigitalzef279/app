class ProductItem {
  final String name;
  final String price;
  final String image;
  final String category;

  ProductItem({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
  });
}

final List<ProductItem> allProducts = [

  /// =========================
  /// ĐỒNG HỒ & ĐO LƯỜNG
  /// =========================

  ProductItem(
    name: 'Enertrek E10',
    price: '28 USD',
    image: 'assets/icons/icons_new/icon_energy_meter.png',
    category: 'Đồng hồ & đo lường',
  ),

  ProductItem(
    name: 'Enertrek E21',
    price: '44 USD',
    image: 'assets/icons/icons_new/icon_energy_meter.png',
    category: 'Đồng hồ & đo lường',
  ),

  ProductItem(
    name: 'Enertrek E31',
    price: '46.4 USD',
    image: 'assets/icons/icons_new/icon_energy_meter.png',
    category: 'Đồng hồ & đo lường',
  ),

  /// =========================
  /// CẦU DAO THÔNG MINH
  /// =========================

  ProductItem(
    name: 'Enertrek M10',
    price: '17 USD',
    image: 'assets/icons/icons_new/icon_smart_breaker.png',
    category: 'Cầu dao thông minh',
  ),

  ProductItem(
    name: 'Enertrek M20',
    price: '20.5 USD',
    image: 'assets/icons/icons_new/icon_smart_breaker.png',
    category: 'Cầu dao thông minh',
  ),

  ProductItem(
    name: 'Enertrek M30',
    price: '30 USD',
    image: 'assets/icons/icons_new/icon_smart_breaker.png',
    category: 'Cầu dao thông minh',
  ),

  ProductItem(
    name: 'Enertrek M40',
    price: '32.5 USD',
    image: 'assets/icons/icons_new/icon_smart_breaker.png',
    category: 'Cầu dao thông minh',
  ),

  /// =========================
  /// BỘ ĐÓNG NGẮT
  /// =========================

  ProductItem(
    name: 'DIO4/2',
    price: '34.4 USD',
    image: 'assets/icons/icons_new/icon_circuit_breaker.png',
    category: 'Bộ đóng ngắt',
  ),

  /// =========================
  /// CỔNG THÔNG MINH
  /// =========================

  ProductItem(
    name: 'Enertrek G30',
    price: '132 USD',
    image: 'assets/icons/icons_new/icon_gateway.png',
    category: 'Cổng thông minh',
  ),

  ProductItem(
    name: 'Enertrek C20',
    price: '24 USD',
    image: 'assets/icons/icons_new/icon_gateway.png',
    category: 'Cổng thông minh',
  ),

  ProductItem(
    name: 'Enertrek C30',
    price: '34 USD',
    image: 'assets/icons/icons_new/icon_gateway.png',
    category: 'Cổng thông minh',
  ),

  /// =========================
  /// THIẾT BỊ MÔI TRƯỜNG
  /// =========================

  ProductItem(
    name: 'Voltage Unit V10',
    price: '73.6 USD',
    image: 'assets/icons/icons_new/icon_environment.png',
    category: 'Thiết bị môi trường',
  ),

  /// =========================
  /// KRA SMART SAFETY
  /// =========================

  ProductItem(
    name: 'KRA Smart Safety',
    price: 'Liên hệ',
    image: 'assets/icons/icons_new/icon_kra_smart_safety.png',
    category: 'KRA Smart Safety',
  ),
];