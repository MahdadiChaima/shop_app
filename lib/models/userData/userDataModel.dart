class UserDataModel {
  bool? status;
  String? message;
  UserData? data;

  UserDataModel.toObject(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.toObject(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData.toObject(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}


class ChangePasswordModel {
  late bool status;
  late String message;
  ChangePasswordModel.toObject(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }}



class LogoutModel {
  late bool status;
  late String message;
  LogoutModel.toObject(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
/*
class LoginModel{
  final  String message;
  final bool status;
 final UserData? data;
 LoginModel({required this.status,required this.data,required this.message});
 factory LoginModel.toObject(Map<String,dynamic>json)=>LoginModel(status: json["status"],
        data : json['data'] != null ? UserData.toObject(json['data']) : null
     , message: json["message"]);
 Map<String,dynamic> toJson()=>{
   "status":status,"message":message,"data":data?.toJson()
 } ;
}*/
