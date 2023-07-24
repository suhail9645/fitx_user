import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/access_key/get_new_access_key.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:fitx_user/presentation/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TImageDeleteOperation {
  Future<Either<ErrorModel, bool>> deleteTImage(int id) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('accessKey')!;
      Response response = await http
          .delete(Uri.parse('${baseUrl}transformation/delete/$id/'), headers: {
        'Authorization': 'Bearer $access',
      });
      if (response.statusCode == 204) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response = await http.delete(
              Uri.parse('${baseUrl}transformation/delete/$id/'),
              headers: {
                'Authorization': 'Bearer ${newAccess.right}',
              });
          if (response.statusCode == 204) {
            return const Right(true);
          }
        }
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('Session Expired'));
  }
}
