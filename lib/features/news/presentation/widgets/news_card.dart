
import 'package:flutter/material.dart';

import '../../data/models/news_response.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.news,
  });
  final ArticleModel news;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 15,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (news.urlToImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  news.urlToImage!,
                ),
              ),
            Text(
              news.content!,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(news.source!.name!),
            )
          ],
        ),
      ),
    );
  }
}
