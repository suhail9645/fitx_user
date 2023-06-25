import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/models/category/category_page/result.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../presentation/constants/strings.dart';
import '../access_key/get_new_access_key.dart';

class CategoryOperations {
  Future<Either<ErrorModel, Response>> getAllCategories() async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('accessKey')!;
      Response response =
          await http.get(Uri.parse('${baseUrl}category/getall/'), headers: {
        'Authorization': 'Bearer $access',
      });
      if (response.statusCode == 200) {
        return Right(response);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response =
              await http.get(Uri.parse('${baseUrl}category/getall/'), headers: {
            'Authorization': 'Bearer ${newAccess.right}',
          });
          if (response.statusCode == 200) {
            return Right(response);
          }
        }
      }
    } on Exception catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('session expired'));
  }

  Future<Either<ErrorModel, Response>> getNextPageCategories(
      String nextPageUrl) async {
    SharedPreferences shrd = await SharedPreferences.getInstance();
    String access = shrd.getString('accessKey')!;
    Response response = await http.get(Uri.parse(nextPageUrl),
        headers: {'Authorization': 'Bearer $access'});
    if (response.statusCode == 200) {
      return Right(response);
    } else if (response.statusCode == 401) {
      final newAccess = await GetNewAccessKey.getNewAccessKey();
      if (newAccess.isRight) {
        response = await http.get(Uri.parse(nextPageUrl),
            headers: {'Authorization': 'Bearer ${newAccess.right}'});
      }
    }
    if (response.statusCode == 200) {
      return Right(response);
    }
    return Left(ErrorModel('Something wrong'));
  }
}
