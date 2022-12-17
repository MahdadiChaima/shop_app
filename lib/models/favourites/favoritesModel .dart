
class FavoritesModel {
  bool? status;
  Data? data;
  FavoritesModel.toObject(Map<String, dynamic> json) {
    status = json['status'];
    data=Data.toObject(json["data"]);

  }

}

class Data {
  List<FavoritesData > data=[];
  Data.toObject(Map<String,dynamic>json){
    json['data'].forEach((element) {
      data.add(FavoritesData.toObject(element));
    });
  }
}

class FavoritesData  {
  int? id;
  ProductFavModel ? product;
  FavoritesData .toObject(Map<String, dynamic> json) {
    id = json['id'];
  product=ProductFavModel .toObject(json["product"]);
  
  }
  
}

class ProductFavModel  {
  int ?id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String ?name;
  ProductFavModel.toObject(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}