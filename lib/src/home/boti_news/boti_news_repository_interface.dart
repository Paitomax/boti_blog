import 'package:botiblog/src/home/user_news/model/post_response_model.dart';

abstract class BotiNewsRepositoryInterface {
  Future<PostResponseModel> fetch();
}
