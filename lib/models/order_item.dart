class OrderItem {
  final String orderId, description, customerName;
  final double totalAmount;
  bool isCompact;
  OrderItem({
    required this.orderId,
    required this.description,
    required this.customerName,
    required this.totalAmount,
    this.isCompact = true,
  });
}
