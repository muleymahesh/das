// import 'package:realm/realm.dart';
import 'dart:io';
// part 'Product.g.dart';

// @RealmModel()
class Product {
  // @PrimaryKey()
  late int id;
  late String name;
  late double price;
  late int stock;
  late String type;

  Product(this.id, this.name, this.price, this.stock, this.type); // Add type for freshsold, etc.
}