class SalesHistory {
  final String productName;
  final int quantity;
  final double totalPrice;

  SalesHistory({
    required this.productName,
    required this.quantity,
    required this.totalPrice,
  });

  factory SalesHistory.fromJson(Map<String, dynamic> json) {
    return SalesHistory(
      productName: json['product_name'],
      quantity: json['quantity'],
      totalPrice: json['total_price'],
    );
  }
}