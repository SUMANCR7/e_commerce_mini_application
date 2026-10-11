

import 'dart:convert';

import 'package:e_commerc_mini_application/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderProvider extends ChangeNotifier{
  static const String _storageKey = 'saved_orders';

  final List<OrderModel> _order = [];

  List<OrderModel> get order => List.unmodifiable(_order);

  //=== loadOrder method
  Future<void> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();

    final savedData = prefs.getString(_storageKey);
    if(savedData == null) return;

    final List<dynamic> decodedData = jsonDecode(savedData);

    _order
    ..clear()
    ..addAll(
      decodedData.map(
          (item) => OrderModel.fromMap(
            Map<String, dynamic>.from(item as Map),
          )
      )
    );
    notifyListeners();
  }

Future <void> addOrder(OrderModel order) async {
  _order.insert(0, order);
 await  _saveOrders();
  notifyListeners();
}

Future<void> _saveOrders() async {
    final prefs = await SharedPreferences.getInstance();

    final encodedData = jsonEncode(
      _order.map((order) => order.toMap()).toList(),
    );
    await prefs.setString(_storageKey, encodedData);
}
}