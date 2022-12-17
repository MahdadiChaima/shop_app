import 'package:ap/shared/components/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",

        receiveDataWhenStatusError: true));
  }

  static Future<Response> getData(
      {required String path, Map<String, String>? query,String? token}) async {
    dio?.options.headers={"Content-Type":"application/json",
    "lang":"en",
      "Authorization":token
    };
    return await dio!.get(path, queryParameters: query);
  }
  static Future<Response>postData({
  required String url,required Map<String,dynamic> data,String? token
})async{
    dio?.options.headers={"Content-Type":"application/json",
    "lang":"en",
      "Authorization":token
    };
    return await dio!.post(url,data: data);
}
  static Future<Response>deleteData({
    required String url,required Map<String,dynamic> data,String? token
  })async{
    dio?.options.headers={"Content-Type":"application/json",
      "lang":"en",
      "Authorization":token
    };
    return await dio!.delete(url,queryParameters:  data);
  }
  static Future<Response<dynamic>> updateData(
      {required String url,
        Map<String, dynamic>? query,
        String? token,
        required Map<String, dynamic> data}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': "en",
      'Authorization' : token!=null?token:'',
    };
    return await dio!.put(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
