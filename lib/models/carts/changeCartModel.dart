class ChangeCartModel {
  bool? status;
  String? message;
  Data? data;


  ChangeCartModel.toObject(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.toObject(json['data']) : null;
  }


}

class Data {
  int? id;
  int? quantity;
  Product? product;

  Data({this.id, this.quantity, this.product});

  Data.toObject(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ? new Product.toObject(json['product']) : null;
  }

}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;



  Product.toObject(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}