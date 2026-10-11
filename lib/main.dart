import 'package:dio/dio.dart';
import 'package:e_commerc_mini_application/providers/cart_provider.dart';
import 'package:e_commerc_mini_application/providers/order_provider.dart';
import 'package:e_commerc_mini_application/providers/product_providers.dart';
import 'package:e_commerc_mini_application/repositories/product_repository.dart';
import 'package:e_commerc_mini_application/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          //===[ Product Provider ]
          ChangeNotifierProvider(
              create: (_)=>ProductProviders(
                  repository: ProductRepositoryImpl(
                      dio: Dio(),
                  )
              )),
          //=== [ Cart Provider ]
          ChangeNotifierProvider(
            create: (_) => CartProvider(),
          ),

          //=== [ Order Provider ]
          ChangeNotifierProvider(
              create: (_) => OrderProvider()..loadOrders()),
        ],
        child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
    );
  }
}


