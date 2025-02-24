import 'package:flutter/material.dart';
import 'package:chatbotstudy/features/shop/models/order_model.dart';
import 'package:chatbotstudy/features/shop/screens/order/widgets/order_box.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';

class OrdersListview extends StatelessWidget {
  const OrdersListview({super.key, required this.orders});

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: orders.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
      itemBuilder: (_, index) => OrderBox(order: orders[index]),
    );
  }
}
