class UpdateCartModel {
  bool? status;
  String? message;
  Data? data;

  UpdateCartModel.toObject(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.toObject(json['data']) : null;
  }

}

class Data {
  Cart? cart;
  int? subTotal;
  int? total;


  Data.toObject(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new Cart.toObject(json['cart']) : null;
    subTotal = json['sub_total'];
    total = json['total'];
  }

}

class Cart {
  int? id;
  int? quantity;
  Product? product;

  Cart.toObject(Map<String, dynamic> json) {
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

  Product.toObject(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }


}