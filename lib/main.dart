import 'package:flutter/material.dart';

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

// Biteful welcome splash creen

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
                  onPressed: () {},
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
                childAspectRatio: 0.8,
              ),
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return _buildRestaurantCard(restaurants[index]);
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

  Widget _buildRestaurantCard(Restaurant restaurant) {
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
              height: 120,
              width: double.infinity,
              color: Colors.grey[200],
              child: Image.network(
                restaurant.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.restaurant, size: 50, color: Colors.grey);
                },
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      restaurant.rating.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.access_time, color: Colors.grey, size: 16),
                    SizedBox(width: 4),
                    Text(
                      restaurant.deliveryTime,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  restaurant.price,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Orders

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 80,
            color: Colors.blue[400],
          ),
          SizedBox(height: 20),
          Text(
            'Orders Screen',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue[600],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Order history will be implemented here',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// User profile

class ProfileScreen extends StatelessWidget {
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
                            'John Doe',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'john.doe@email.com',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '+1 (555) 123-4567',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {},
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