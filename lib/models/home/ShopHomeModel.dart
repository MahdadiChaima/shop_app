

class ShopHomeModel{  bool? status;
String? message;
ShopData? data;
ShopHomeModel.toObject(Map<String, dynamic> json) {
  status = json['status'];
  message = json['message'];
  data = ShopData.toObject(json['data']);
}
}

class ShopData {
  late List<ProductModel> products = [];
  late List<BannerModel> banners = [];

  ShopData.toObject(Map<String, dynamic> json) {
    json['products'].forEach((element) {
      products.add(ProductModel.toObject(element));
    });
    json['banners']!.forEach((element) {
      //if (BannerModel.toObject(element).id == 11 ||
        //  BannerModel.toObject(element).id == 12 ||
          //BannerModel.toObject(element).id == 17)
      if(element!=null)
        banners.add(BannerModel.toObject(element));
    });
  }

}
class BannerModel {
  int? id;
  String? image,category,product;
  BannerModel.toObject(Map<String,dynamic>json){
    id=json["id"];
    image=json["image"];
    category=json["category"];
    product=json['product'];
  }
}
class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? inFav;
  bool? inCart;

  ProductModel.toObject(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFav = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
