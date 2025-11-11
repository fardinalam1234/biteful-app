import 'package:flutter/material.dart';
import '../theme.dart';

class TrackPage extends StatelessWidget {
  const TrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Tracking")),
      body: Column(
        children: [
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.directions_bike, size: 30, color: kPrimary),
              const SizedBox(width: 10),
              const Text(
                "Star Shopper",
                style: TextStyle(
                  fontSize: 18,
                  color: kStar,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          const Expanded(child: _MapPlaceholder()),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(kCardRadius),
                boxShadow: kCardShadow,
              ),
              child: const Text(
                "Your delivery is on the way!\nETA: 12 minutes",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  const _MapPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(kCardRadius),
      ),
      child: const Center(
        child: Icon(
          Icons.map_outlined,
          size: 100,
          color: Colors.white70,
        ),
      ),
    );
  }
}
