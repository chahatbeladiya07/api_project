import 'package:api_project/Models/ApiModels.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../Models/ResponseClass.dart';

class apiProvideClass extends ChangeNotifier {
  bool isLoadingForSave = false;
  bool isloading = false;
  List<UserModel> users=[];
  List<bool> tempList=[];
  final dio = Dio();
  // call api
    Future<ResponseClass> apiCall() async {
      isloading=true;
      notifyListeners();
    ResponseClass<List<UserModel>> responseClass = ResponseClass(
        msg: "Something Went Wrong", success: false);
    final response = await dio.get(
        "https://sahil-flutter.vercel.app/api/v1/users"
    );
    print(response.statusCode);
    try {
      if (response.statusCode == 200) {
        responseClass.success = true;
        responseClass.msg = "Success";
        responseClass.data = List<UserModel>.from(
            response.data["data"].map((e) => UserModel.fromJson(e)));
        isloading=false;
        users = responseClass.data!;
        tempList=List.filled(users.length, false);
        notifyListeners();
        return responseClass;
      } else {
        responseClass.success=false;
        responseClass.msg="SomeThing Went Wrong";

        print("Response error");
        isloading=false;
        users=[];
        tempList=[];
        notifyListeners();
        return responseClass;
      }
    } on DioException catch (e) {
      print("dioError : $e");
      isloading=false;
      users=[];
      notifyListeners();
      return responseClass;
    } catch (e) {
      print("catchError: $e");
      isloading=false;
      users=[];
      tempList=[];
      notifyListeners();
      return responseClass;
    }
  }

  // delete api
  Future<bool> apiDelete({required int id}) async {

    try {
      Response response = await dio.delete(
          "https://sahil-flutter.vercel.app/api/v1/users/$id");
      if (response.statusCode == 200) {
        print("$id Deleted");
        notifyListeners();
        return true;
      } else {
        print("$id else ${response.statusCode}");
        notifyListeners();
        return false;
      }
    } on DioException catch (e) {
      print("$id DioException : $e");
      notifyListeners();
      return false;
    } catch (e) {
      print("$id catch error : $e");
      notifyListeners();
      return false;
    }
  }

  // post api
Future<String> postApi({required Map<String,dynamic> userData}) async {

      isLoadingForSave = true;
      notifyListeners();
      try{
        Response response =await dio.post("https://sahil-flutter.vercel.app/api/v1/users",data: userData);
        print("post => ${response.statusCode}");
        if(response.statusCode==201){
          print("post data => ${response.data}");
          isLoadingForSave = false;
          notifyListeners();
          return response.data["msg"];
        } else {
          print("post: ${response.statusCode}");
          isLoadingForSave = false;
          notifyListeners();
          return "user Already exists";
        }
      }
      on DioException catch(e){
        print(e);
        isLoadingForSave = false;
        notifyListeners();
        return  "user already exists";
      } catch(e){
        isLoadingForSave = false;
        notifyListeners();
        return "Something Went Wrong catch";
      }
  }

  putApi({required int id,required Map<String,dynamic> user}) async {
      bool isLoadingForPut=false;
      try{
        isLoadingForPut=true;
        notifyListeners();
        Response response =await dio.put("https://sahil-flutter.vercel.app/api/v1/users/$id",data: user);
        print("responseCode : ${response.statusCode}");
        if(response.statusCode==200){
          isLoadingForPut=false;
          notifyListeners();
          return true;
        } else {
          isLoadingForPut=false;
          notifyListeners();
          return false;
        }
      }on DioException catch (e){
        isLoadingForPut=false;
        notifyListeners();
        print("dio error : $e");
        return false;
      } catch (e){
        print("catch error : $e");
        isLoadingForPut=false;
        return false;
      }
  }

}