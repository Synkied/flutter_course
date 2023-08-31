import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryDetail extends StatelessWidget {
  final GroceryItem grocery;

  const GroceryDetail({Key? key, required this.grocery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(grocery.name),
      leading: Container(width: 15, height: 15, color: grocery.category.color),
      trailing: Text(grocery.quantity.toString()),
    );
  }
}
