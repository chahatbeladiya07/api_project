import 'package:api_project/Models/api_models.dart';
import 'package:api_project/constants.dart';
import 'package:api_project/helpers/error_function.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Models/response_class.dart';

class ApiProvideClass extends ChangeNotifier {
  bool isLoadingForSave = false;
  bool isloading = false;
  bool isLoadingForPut=false;
  bool isLoadingForDelete=false;
  List<UserModel> users=[];
  List<bool> tempList=[];
  final dio = Dio();
  // call api
    Future<ResponseClass> apiCall() async {
      isloading=true;
      notifyListeners();
    ResponseClass<List<UserModel>> responseClass = ResponseClass(
        msg: "Something Went Wrong", success: false);
    try {
      final response = await dio.get("https://sahil-flutter.vercel.app/api/v1/users");
      if (response.statusCode == 200){
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
        responseClass.msg=errorMessage(response.statusCode);
        Fluttertoast.showToast(msg: responseClass.msg);
        isloading=false;
        users=[];
        tempList=[];
        notifyListeners();
        return responseClass;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(msg: responseClass.msg);
      debugPrint("dio catch $e");
      isloading=false;
      users=[];
      notifyListeners();
      return responseClass;
    } catch (e) {
      debugPrint("dio catch $e");
      isloading=false;
      users=[];
      tempList=[];
      Fluttertoast.showToast(msg: responseClass.msg);
      notifyListeners();
      return responseClass;
    }
  }

  // delete api
  Future<ResponseClass> apiDelete({required int id}) async {
    isLoadingForDelete=true;
    notifyListeners();
    ResponseClass responseClass = ResponseClass(msg: StringConstants.initialMsg, success: false);
    Response response = await dio.delete(
        "https://sahil-flutter.vercel.app/api/v1/users/$id");
    try {
      if (response.statusCode == 200) {
        isLoadingForDelete=false;
        notifyListeners();
        responseClass.success=true;
        responseClass.msg="success";
        notifyListeners();
        return responseClass;
      } else {

        responseClass.msg = errorMessage(response.statusCode);
        responseClass.success=false;
        Fluttertoast.showToast(msg: responseClass.msg);
        isLoadingForDelete=false;
        notifyListeners();
        return responseClass;
      }
    } on DioException catch (e) {
      responseClass.success=false;
      responseClass.msg = errorMessage(response.statusCode);
      Fluttertoast.showToast(msg: responseClass.msg);
      isLoadingForDelete=false;
      debugPrint("dio catch $e");
      notifyListeners();
      return responseClass;
    } catch (e) {
      responseClass.success=false;
      responseClass.msg = errorMessage(response.statusCode);
      Fluttertoast.showToast(msg: responseClass.msg);
      isLoadingForDelete=false;
      debugPrint("catch error: $e");
      notifyListeners();
      return responseClass;
    }
  }

  // post api
Future<ResponseClass> postApi({required Map<String,dynamic> userData}) async {
      ResponseClass responseClass =ResponseClass(msg: StringConstants.initialMsg, success: false);
      isLoadingForSave = true;
      notifyListeners();
      try{
        Response response =await dio.post("https://sahil-flutter.vercel.app/api/v1/users",data: userData);
        if(response.statusCode==201){
          responseClass.msg="success";
          responseClass.success=true;
          isLoadingForSave = false;
          notifyListeners();
          return response.data["msg"];
        } else {
          isLoadingForSave = false;
          responseClass.msg=errorMessage(response.statusCode);
          responseClass.success=true;
          Fluttertoast.showToast(msg: errorMessage(response.statusCode));
          notifyListeners();
          return responseClass;
        }
      }
      on DioException catch(e){
        isLoadingForSave = false;
        Fluttertoast.showToast(msg: responseClass.msg);
        debugPrint("dio catch error $e");
        notifyListeners();
        return  responseClass;
      } catch(e){
        responseClass.success=true;
        Fluttertoast.showToast(msg: responseClass.msg);
        notifyListeners();
        return responseClass;
      }
  }

 Future<ResponseClass> putApi({required int id,required Map<String,dynamic> user}) async {
      ResponseClass responseClass = ResponseClass(msg: StringConstants.initialMsg, success: false);
      try{
        isLoadingForPut=true;
        notifyListeners();
        Response response =await dio.put("https://sahil-flutter.vercel.app/api/v1/users/$id",data: user);
        if(response.statusCode==200){
          responseClass.success=true;
          responseClass.msg="Success";
          isLoadingForPut=false;
          notifyListeners();
          return responseClass;
        } else {
          responseClass.msg=errorMessage(response.statusCode);
          responseClass.success=true;
          Fluttertoast.showToast(msg: errorMessage(response.statusCode));
          isLoadingForPut=false;
          notifyListeners();
          return responseClass;
        }
      }on DioException catch (e){

        Fluttertoast.showToast(msg: responseClass.msg);
        debugPrint("dio catch $e");
        isLoadingForPut=false;
        notifyListeners();
        return responseClass;
      } catch (e){
        Fluttertoast.showToast(msg: responseClass.msg);
        debugPrint("catch $e");
        isLoadingForPut=false;
        return responseClass;
      }
  }

}