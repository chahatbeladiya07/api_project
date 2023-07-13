import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

Future<bool> imageValidate({required String url}) async {
  final type = [
    "image/jpeg",
    "image/jpg",
    "image/png",
  ];

  final dio =Dio();
  try{
    Response response= await dio.head(url);
    if(response.statusCode==200){
      final image = response.headers["content-type"]![0];

      final bool result = type.any((e) => e == image.toLowerCase());
      return result;
    } else {
      return false;
    }
  } on DioException catch (e){
    debugPrint("$e");
    return false;
  }
  catch(e){
    return false;
  }
}