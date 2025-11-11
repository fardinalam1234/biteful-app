import 'package:flutter/material.dart';
import '../theme.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 1.2,
        width: double.infinity,
        color: Colors.black12,
      ),
    );
  }
}
