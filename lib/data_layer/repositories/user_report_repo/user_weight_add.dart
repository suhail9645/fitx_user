import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/user_report/user_report_add.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';

class UserWeitghtAddRepo {
  Future<Either<ErrorModel, bool>> addUserWeight(double weight) async {
    try {
      final response = await UserReportAddOperations().addUserWeights(weight);
      if (response.isRight) {
        return const Right(true);
      }
      return Left(ErrorModel(response.left.error));
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
  }
}
