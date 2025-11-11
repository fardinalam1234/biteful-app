import 'package:flutter/material.dart';
import 'db/database_helper.dart';
import 'models/order.dart';
import 'models/order_item.dart';
import 'package:intl/intl.dart';

// 1. Add MenuItem Model
class MenuItem {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

void main() {
  runApp(BitefulApp());
}

class BitefulApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biteful',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: SplashScreen(),
    );
  }
}

// Biteful welcome splash screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo/Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.fastfood,
                size: 60,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 30),
            // App Name with Bubbly Font Style
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'BITEFUL',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontFamily: 'ComicNeue',
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black26,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Food Delivery',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.9),
                letterSpacing: 1,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text(
                'Tap to Enter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Home screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Screens for bottom navigation
  final List<Widget> _screens = [
    HomeContent(), // Home screen with restaurants
    OrdersScreen(), // Orders screen
    ProfileScreen(), // Profile screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
        backgroundColor: Colors.blue,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            'Biteful',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 24,
              fontFamily: 'ComicNeue',
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              setState(() {
                _currentIndex = 2; // Switch to profile
              });
            },
          ),
        ],
      )
          : AppBar(
        backgroundColor: Colors.blue,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            _currentIndex == 1 ? 'My Orders' : 'My Profile',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              fontFamily: 'ComicNeue',
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Home screen
class HomeContent extends StatelessWidget {
  final List<Restaurant> restaurants = [
    Restaurant(
      name: 'Burger King',
      cuisine: 'American • Burgers',
      rating: 4.5,
      deliveryTime: '20-30 min',
      imageUrl: 'https://picsum.photos/300/200?random=1',
      price: '\$\$',
    ),
    Restaurant(
      name: 'Sushi 24/7',
      cuisine: 'Japanese • Sushi',
      rating: 4.8,
      deliveryTime: '30-40 min',
      imageUrl: 'https://picsum.photos/300/200?random=2',
      price: '\$\$\$',
    ),
    Restaurant(
      name: 'Pizza Pizza',
      cuisine: 'Italian • Pizza',
      rating: 4.3,
      deliveryTime: '25-35 min',
      imageUrl: 'https://picsum.photos/300/200?random=3',
      price: '\$\$',
    ),
    Restaurant(
      name: 'Taco Bell',
      cuisine: 'Mexican • Tacos',
      rating: 4.6,
      deliveryTime: '15-25 min',
      imageUrl: 'https://picsum.photos/300/200?random=4',
      price: '\$',
    ),
    Restaurant(
      name: 'Hakka Legend',
      cuisine: 'Chinese • Asian',
      rating: 4.4,
      deliveryTime: '35-45 min',
      imageUrl: 'https://picsum.photos/300/200?random=5',
      price: '\$\$',
    ),
    Restaurant(
      name: 'Veggie Planet',
      cuisine: 'Healthy • Salads',
      rating: 4.7,
      deliveryTime: '20-30 min',
      imageUrl: 'https://picsum.photos/300/200?random=6',
      price: '\$\$\$',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Icon(Icons.search, color: Colors.grey[600]),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search restaurants or food...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Frequently Ordered Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Frequently Ordered',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 60,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: DatabaseHelper.instance.getFrequentlyOrderedItems(limit: 6),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator(strokeWidth: 2));
                      }
                      final items = snapshot.data!;
                      if (items.isEmpty) {
                        return Text('No suggestions yet.', style: TextStyle(color: Colors.grey));
                      }
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        separatorBuilder: (_, __) => SizedBox(width: 8),
                        itemBuilder: (context, i) {
                          final it = items[i];
                          return Chip(
                            label: Text('${it['itemName']} (${it['totalQuantity']})'),
                            backgroundColor: Colors.blue[50],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Categories Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategory('Burger', Icons.fastfood, Colors.orange),
                _buildCategory('Pizza', Icons.local_pizza, Colors.blue),
                _buildCategory('Sushi', Icons.set_meal, Colors.green),
                _buildCategory('Tacos', Icons.restaurant, Colors.yellow),
                _buildCategory('Salad', Icons.eco, Colors.lightGreen),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Featured Restaurants
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured Restaurants',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Restaurants Grid
          Padding(
            padding: EdgeInsets.all(16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.68,
              ),
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return _buildRestaurantCard(context, restaurants[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(String name, IconData icon, Color color) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.blue[800],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(BuildContext context, Restaurant restaurant) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 80,
              width: double.infinity,
              color: Colors.grey[200],
              child: Image.network(
                restaurant.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.restaurant, size: 36, color: Colors.grey);
                },
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.blue[800],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  restaurant.cuisine,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    SizedBox(width: 4),
                    Text(restaurant.rating.toString(), style: TextStyle(fontSize: 11)),
                    SizedBox(width: 8),
                    Icon(Icons.access_time, color: Colors.grey, size: 14),
                    SizedBox(width: 4),
                    Text(restaurant.deliveryTime, style: TextStyle(fontSize: 11)),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      restaurant.price,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      height: 34,
                      child: ElevatedButton(
                        // Navigates to the new detail screen
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantDetailScreen(restaurant: restaurant),
                            ),
                          );
                        },
                        child: Text('Order', style: TextStyle(fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 4),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 3. New Restaurant Detail Screen
class RestaurantDetailScreen extends StatefulWidget {
  final Restaurant restaurant;

  RestaurantDetailScreen({required this.restaurant});

  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  // A simple dummy menu for demonstration
  late List<MenuItem> _menu;
  Map<MenuItem, int> _cart = {};

  @override
  void initState() {
    super.initState();
    _loadMenu();
  }

  void _loadMenu() {
    // Generate a simple dummy menu based on the restaurant name
    switch (widget.restaurant.name) {
      case 'Burger King':
        _menu = [
          MenuItem(name: 'Whopper', description: 'Flame-grilled beef patty', price: 6.99, imageUrl: 'https://picsum.photos/100/100?random=10'),
          MenuItem(name: 'Fries', description: 'Crispy golden fries', price: 2.49, imageUrl: 'https://picsum.photos/100/100?random=11'),
          MenuItem(name: 'Onion Rings', description: 'Crispy onion rings', price: 3.99, imageUrl: 'https://picsum.photos/100/100?random=12'),
        ];
        break;
      case 'Sushi 24/7':
        _menu = [
          MenuItem(name: 'Salmon Roll', description: 'Fresh salmon with rice', price: 8.50, imageUrl: 'https://picsum.photos/100/100?random=20'),
          MenuItem(name: 'Tuna Nigiri', description: 'Tuna on sushi rice', price: 9.99, imageUrl: 'https://picsum.photos/100/100?random=21'),
          MenuItem(name: 'Miso Soup', description: 'Traditional Japanese soup', price: 3.00, imageUrl: 'https://picsum.photos/100/100?random=22'),
        ];
        break;
      default:
        _menu = [
          MenuItem(name: 'Default Dish 1', description: 'A tasty placeholder meal', price: 10.00, imageUrl: 'https://picsum.photos/100/100?random=30'),
          MenuItem(name: 'Default Dish 2', description: 'Another popular placeholder', price: 12.50, imageUrl: 'https://picsum.photos/100/100?random=31'),
        ];
    }
  }

  void _updateCart(MenuItem item, int quantity) {
    setState(() {
      if (quantity > 0) {
        _cart[item] = quantity;
      } else {
        _cart.remove(item);
      }
    });
  }

  double get _totalPrice {
    double total = 0.0;
    _cart.forEach((item, quantity) {
      total += item.price * quantity;
    });
    return total;
  }

  Future<void> _placeOrder() async {
    if (_cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Your cart is empty!')),
      );
      return;
    }

    final now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    final total = _totalPrice;

    // Create Order object
    final order = Order(
      restaurantName: widget.restaurant.name,
      total: total,
      status: 'Placed',
      createdAt: now,
    );

    // Create OrderItem list
    final items = _cart.entries.map((entry) {
      return OrderItem(
        itemName: entry.key.name,
        quantity: entry.value,
        unitPrice: entry.key.price,
      ).toMap();
    }).toList();

    // Insert into DB
    final id = await DatabaseHelper.instance.insertOrder(order.toMap(), items);

    // Show confirmation and navigate back
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order #$id placed for ${widget.restaurant.name}. Total: \$${total.toStringAsFixed(2)}')),
    );
    Navigator.pop(context); // Go back to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    final hasItems = _cart.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          widget.restaurant.name,
          style: TextStyle(color: Colors.white, fontFamily: 'ComicNeue'),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Header Image/Details
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.restaurant.imageUrl),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                ),
              ),
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(16),
              child: Text(
                widget.restaurant.cuisine,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Menu Items',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ),

            // Menu List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _menu.length,
              itemBuilder: (context, index) {
                final item = _menu[index];
                return _buildMenuItem(item);
              },
            ),
            SizedBox(height: hasItems ? 100 : 20),
          ],
        ),
      ),
      // Floating Cart/Order Button
      bottomSheet: hasItems
          ? Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '\$${_totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: _placeOrder,
              icon: Icon(Icons.shopping_cart),
              label: Text('Place Order (${_cart.length} items)'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      )
          : null,
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    final quantity = _cart[item] ?? 0;
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          item.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(item.description, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove_circle_outline, color: quantity > 0 ? Colors.blue : Colors.grey),
            onPressed: quantity > 0 ? () => _updateCart(item, quantity - 1) : null,
          ),
          Text(
            quantity.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline, color: Colors.blue),
            onPressed: () => _updateCart(item, quantity + 1),
          ),
        ],
      ),
      onTap: () => _updateCart(item, quantity + 1),
    );
  }
}

