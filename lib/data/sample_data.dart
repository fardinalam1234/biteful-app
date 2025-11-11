import 'package:flutter/material.dart';

class Restaurant {
  final String id, name, heroImage, eta, fee, rating, ratingCount;
  final List<MenuItem> appetizers;
  final String distance;

  const Restaurant({
    required this.id,
    required this.name,
    required this.heroImage,
    required this.eta,
    required this.fee,
    required this.rating,
    required this.ratingCount,
    required this.appetizers,
    required this.distance,
  });
}

class MenuItem {
  final String title, desc;
  final String? thumb;
  final double price;

  const MenuItem(this.title, this.desc, this.price, {this.thumb});
}

final restaurants = <Restaurant>[
  Restaurant(
    id: 'sushi',
    name: 'Yun Maye Sushi',
    heroImage: 'assets/images/sushi-restaurant.jpg',
    eta: '10–20 min',
    fee: '\$0 delivery fee',
    rating: '4.8',
    ratingCount: '5k+',
    distance: '0.2 mi',
    appetizers: [
      MenuItem(
        'Menu Item 1',
        'XXX XXXX XX XXX\nXXXX XXXX XXXX\nXXXX XXX',
        8.99,
      ),
      MenuItem(
        'Menu Item 2',
        'XXX XXXX XX XXX\nXXXX XXXX XXXX\nXXXX XXX',
        6.49,
      ),
    ],
  ),

  Restaurant(
    id: 'burger',
    name: 'The Burger Alley',
    heroImage: 'assets/images/burger-restaurant.jpg',
    eta: '10–20 min',
    fee: '\$0 delivery fee',
    rating: '4.6',
    ratingCount: '8k+',
    distance: '0.5 mi',
    appetizers: [
      MenuItem('Menu Item 1', 'Sample description…', 7.50),
      MenuItem('Menu Item 2', 'Sample description…', 4.99),
    ],
  ),
];
