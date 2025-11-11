import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final String iconAsset;

  const CategoryChip({
    super.key,
    required this.label,
    required this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // ✅ identical for ALL chips
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            offset: const Offset(0, 2),
            blurRadius: 4,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconAsset,
            height: 16,
            width: 16,
            colorFilter:
                const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
