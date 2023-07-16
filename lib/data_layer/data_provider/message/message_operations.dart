import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/access_key/get_new_access_key.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageOperationImp {
  Future<Either<ErrorModel, Response>> getAllMessagesAndTrainers(String endPoint) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('accessKey')!;
      Response response = await http.get(Uri.parse(endPoint),
          headers: {'Authorization': 'Bearer $access'});
    if(response.statusCode==200){
      return Right(response);
    }else if (response.statusCode==401){
      final newAccess=await GetNewAccessKey.getNewAccessKey();
      if(newAccess.isRight){
        access=newAccess.right;
     response = await http.get(Uri.parse(endPoint),
          headers: {'Authorization': 'Bearer $access'});
    if(response.statusCode==200){
      return Right(response);
    } else{
      String ? errorMessage=jsonDecode(response.body)['detail'];
      return Left(ErrorModel(errorMessage??'Session expired'));
    }
      }
    }
    else{
       String ? errorMessage=jsonDecode(response.body)['detail'];
      return Left(ErrorModel(errorMessage??'SomeThing wrong'));
    }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
     return Left(ErrorModel('SomeThing wrong'));
  }
}
