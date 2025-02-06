import 'package:cookants/features/admin/view/admin_order_page/admin_page.dart';
import 'package:cookants/features/user/view/landing_page/landing_page.dart';
import 'package:cookants/features/user/view/order_page/order_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/view/login_page/login_page.dart';
import '../features/user/view/product_page/product_page.dart';

class AppRouteConfig {
  GoRouter goRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          name: 'home',
          path: '/',
          pageBuilder: (context, state) {
            return const MaterialPage(child: LandingPage());
          }),
      GoRoute(
          name: 'login',
          path: '/login',
          pageBuilder: (context, state) {
            FirebaseAuth firebaseAuth = FirebaseAuth.instance;
            final user = firebaseAuth.currentUser;
            if(user!=null){
              return const MaterialPage(child: AdminPage());
            }else{
              return const MaterialPage(child: LoginPage());
            }
          }),
      GoRoute(
          path: '/order/:category',
          builder: (context, state) {
            final String category = state.pathParameters['category']!;  // Access the parameter
            return OrderPage(category: category);
          },
          ),
      GoRoute(
        path: '/product/:id',  // :id is a dynamic segment
        builder: (context, state) {
          final String productId = state.pathParameters['id']!;  // Access the parameter
          return ProductPage(productId: productId);
        },
      )
    ],
  );
}
