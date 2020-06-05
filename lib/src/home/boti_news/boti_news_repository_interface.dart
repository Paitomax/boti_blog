import 'package:botiblog/src/home/boti_news/model/boti_news_response_model.dart';

abstract class BotiNewsRepositoryInterface {
  Future<BotiNewsResponseModel> fetch();
}
