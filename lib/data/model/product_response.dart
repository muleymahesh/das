class Products {
  String? id;
  String? name;
  String? sKU;
  String? catId;
  String? price;
  String? quantity;
  String? commission;
  String? description;
  String? createdAt;
  String? updatedAt;

  Products(
      {this.id, this.name, this.sKU, this.catId, this.price, this.quantity, this.commission, this.description, this.createdAt, this.updatedAt});

  Products copyWith(
      {String? id, String? name, String? sKU, String? catId, String? price, String? quantity, String? commission, String? description, String? createdAt, String? updatedAt}) =>
      Products(id: id ?? this.id,
          name: name ?? this.name,
          sKU: sKU ?? this.sKU,
          catId: catId ?? this.catId,
          price: price ?? this.price,
          quantity: quantity ?? this.quantity,
          commission: commission ?? this.commission,
          description: description ?? this.description,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["SKU"] = sKU;
    map["cat_id"] = catId;
    map["Price"] = price;
    map["quantity"] = quantity;
    map["commission"] = commission;
    map["Description"] = description;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }

  Products.fromJson(dynamic json){
    id = json["product_id"];
    name = json["name"];
    sKU = json["SKU"];
    catId = json["cat_id"];
    price = json["Price"];
    quantity = json["quantity"];
    commission = json["commission"];
    description = json["Description"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }
}

class ProductResponse {
  List<Products>? productsList;

  ProductResponse({this.productsList});

  ProductResponse copyWith({List<Products>? productsList}) =>
      ProductResponse(productsList: productsList ?? this.productsList);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (productsList != null) {
      map["products"] = productsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  ProductResponse.fromJson(dynamic json){
    if (json["products"] != null) {
      productsList = [];
      json["products"].forEach((v) {
        productsList?.add(Products.fromJson(v));
      });
    }
  }
}