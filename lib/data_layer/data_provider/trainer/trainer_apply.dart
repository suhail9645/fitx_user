import 'dart:convert';
import 'dart:io';
import 'package:fitx_user/data_layer/data_provider/access_key/get_new_access_key.dart';
import 'package:fitx_user/presentation/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrainerApply {
  Future<Either<ErrorModel, bool>> applyForTrainer(
      String phoneNumber, double experience, List<File> certificates) async {
    List<int> certificateIds = [];
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('accessKey')!;
      for (File element in certificates) {
        Either<ErrorModel, Response> eitherResponse =
            await certificateAddHelper(element, access);
        if (eitherResponse.isLeft) {
          return Left(eitherResponse.left);
        } else if (eitherResponse.right.statusCode == 401) {
          Either<ErrorModel, String> newAccess = await GetNewAccessKey.getNewAccessKey();
          if (newAccess.isRight) {
            eitherResponse =
                await certificateAddHelper(element, newAccess.right);
            if (eitherResponse.isLeft) {
              return Left(eitherResponse.left);
            } else if (eitherResponse.right.statusCode == 201) {
              int certificateId = jsonDecode(eitherResponse.right.body)['id'];
              certificateIds.add(certificateId);
            } else {
              return Left(ErrorModel('Session Expired'));
            }
          }
        } else if (eitherResponse.right.statusCode == 201) {
          int certificateId = jsonDecode(eitherResponse.right.body)['id'];
          certificateIds.add(certificateId);
        }
      }
      Map<String,dynamic> data={
        "phone": phoneNumber,
        "certificate_ids": certificateIds,
        "experience": experience,
      };
      Response response =
          await http.post(Uri.parse('${baseUrl}trainer/apply/'), body: jsonEncode(data), headers: {
        'Authorization': 'Bearer $access',
        'Content-type': 'application/json'
      });
      if(response.statusCode==401){
        final newAccess=await GetNewAccessKey.getNewAccessKey();
        if(newAccess.isRight){

          response =
          await http.post(Uri.parse('${baseUrl}trainer/apply/'), body: jsonEncode(data) , headers: {
        'Authorization': 'Bearer $access',
         'Content-type': 'application/json'
      });
      if(response.statusCode==201){
        return const Right(true);
      }
        }
      }
      else if(response.statusCode==201){
        return const Right(true);
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('Session Expired'));
  }

  Future<Either<ErrorModel, Response>> certificateAddHelper(
      File certificate, String access) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${baseUrl}trainer/certificate/'),
      );
      request.headers.addAll({
        'Authorization': 'Bearer $access',
        'Content-type': 'multipart/form-data'
      });
      final pic = await http.MultipartFile.fromPath(
        "file",
        certificate.path,
      );
      request.files.add(pic);
      StreamedResponse streamedResponse = await request.send();
      Response response = await http.Response.fromStream(streamedResponse);
      return Right(response);
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
  }
}
