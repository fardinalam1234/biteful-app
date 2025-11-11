import 'package:flutter/material.dart';
import '../theme.dart';

class RestaurantCard extends StatelessWidget {
  final String title;
  final String image;
  final String eta;
  final String fee;
  final String rating;
  final String count;
  final String distance;
  final VoidCallback onTap;

  const RestaurantCard({
    super.key,
    required this.title,
    required this.image,
    required this.eta,
    required this.fee,
    required this.rating,
    required this.count,
    required this.distance,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kCardRadius),
          color: Colors.white,
          boxShadow: kCardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(kCardRadius),
              ),
              child: Image.asset(image, height: 180, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 18, color: kStar),
                      const SizedBox(width: 3),
                      Text("$rating ($count)"),
                    ],
                  ),
                  Text("$distance  •  $eta  •  $fee"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
