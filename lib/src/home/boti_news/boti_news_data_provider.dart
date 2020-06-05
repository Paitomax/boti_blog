import 'package:botiblog/src/home/boti_news/model/boti_news_response_model.dart';
import 'package:dio/dio.dart';

class BotiNewsDataProvider {
  final Dio dio;

  BotiNewsDataProvider(this.dio);

  Future<BotiNewsResponseModel> fetch() async {
    return BotiNewsResponseModel(null);
  }
}
