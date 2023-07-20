import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart';
import '../../../presentation/constants/strings.dart';
import '../../data_provider/message/message_operations.dart';
import '../../models/error/error_model.dart';
import '../../models/trainer_data/trainer.dart';

class GetAllTrainersRepo{
  Future<Either<ErrorModel, List<Trainer>>> getAllTrainer(
     ) async {
    try {
      final responeOrError = await MessageOperationImp()
          .getAllMessagesAndTrainers('${baseUrl}trainer/all/');
      if (responeOrError.isRight) {
        Response response = responeOrError.right;
        List<Trainer> allTrainers = [];
        while (true) {
          List<dynamic> allDatas = jsonDecode(response.body)['results'];
          for (var element in allDatas) {
            Trainer trainer = Trainer.fromJson(element);
            allTrainers.add(trainer);
          }
          if (jsonDecode(response.body)['next'] != null) {
            final responeOrError = await MessageOperationImp()
                .getAllMessagesAndTrainers(
                    jsonDecode(response.body)['next']);
            if (responeOrError.isRight) {
              response = responeOrError.right;
            } else {
              return Left(responeOrError.left);
            }
          } else {
            return Right(allTrainers);
          }
        }
      } else {
        return Left(responeOrError.left);
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
  }
}