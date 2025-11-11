import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'router.dart';
import 'theme.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(const BitefulApp());
}

class BitefulApp extends StatelessWidget {
  const BitefulApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = buildBitefulTheme(
      amiko: GoogleFonts.amiko(),
      mogra: GoogleFonts.mogra(),
      inter: GoogleFonts.inter(),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp.router(
        title: 'Biteful',
        debugShowCheckedModeBanner: false,
        theme: theme,
        routerConfig: buildRouter(),
      ),
    );
  }
}
