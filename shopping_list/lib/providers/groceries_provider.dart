import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/types/types.dart';

final groceryItemsListProvider =
    StateNotifierProvider<GroceryItemsNotifier, GroceriesList>(
  (ref) => GroceryItemsNotifier(),
);

class GroceryItemsNotifier extends StateNotifier<GroceriesList> {
  GroceryItemsNotifier() : super([]);

  bool addGroceryItem(GroceryItem grocery) {
    state = [...state, grocery];
    return true;
  }

  bool removeGroceryItem(GroceryItem grocery) {
    state = state.where((gi) => gi.id != grocery.id).toList();
    return false;
  }
}
