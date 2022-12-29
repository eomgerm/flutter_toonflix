import 'package:flutter/material.dart';
import 'package:flutter_toonflix/models/webtoon_detail_model.dart';
import 'package:flutter_toonflix/models/webtoon_episode_model.dart';
import 'package:flutter_toonflix/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String thumb, title, id;

  const DetailScreen({
    super.key,
    required this.thumb,
    required this.title,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> details;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    details = ApiService.getToonDetailbyId(widget.id);
    episodes = ApiService.getLatestEpisodesbyId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Hero(
              tag: widget.id,
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 15,
                          offset: const Offset(8, 8),
                          color: Colors.black.withOpacity(0.5))
                    ]),
                clipBehavior: Clip.hardEdge,
                child: Image.network(widget.thumb),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          FutureBuilder(
            future: details,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.about,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        '${snapshot.data!.genre} / ${snapshot.data!.age}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Text('🫥');
              }
            },
          )
        ],
      ),
    );
  }
}
