import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/providers/groceries_provider.dart';
import 'package:shopping_list/screens/new_item.dart';
import 'package:shopping_list/widgets/grocery_detail.dart';

class GroceryListScreen extends ConsumerStatefulWidget {
  const GroceryListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends ConsumerState<GroceryListScreen> {
  @override
  Widget build(BuildContext context) {
    final groceryItems = ref.read(groceryItemsListProvider);

    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Nothing to show.',
            style: Theme.of(context).textTheme.titleLarge!,
          ),
          Text(
            'Try adding some groceries.',
            style: Theme.of(context).textTheme.titleMedium!,
          ),
        ],
      ),
    );

    if (groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => GroceryDetail(
          grocery: groceryItems[index],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }

  void _addItem() async {
    final groceryItemsNotifier = ref.read(groceryItemsListProvider.notifier);
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItemScreen(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      groceryItemsNotifier.addGroceryItem(newItem);
    });
  }
}
