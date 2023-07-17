import 'dart:convert';
import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/access_key/get_new_access_key.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:fitx_user/presentation/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessageSending {
  Future<Either<ErrorModel, bool>> sendTextMessage(
      int trainerId, String message, WebSocketChannel channel) async {
    try {
      channel.sink.add(jsonEncode({
        "type": "message",
        "message": {"type": "text", "text": message, "receiver_id": trainerId}
      }));
      return const Right(true);
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
  }

  Future<Either<ErrorModel, bool>> sendImagesAndFiles(
      int trainerId, File file, WebSocketChannel channel) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('accessKey')!;
      StreamedResponse streamedResponse =
          await messageImageAddHelper(file, access);
      if (streamedResponse.statusCode == 201) {
        Response response = await http.Response.fromStream(streamedResponse);
        int id = jsonDecode(response.body)['id'];
        channel.sink.add(jsonEncode({
          "type": "message",
          "message": {
            "type": "image",
            "text": '',
            "media_id": id,
            "receiver_id": trainerId
          }
        }));
        return const Right(true);
      } else if (streamedResponse.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          access = newAccess.right;
          streamedResponse = await messageImageAddHelper(file, access);
          if (streamedResponse.statusCode == 201) {
            Response response =
                await http.Response.fromStream(streamedResponse);
            int id = jsonDecode(response.body)['id'];
            channel.sink.add(jsonEncode({
              "type": "message",
              "message": {
                "type": "image",
                "text": '',
                "media_id": id,
                "receiver_id": trainerId
              }
            }));
          }
        }
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('Session Expired'));
  }

  Future<StreamedResponse> messageImageAddHelper(
      File file, String access) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}messages/upload/'),
    );
    request.headers.addAll({
      'Authorization': 'Bearer $access',
      'Content-type': 'multipart/form-data'
    });
    final uFile = await http.MultipartFile.fromPath(
      "media",
      file.path,
    );
    request.files.add(uFile);
    StreamedResponse response = await request.send();
    return response;
  }
}
