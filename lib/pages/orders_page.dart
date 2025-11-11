import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/database_helper.dart';
import '../models/order.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order> _orders = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final rows = await DatabaseHelper.instance.getOrders();
    if (!mounted) return;
    setState(() {
      _orders = rows.map((r) => Order.fromMap(r)).toList();
      _loading = false;
    });
  }

  String _formatDate(String raw) {
    try {
      final dt = DateTime.parse(raw).toLocal();
      return DateFormat('MMM d, yyyy • h:mm a').format(dt);
    } catch (_) {
      return raw;
    }
  }

  Future<void> _showOrderItems(int orderId) async {
    final items = await DatabaseHelper.instance.getOrderItems(orderId);
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Order Items'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: items.map((it) {
            return ListTile(
              title: Text(it['itemName'] ?? ''),
              subtitle: Text('x${it['quantity']} • \$${(it['unitPrice'] ?? 0).toString()}'),
            );
          }).toList(),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Orders')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: _orders.isEmpty
          ? const Center(child: Text('No orders yet.'))
          : RefreshIndicator(
        onRefresh: _loadOrders,
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: _orders.length,
          itemBuilder: (context, i) {
            final o = _orders[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(o.restaurantName),
                subtitle: Text('${o.status} • ${_formatDate(o.createdAt)}'),
                trailing: Text('\$${o.total.toStringAsFixed(2)}'),
                onTap: () => _showOrderItems(o.id!),
              ),
            );
          },
        ),
      ),
    );
  }
}