// Orders
class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> _orders = [];

  // 4. Update lifecycle to refresh orders on screen activation
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This ensures orders are loaded/refreshed when navigating back to this screen
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final rows = await DatabaseHelper.instance.getOrders();
    // Only update state if the widget is still mounted
    if (mounted) {
      setState(() {
        _orders = rows.map((r) => Order.fromMap(r)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                await DatabaseHelper.instance.clearAllOrders();
                await _loadOrders();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('All orders cleared')),
                );
              },
              icon: Icon(Icons.delete_forever),
              label: Text('Clear All Orders'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),

            SizedBox(height: 16),
            Expanded(
              child: _orders.isEmpty
                  ? Center(child: Text('No orders yet.'))
                  : ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  final o = _orders[index];
                  final raw = o.createdAt;
                  DateTime? parsed;
                  try {
                    // Try parsing as UTC and convert to local time
                    parsed = DateTime.tryParse(raw)?.toLocal();
                  } catch (_) {
                    parsed = null;
                  }
                  final niceTime = parsed != null
                      ? DateFormat('MMM d, yyyy • h:mm a').format(parsed)
                      : raw;

                  return Card(
                    child: ListTile(
                      title: Text(o.restaurantName),
                      subtitle: Text('${o.status} • $niceTime'),
                      trailing: Text('\$${o.total.toStringAsFixed(2)}'),

                      onTap: () async {
                        final items = await DatabaseHelper.instance
                            .getOrderItems(o.id!);
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Order Items'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: items
                                  .map((it) => ListTile(
                                title: Text(it['itemName']),
                                subtitle: Text(
                                    'x${it['quantity']} - \$${it['unitPrice']}'),
                              ))
                                  .toList(),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context),
                                child: Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// User profile

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Dummy state variables for the profile details
  String _name = 'John Doe';
  String _email = 'john.doe@email.com';
  String _phone = '+1 (555) 123-4567';

  void _showEditProfileDialog() {
    // Controllers initialized with current state values
    TextEditingController nameController = TextEditingController(text: _name);
    TextEditingController emailController = TextEditingController(text: _email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 15),
                // Phone number is often read-only or requires more complex verification
                Text('Phone: $_phone (Read-only for demo)', style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                // Update state variables
                setState(() {
                  _name = nameController.text;
                  _email = emailController.text;
                });

                // Display a success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Profile details updated!'),
                    duration: Duration(seconds: 2),
                  ),
                );

                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blue[100],
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _name, // Use state variable
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            _email, // Use state variable
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            _phone, // Use state variable
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: _showEditProfileDialog, // Call the new dialog function
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Account Section
            _buildSectionTitle('Account'),
            _buildProfileOption(Icons.person_outline, 'Personal Information'),
            _buildProfileOption(Icons.location_on_outlined, 'Addresses'),
            _buildProfileOption(Icons.payment, 'Payment Methods'),
            _buildProfileOption(Icons.notifications_outlined, 'Notifications'),

            SizedBox(height: 20),

            // Order History Section
            _buildSectionTitle('Order History'),
            _buildProfileOption(Icons.history, 'Past Orders'),
            _buildProfileOption(Icons.favorite_border, 'Favorite Restaurants'),
            _buildProfileOption(Icons.star_border, 'Reviews & Ratings'),

            SizedBox(height: 20),

            // Support Section
            _buildSectionTitle('Support'),
            _buildProfileOption(Icons.help_outline, 'Help Center'),
            _buildProfileOption(Icons.chat_bubble_outline, 'Contact Support'),
            _buildProfileOption(Icons.security, 'Privacy Policy'),
            _buildProfileOption(Icons.description, 'Terms of Service'),

            SizedBox(height: 20),

            // App Settings Section
            _buildSectionTitle('App Settings'),
            _buildProfileOption(Icons.language, 'Language'),
            _buildProfileOption(Icons.dark_mode_outlined, 'Dark Mode'),
            _buildProfileOption(Icons.notifications_active, 'Push Notifications'),

            SizedBox(height: 30),

            // Logout Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Logout logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      elevation: 1,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          // Handle option tap
          print('$title tapped');
        },
      ),
    );
  }
}

// Resturants

class Restaurant {
  final String name;
  final String cuisine;
  final double rating;
  final String deliveryTime;
  final String imageUrl;
  final String price;

  Restaurant({
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.deliveryTime,
    required this.imageUrl,
    required this.price,
  });
}