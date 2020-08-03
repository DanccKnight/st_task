import 'package:rxdart/rxdart.dart';
import 'package:st_task/Models/News.dart';
import 'package:st_task/Resources/Repository.dart';

class ArticlesBloc {

  final _repository = Repository();
  final _articlesFetcher = PublishSubject<News>();

  Stream<News> get allArticles => _articlesFetcher.stream;

  void fetchAllArticles() async {
    News item = await _repository.fetchNewsArticles();
    _articlesFetcher.sink.add(item);
  }

  void dispose() {
    _articlesFetcher.close();
  }
}