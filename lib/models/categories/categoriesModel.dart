class CategoriesModel{
bool? status;
DataCategoriesModel? data;
CategoriesModel.toObject(Map<String,dynamic>json){
  status=json["status"];
  data=DataCategoriesModel.toObject(json["data"]);
}

}
class DataCategoriesModel{
  List<DataDataCategories> data=[];
  DataCategoriesModel.toObject(Map<String,dynamic>json ){
    json["data"].forEach((element) {
      data.add(DataDataCategories.toObject(element));
    });
  }
}

class DataDataCategories {
  int? id;
  String? name,image;
  DataDataCategories.toObject(Map<String,dynamic>json){
    id=json["id"];
    name=json["name"];
    image=json["image"];
  }
}