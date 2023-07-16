import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/message/message_operations.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:fitx_user/data_layer/models/message_result/message.dart';
import 'package:http/http.dart';
import '../../../presentation/constants/strings.dart';

class MessageOperationRepo {
  Future<Either<ErrorModel, List<Message>>> getAllMessages(
      int trainerId) async {
    try {
      final responeOrError = await MessageOperationImp()
          .getAllMessagesAndTrainers('${baseUrl}messages/$trainerId/');
      if (responeOrError.isRight) {
        Response response = responeOrError.right;
        List<Message> allMessages = [];
        while (true) {
          List<dynamic> allDatas = jsonDecode(response.body)['results'];
          for (var element in allDatas) {
            Message message = Message.fromJson(element);
            allMessages.add(message);
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
            return Right(allMessages);
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
