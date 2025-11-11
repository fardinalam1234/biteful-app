class Order {
  int? id;
  final String restaurantName;
  final double total;
  final String status;
  final String createdAt; // e.g. ISO string like "2025-11-09T22:00:00Z"

  Order({
    this.id,
    required this.restaurantName,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'restaurantName': restaurantName,
      'total': total,
      'status': status,
      'createdAt': createdAt,
    };
    if (id != null) map['id'] = id!;
    return map;
  }

  static Order fromMap(Map<String, dynamic> map) => Order(
    id: map['id'] as int?,
    restaurantName: map['restaurantName'] as String,
    total: (map['total'] as num).toDouble(),
    status: map['status'] as String,
    createdAt: map['createdAt'] as String,
  );
}
