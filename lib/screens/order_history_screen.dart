import 'package:e_commerc_mini_application/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order History')),

      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          final orders = orderProvider.order;

          if (orders.isEmpty) {
            return Center(
              child: Text('No orders yet', style: TextStyle(fontSize: 18)),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return Card(
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Order ID: ${order.id}',
                        style: TextStyle(fontWeight: .bold, fontSize: 16),
                      ),

                      SizedBox(height: 6),

                      Text('Date: ${order.orderDate.toLocal()}'),
                      Divider(height: 24),
                      ...order.items.map((item) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Image.network(
                                item.product.image,
                                width: 55,
                                height: 55,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    SizedBox(height: 4),
                                    Text('Quantity: ${item.quantity}'),
                                    Text(
                                      'Price: \$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      Divider(height: 24),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Total: \$${order.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 18, fontWeight: .bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
