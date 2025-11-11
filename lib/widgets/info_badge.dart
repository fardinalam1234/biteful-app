import 'package:flutter/material.dart';
import '../theme.dart';

class InfoBadge extends StatelessWidget {
  final String text;

  const InfoBadge(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.90),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(18),
          bottomRight: Radius.circular(18),
          bottomLeft: Radius.circular(6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.12),
            blurRadius: 4.5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.2,
          fontWeight: FontWeight.w500,
          color: kTextDark,
        ),
      ),
    ); 
  }
}
