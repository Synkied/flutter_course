import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/data/utils.dart';
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
  bool _isLoading = true;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final groceryItems = ref.watch(groceryItemsListProvider);
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

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => GroceryDetail(
          grocery: groceryItems[index],
        ),
      );
    }

    if (_error != null) {
      content = Center(child: Text(_error!));
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

  @override
  void initState() {
    super.initState();
    _loadGroceryItems();
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
    groceryItemsNotifier.addGroceryItem(newItem);
  }

  void _loadGroceryItems() async {
    final groceryItemsNotifier = ref.read(groceryItemsListProvider.notifier);

    try {
      final response = await http.get(firebaseShoppingListUrl);

      if (response.statusCode >= 400) {
        setState(() {
          _error = "Failed to fetch data. Please try again later.";
        });
        return;
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> groceryItemsJson = json.decode(response.body);

      for (final item in groceryItemsJson.entries) {
        final category = categories.entries
            .firstWhere(
              (categoryItem) =>
                  categoryItem.value.title == item.value['category'],
            )
            .value;
        final groceryItem = GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        );
        groceryItemsNotifier.addGroceryItem(groceryItem);
      }

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _error = "Something went wrong! Please try again";
      });
    }
  }
}
