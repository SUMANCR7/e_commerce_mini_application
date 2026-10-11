import 'package:e_commerc_mini_application/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';
import '../models/order_model.dart';
import '../providers/order_provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final cartItems = cartProvider.cartItems;

          if (cartItems.isEmpty) {
            return Center(child: Text('Your cart is empty'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    final product = item.product;

                    final subtotal = product.price * item.quantity;

                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.network(
                          product.image,
                          width: 55,
                          height: 55,
                          fit: BoxFit.contain,
                        ),
                        title: Text(product.title),
                        subtitle: Text(
                          '\$${product.price.toStringAsFixed(2)}'
                          'x ${item.quantity}'
                          '= \$${subtotal.toStringAsFixed(2)}',
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Final Total: '
                      '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 22, fontWeight: .bold),
                    ),
                    SizedBox(height: 16),

                    ElevatedButton(

                      onPressed: ()  async {
                        final cartProvider = context.read<CartProvider>();

                        if (cartProvider.cartItems.isEmpty) return;

                        final order = OrderModel(
                          id: DateTime.now()
                              .millisecondsSinceEpoch
                              .toString(),

                          items: cartProvider.cartItems.map((item) {
                            return CartItem(
                              product: item.product,
                              quantity: item.quantity,
                            );
                          }).toList(),

                          totalPrice: cartProvider.totalPrice,
                          orderDate: DateTime.now(),
                        );

                     await   context.read<OrderProvider>().addOrder(order);

                     if(!context.mounted) return;

                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text('Order Confirmed!'),
                              content: const Text(
                                'Your order has been placed successfully.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();

                                    context.read<CartProvider>().clearCart();

                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Place Order'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
