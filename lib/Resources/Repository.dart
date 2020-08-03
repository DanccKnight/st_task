import 'package:st_task/Models/News.dart';
import 'package:st_task/Resources/ApiProvider.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<News> fetchNewsArticles() => apiProvider.fetchArticles();
}