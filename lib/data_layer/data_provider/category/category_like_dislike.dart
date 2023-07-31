import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/access_key/get_new_access_key.dart';
import 'package:fitx_user/presentation/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/error/error_model.dart';

class CategoryLikeAndDislike {
  Future<Either<ErrorModel, bool>> categoryLike(int id) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('accessKey')!;
      Response response =
          await http.patch(Uri.parse('${baseUrl}users/like/$id/'),  );
      if (response.statusCode == 202) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response = await http
              .patch(Uri.parse('${baseUrl}users/like/$id/'), headers: {
            'Authorization': 'Bearer ${newAccess.right}',
          });
          if (response.statusCode == 202) {
            return const Right(true);
          }
        }
      }
    } on Exception catch (e) {
      return Left(
        ErrorModel(
          e.toString(),
        ),
      );
    }
    return Left(ErrorModel('Session Expired'));
  }

  Future<Either<ErrorModel, Response>> getUserLikedCategories() async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('accessKey')!;
      Response response = await http.get(Uri.parse('${baseUrl}users/getlikes/'),
          headers: {'Authorization': 'Bearer $access'});
      if (response.statusCode == 200) {
        return Right(response);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response = await http.get(Uri.parse('${baseUrl}users/getlikes'),
              headers: {'Authorization': 'Bearer ${newAccess.right}'});
          if (response.statusCode == 200) {
            return Right(response);
          }
        }
      }
    } on Exception catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('Session Expired'));
  }

  Future<Either<ErrorModel, bool>> categoryDislike(int id) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('accessKey')!;
      Response response =
          await http.patch(Uri.parse('${baseUrl}users/dislike/$id/'), headers: {
        'Authorization': 'Bearer $access',
      });
      if (response.statusCode == 202) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response = await http
              .patch(Uri.parse('${baseUrl}users/dislike/$id/'), headers: {
            'Authorization': 'Bearer ${newAccess.right}',
          });
          if (response.statusCode == 202) {
            return const Right(true);
          }
        }
      }
    } on Exception catch (e) {
      return Left(
        ErrorModel(
          e.toString(),
        ),
      );
    }
    return Left(ErrorModel('Session Expired'));
  }
}
