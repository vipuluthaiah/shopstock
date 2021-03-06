import 'dart:convert';

import 'package:shopstock/backshop/category_assigner.dart';
import 'package:shopstock/backshop/session_details.dart';
import 'package:shopstock/backshop/store.dart';
import 'package:shopstock/backshop/item.dart';

// Method to parse the response from getStoresInArea
List<Store> parseStoresInArea(String storesJSON) {
  var storeObjJson = jsonDecode(storesJSON)['stores'] as List;
  return storeObjJson.map((storeJson) => Store.fromJson(storeJson)).toList();
}

// Method to parse the list of all items
List<Item> parseAllItems(String itemsCategoriesJson) {
  var items = jsonDecode(itemsCategoriesJson)['items'] as List;
  return items.map((item) => Item.fromJson(item)).toList();
}

// Method to initialize an assigner for item categories
CategoryAssigner createAssigner(String itemsCategoriesJson) {
  var categories = jsonDecode(itemsCategoriesJson)['item_categories'] as List;
  var assigner = CategoryAssigner.blank();
  categories.forEach((category) =>
      assigner.addCategory(category['id'] as int, category['name'] as String));
  return assigner;
}

// Method to parse the error message from a server response
String parseError(String response) => jsonDecode(response)['error'] as String;

// Method to parse the API key from a server response
String parseKey(String response) => jsonDecode(response)['key'] as String;

// Method to get the server success attribute
bool parseSuccessStatus(String response) =>
    jsonDecode(response)['success'] as bool;

// Method to return a list of stores w/current confidence information
List<Item> parseItemsWithLabels(String response) {
  var items = jsonDecode(response)['items'] as List;
  print(response);

  Map<int, double> labels = Map();
  for (var item in items) {
    // Type conversion
    final id = int.parse(item['id']);
    var label = item['label'];
    if (label is int) {
      label = label.toDouble();
    }
    // Assignment in the map
    labels[id] = label;
  }

  List<Item> allItems = [];
  for (Item item in Session.allItems) {
    if (labels[item.id] != null) {
      allItems.add(Item.full(item.id, item.name, item.categoryID, labels[item.id]));
    } else {
      allItems.add(Item.full(item.id, item.name, item.categoryID, 0.0));
    }
  }

  return allItems;
}
