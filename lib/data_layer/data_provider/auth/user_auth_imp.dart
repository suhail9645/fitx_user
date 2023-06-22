import 'dart:convert';
import 'dart:io';
import 'package:fitx_user/presentation/constants/lists.dart';
import 'package:fitx_user/presentation/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthFunctions {
  Future<Either<ErrorModel, bool>> registerUser(
      File? image, String groupValue) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse("${baseUrl}users/create/"),
      );
      if (image != null) {
        var pic = await http.MultipartFile.fromPath(
          "profile_picture",
          image.path,
        );
        request.files.add(pic);
      }
      request.fields.addAll({
        "name": registerPageTextEditingControllers[0].text,
        "password": registerPageTextEditingControllers[4].text,
        "username": registerPageTextEditingControllers[3].text,
        "email": registerPageTextEditingControllers[1].text,
        "date_of_birth": registerPageTextEditingControllers[2].text,
        "gender": groupValue.toLowerCase(),
      });
      StreamedResponse res = await request.send();
      if (res.statusCode == 201) {
        return const Right(true);
      } else {
        Response response = await http.Response.fromStream(res);
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data.length == 2) {
          return Left(ErrorModel('Email and Username already exists'));
        }
        return Left(ErrorModel(data.values.single.first.toString()));
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
  }

  Future<Either<ErrorModel, bool>> loginUser() async {
    Map<String, String> body = {
      'username': loginPageTextEditingControllers[0].text,
      'password': loginPageTextEditingControllers[1].text,
    };
    try {
      Response response = await http.post(Uri.parse('${baseUrl}auth/token/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(body));
      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'refreshKey', jsonDecode(response.body)['refresh']);
        await prefs.setString('accessKey', jsonDecode(response.body)['access']);
        return const Right(true);
      } else {
        return Left(ErrorModel('No active user in given detailes'));
      }
    } on Exception catch (e) {
      return Left(ErrorModel(e.toString()));
    }
  }
}
