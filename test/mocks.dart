import 'package:botiblog/src/home/user_news/model/post_message_model.dart';
import 'package:botiblog/src/home/user_news/model/post_model.dart';
import 'package:botiblog/src/home/user_news/model/post_response_model.dart';
import 'package:botiblog/src/shared/current_datetime/current_date.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:botiblog/src/sign_up/model/user_account_model.dart';

class Mocks {
  static UserModel userModel() =>
      UserModel('José', id: 1, email: 'jose@teste.com.br');

  static UserModel accountUserModel() =>
      UserAccountModel('José', 'jose@teste.com.br', '123456');

  static List<PostModel> listPostModel() => [
        PostModel(
          PostMessageModel('post1', DateTime(2020, 05, 20), id: 1),
          userModel(),
        ),
        PostModel(
          PostMessageModel('post2', DateTime(2020, 05, 21), id: 2),
          userModel(),
        ),
      ];

  static PostModel postModel() => PostModel(
        PostMessageModel('post', DateTime(2020, 05, 20), id: 1),
        userModel(),
      );

  static PostMessageModel postMessageModel() =>
      PostMessageModel('post', DateTime(2020, 01, 01), id: 1);

  static PostMessageModel postMessageModelFromNow(
          CurrentDateTime currentDateTime) =>
      PostMessageModel('post', currentDateTime.now(), id: 1);

  static PostResponseModel postResponseModelEmpty() => PostResponseModel([]);

  static PostResponseModel postResponseModel() => PostResponseModel([
        PostModel(
          PostMessageModel('oi', DateTime(2020, 1, 1)),
          UserModel('O Boticario', profilePictureUrl: 'http://google.com'),
        ),
        PostModel(
          PostMessageModel('olar', DateTime(2020, 1, 2)),
          UserModel('O Boticario', profilePictureUrl: 'http://google.com'),
        ),
      ]);
}
