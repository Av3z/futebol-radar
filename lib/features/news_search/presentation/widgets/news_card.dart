import 'package:flutter/material.dart';

import '../../domain/entities/news_article.dart';
import 'news_card_body.dart';

class NewsCard extends StatelessWidget {
  const NewsCard(
      {super.key, required this.article, required this.onPostStatusChanged});

  final NewsArticle article;
  final ValueChanged<String> onPostStatusChanged;

  @override
  Widget build(BuildContext context) {
    final imageUrl = article.imageUrl;
    final hasImage = imageUrl != null && imageUrl.trim().isNotEmpty;
    final thumbnailWidth =
        MediaQuery.sizeOf(context).width < 700 ? 120.0 : 200.0;

    return Card(
      color: article.isPosted
          ? Theme.of(context)
              .colorScheme
              .secondaryContainer
              .withValues(alpha: 0.72)
          : null,
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (hasImage)
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: thumbnailWidth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        alignment: Alignment.center,
                        child: const Icon(Icons.image_not_supported_outlined),
                      ),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: NewsCardBody(
                  article: article, onPostStatusChanged: onPostStatusChanged),
            ),
          ],
        ),
      ),
    );
  }
}
