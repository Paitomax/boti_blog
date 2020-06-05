import 'package:botiblog/src/home/boti_news/model/boti_news_response_model.dart';
import 'package:dio/dio.dart';

class BotiNewsDataProvider {
  final String path = 'https://gb-mobile-app-teste.s3.amazonaws.com/data.json';
  final Dio dio;

  BotiNewsDataProvider(this.dio);

  Future<BotiNewsResponseModel> fetch() async {
    final result = await dio.get(path);
    if (result.statusCode >= 200 && result.statusCode < 300) {
      final news = BotiNewsResponseModel.fromJson(result.data);
      news.news
          .sort((b, a) => a.message.createdAt.compareTo(b.message.createdAt));
      return news;
    } else {
      throw Exception('Cant fetch BotiNews');
    }
  }
}
