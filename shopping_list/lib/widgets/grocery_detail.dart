import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/utils.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/providers/groceries_provider.dart';

class GroceryDetail extends ConsumerWidget {
  final GroceryItem grocery;

  const GroceryDetail({Key? key, required this.grocery}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(grocery),
      onDismissed: (direction) {
        _removeGroceryItem(grocery, ref);
      },
      child: ListTile(
        title: Text(grocery.name),
        leading:
            Container(width: 15, height: 15, color: grocery.category.color),
        trailing: Text(grocery.quantity.toString()),
      ),
    );
  }

  void _removeGroceryItem(GroceryItem groceryItem, WidgetRef ref) async {
    final groceryItemsNotifier = ref.read(groceryItemsListProvider.notifier);
    final groceryItems = ref.read(groceryItemsListProvider);
    final firebaseDeleteUrl =
        Uri.https(firebaseUrl, "shopping-list/${groceryItem.id}.json");
    final groceryItemIndex = groceryItems.indexOf(groceryItem);

    groceryItemsNotifier.removeGroceryItem(groceryItem);

    final response = await http.delete(firebaseDeleteUrl);
    if (response.statusCode >= 400) {
      groceryItemsNotifier.insertGroceryItem(groceryItem, groceryItemIndex);
    }
  }
}
