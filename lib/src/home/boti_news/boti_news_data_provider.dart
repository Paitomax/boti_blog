import 'package:botiblog/src/home/user_news/model/post_response_model.dart';
import 'package:dio/dio.dart';

class BotiNewsDataProvider {
  final String path = 'https://gb-mobile-app-teste.s3.amazonaws.com/data.json';
  final Dio dio;

  BotiNewsDataProvider(this.dio);

  Future<PostResponseModel> fetch() async {
    final result = await dio.get(path);
    if (result.statusCode >= 200 && result.statusCode < 300) {
      final news = PostResponseModel.fromJson(result.data);
      news.news.sort((b, a) => a.post.date.compareTo(b.post.date));
      return news;
    } else {
      throw Exception('Cant fetch BotiNews');
    }
  }
}
