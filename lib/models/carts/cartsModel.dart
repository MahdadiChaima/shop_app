class CartsModel {
  bool? status;
  String? message;
  Data? data;

  CartsModel.toObject(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.toObject(json['data']) : null;
  }

}

class Data {
  List<CartItems>? cartItems;
  int? subTotal;
  int? total;

  Data({this.cartItems, this.subTotal, this.total});

  Data.toObject(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(new CartItems.toObject(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }


}

class CartItems {
  int? id;
  int? quantity;
  Product? product;

  CartItems.toObject(Map<String, dynamic> json) {
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
  List<String>? images;
  bool? inFavorites;
  bool? inCart;


  Product.toObject(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}
class DeleteCartModel {
  late bool status;
  late String message;
  DeleteCartModel.toObject(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}