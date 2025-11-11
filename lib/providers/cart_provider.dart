import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import 'package:intl/intl.dart';
import '../db/database_helper.dart';
import '../models/order.dart';
import '../models/order_item.dart';


class CartItem {
  final MenuItem item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});

  double get totalPrice => item.price * quantity;
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalItems =>
      _items.fold(0, (sum, c) => sum + c.quantity);

  double get subtotal =>
      _items.fold(0, (sum, c) => sum + c.totalPrice);

  double get taxes => subtotal * 0.13;

  double get total => subtotal + taxes;

  Future<int?> placeOrder({required String restaurantName}) async {
    if (_items.isEmpty) return null;

    final now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    final order = Order(
      restaurantName: restaurantName,
      total: total,
      status: 'Placed',
      createdAt: now,
    );

    // Convert cart items to maps expected by DatabaseHelper
    final items = _items.map((cartItem) {
      return OrderItem(
        itemName: cartItem.item.title,
        quantity: cartItem.quantity,
        unitPrice: cartItem.item.price,
      ).toMap();
    }).toList();

    try {
      final id = await DatabaseHelper.instance.insertOrder(order.toMap(), items);

      // clear the cart after successful save
      _items.clear();
      notifyListeners();

      return id;
    } catch (e) {
      debugPrint('Failed to save order: $e');
      return null;
    }
  }

  void addItem(MenuItem item, {int qty = 1}) {
    final index = _items.indexWhere((c) => c.item.title == item.title);

    if (index >= 0) {
      _items[index].quantity += qty;
    } else {
      _items.add(CartItem(item: item, quantity: qty));
    }

    notifyListeners();
  }

  void remove(MenuItem item) {
    final index = _items.indexWhere((c) => c.item.title == item.title);

    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }
}
