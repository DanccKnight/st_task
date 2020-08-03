import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:st_task/Models/News.dart';

class ApiProvider {

  Future<News> fetchArticles() async {
    final response = await http.get(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=${DotEnv().env['API_KEY']}");
    if (response.statusCode == 200) {
      return News.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch the news articles");
    }
  }

}
