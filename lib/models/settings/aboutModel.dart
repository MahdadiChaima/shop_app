class AboutModel {
  bool? status;
  String? message;
  Data? data;


  AboutModel.toObject(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.toObject(json['data']) : null;
  }

}

class Data {
  String? about;
  String? terms;

  Data.toObject(Map<String, dynamic> json) {
    about = json['about'];
    terms = json['terms'];
  }

}