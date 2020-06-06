import 'package:botiblog/src/home/boti_news/boti_news_data_provider.dart';
import 'package:botiblog/src/home/boti_news/boti_news_repository_interface.dart';
import 'package:botiblog/src/home/user_news/model/post_response_model.dart';

class BotiNewsRepository extends BotiNewsRepositoryInterface {
  final BotiNewsDataProvider botiNewsDataProvider;

  BotiNewsRepository(this.botiNewsDataProvider);

  @override
  Future<PostResponseModel> fetch() {
    return botiNewsDataProvider.fetch();
  }
}
