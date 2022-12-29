import 'dart:convert';

import 'package:flutter_toonflix/models/webtoon_detail_model.dart';
import 'package:flutter_toonflix/models/webtoon_episode_model.dart';
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

  static Future<WebtoonDetailModel> getToonDetailbyId(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Error();
    }

    final webtoonDetail = jsonDecode(res.body);
    return WebtoonDetailModel.fromJson(webtoonDetail);
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesbyId(
      String id) async {
    List<WebtoonEpisodeModel> episodeInstances = [];

    final url = Uri.parse('$baseUrl/$id/episodes');
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Error();
    }

    final episodes = jsonDecode(res.body);
    for (var episode in episodes) {
      episodeInstances.add(WebtoonEpisodeModel.fromJson(episode));
    }

    return episodeInstances;
  }
}
