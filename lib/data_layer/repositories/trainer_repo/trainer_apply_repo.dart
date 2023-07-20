import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/trainer/trainer_apply.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:fitx_user/presentation/constants/lists.dart';


class TrainerApplyRepo {
  Future<Either<ErrorModel, bool>> applyTrianer(
     
      List<File> certificates) async {
    try {
      String phoneNumber = trainerPhoneNumber.text;
      double experience = double.parse(trainerExperience.text);
      final boolOrError = await TrainerApply()
          .applyForTrainer(phoneNumber, experience, certificates);
      if (boolOrError.isLeft) {
        return Left(boolOrError.left);
      } else {
        return Right(boolOrError.right);
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
  }
}
