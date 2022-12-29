import 'dart:convert';

import 'package:flutter_toonflix/models/webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodayToons() async {
    List<WebtoonModel> webtoonsInstances = [];

    final url = Uri.parse('$baseUrl/$today');
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Error();
    }

    final List<dynamic> webtoons = jsonDecode(res.body);
    for (var webtoon in webtoons) {
      webtoonsInstances.add(WebtoonModel.fromJson(webtoon));
    }
    return webtoonsInstances;
  }
}