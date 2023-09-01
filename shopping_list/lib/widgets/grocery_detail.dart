import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/providers/groceries_provider.dart';

class GroceryDetail extends ConsumerWidget {
  final GroceryItem grocery;

  const GroceryDetail({Key? key, required this.grocery}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceryItems = ref.read(groceryItemsListProvider.notifier);

    return Dismissible(
      key: ValueKey(grocery),
      onDismissed: (direction) {
        groceryItems.removeGroceryItem(grocery);
      },
      child: ListTile(
        title: Text(grocery.name),
        leading:
            Container(width: 15, height: 15, color: grocery.category.color),
        trailing: Text(grocery.quantity.toString()),
      ),
    );
  }
}
