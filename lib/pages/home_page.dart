import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/category_chip.dart';
import '../widgets/restaurant_card.dart';
import '../data/sample_data.dart';
import '../providers/cart_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F7),

      appBar: AppBar(
        title: const Text('Biteful', style: TextStyle(fontFamily: 'Mogra')),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/cart.svg',
                  height: 22,
                  color: Colors.white,                // ✅ FIX
                ),
                onPressed: () => context.push('/cart'),
              ),

              Positioned(
                right: 6,
                top: 6,
                child: Consumer<CartProvider>(
                  builder: (_, cart, __) {
                    if (cart.totalItems == 0) return const SizedBox.shrink();
                    return Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        cart.totalItems.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              CategoryChip(label: 'Pizza', iconAsset: 'assets/icons/pizza.svg'),
              CategoryChip(label: 'Chinese', iconAsset: 'assets/icons/chinese.svg'),
              CategoryChip(label: 'Comfort', iconAsset: 'assets/icons/comfort.svg'),
              CategoryChip(label: 'Japanese', iconAsset: 'assets/icons/japanese.svg'),
              CategoryChip(label: 'Dessert', iconAsset: 'assets/icons/dessert.svg'),
            ],
          ),

          const SizedBox(height: 20),
          Text('Places near you',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),

          ...restaurants.map(
            (r) => RestaurantCard(
              title: r.name,
              image: r.heroImage,
              eta: r.eta,
              fee: r.fee,
              rating: r.rating,
              count: r.ratingCount,
              distance: r.distance,
              onTap: () => context.push('/restaurant/${r.id}'),
            ),
          ),
        ],
      ),
    );
  }
}
