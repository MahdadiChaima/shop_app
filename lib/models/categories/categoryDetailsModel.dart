class CategoryDetailModel {
  bool? status;
  late DataCategory data;


  CategoryDetailModel.toObject(Map<String, dynamic> json) {
    status = json['status'];
    data = DataCategory.toObject(json['data']);
  }

}

class DataCategory {
  int? currentPage;
  late List<ProductDataCategory> productData;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null nextPageUrl;
  String? path;
  int? perPage;
  Null prevPageUrl;
  int? to;
  int? total;


  DataCategory.toObject(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    productData = [];
    json['data'].forEach((element) {
      productData.add(ProductDataCategory.toObject(element));
    });
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class ProductDataCategory {
  int ?id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String ?name;
  String ?description;
  List<String> ?images;
  bool? inFavorites;
  bool ?inCart;

  ProductDataCategory.toObject(Map<String, dynamic> json) {
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