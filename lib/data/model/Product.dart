import 'package:objectbox/objectbox.dart';

@Entity()
class Product {
  @Id( assignable: true)
  late int id;
  late String name;
  late String sku;
  late double price;
  late int quantity;
  late int catId;
  late int commission;
  late String type;

  Product(this.id, this.name, this.price, this.quantity, this.commission, this.type); // Add type for freshsold, etc.
}