import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String thumb, title, id;

  const DetailScreen({
    super.key,
    required this.thumb,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
      ),
      body: Column(children: [
        const SizedBox(
          height: 50,
        ),
        Center(
          child: Hero(
            tag: id,
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
              child: Image.network(thumb),
            ),
          ),
        ),
      ]),
    );
  }
}
