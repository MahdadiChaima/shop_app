class ChangeFavoritesModel {
  late bool status;
  late String message;

  ChangeFavoritesModel.toObject(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
