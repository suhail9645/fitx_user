import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/models/user/user.dart';
import 'package:http/http.dart';


import '../../../presentation/constants/strings.dart';
import '../../data_provider/message/message_operations.dart';
import '../../models/error/error_model.dart';

class GetAllMessagedUsersRepo{
  Future<Either<ErrorModel, List<User>>> getAllMessagedUsers(
     ) async {
    try {
      final responeOrError = await MessageOperationImp()
          .getAllMessagesAndTrainers('${baseUrl}messages/users/');
      if (responeOrError.isRight) {
        Response response = responeOrError.right;
        List<User> allUsers = [];
        while (true) {
          List<dynamic> allDatas = jsonDecode(response.body)['results'];
          for (var element in allDatas) {
            User user = User.fromJson(element);
            allUsers.add(user);
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
            return Right(allUsers);
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