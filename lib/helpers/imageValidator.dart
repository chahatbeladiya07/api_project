import 'package:dio/dio.dart';

Future<bool> imageValidate({required String url}) async {
  final type = [
    "image/jpeg",
    "image/jpg",
    "image/png",
  ];

  final dio =Dio();
  try{
    Response response= await dio.head(url);
    print("Response Code : ${response.statusCode}");
    if(response.statusCode==200){
      print("Response header : ${response.headers["content-type"]![0]}");
      final image = response.headers["content-type"]![0];

      final bool result = type.any((e) => e == image.toLowerCase());
      print("result = $result");
      return result;
    } else {
      return false;
    }
  } on DioException catch (e){
    return false;
  }
  catch(e){
    return false;
  }
}