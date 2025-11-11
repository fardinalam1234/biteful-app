import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/orders_page.dart';
import 'pages/splash_page.dart';
import 'pages/home_page.dart';
import 'pages/restaurant_page.dart';
import 'pages/cart_page.dart';
import 'pages/track_page.dart';

GoRouter buildRouter() => GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SplashPage()),
        ),
        GoRoute(path: '/home', builder: (_, __) => const HomePage()),
        GoRoute(
          path: '/restaurant/:id',
          builder: (_, s) => RestaurantPage(id: s.pathParameters['id']!),
        ),
        GoRoute(path: '/cart', builder: (_, __) => const CartPage()),
        GoRoute(path: '/track', builder: (_, __) => const TrackPage()),
        GoRoute(path: '/orders', builder: (_, __) => const OrdersPage(),),
      ],
    );
