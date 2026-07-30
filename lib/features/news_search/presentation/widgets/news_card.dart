import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/news_article.dart';
import 'publication_date.dart';

class NewsCard extends StatelessWidget {
  const NewsCard(
      {super.key, required this.article, required this.onPostStatusChanged});
  final NewsArticle article;
  final ValueChanged<String> onPostStatusChanged;

  @override
  Widget build(BuildContext context) => Card(
        color: article.isPosted
            ? Theme.of(context)
                .colorScheme
                .secondaryContainer
                .withValues(alpha: 0.72)
            : null,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(article.source.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold))),
                      Chip(label: Text('${article.relevanceScore} pts')),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(article.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(article.summary,
                      maxLines: 4, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 12),
                  Wrap(spacing: 6, runSpacing: 4, children: [
                    for (final keyword in article.matchedKeywords)
                      Chip(
                          visualDensity: VisualDensity.compact,
                          label: Text(keyword))
                  ]),
                  const SizedBox(height: 12),
                  PublicationDate(article: article),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      TextButton.icon(
                          onPressed: () => onPostStatusChanged(article.url),
                          icon: Icon(article.isPosted
                              ? Icons.undo
                              : Icons.check_circle_outline),
                          label: Text(article.isPosted
                              ? 'Desmarcar postado'
                              : 'Marcar como postado')),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: article.url));
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('URL copiada.')));
                          },
                          icon: const Icon(Icons.copy_outlined),
                          tooltip: 'Copiar URL'),
                      IconButton(
                          onPressed: () => launchUrl(Uri.parse(article.url),
                              webOnlyWindowName: '_blank'),
                          icon: const Icon(Icons.open_in_new),
                          tooltip: 'Abrir matéria'),
                    ],
                  ),
                  SelectableText(article.url,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary)),
                ],
              ),
            ),
            if (article.isPosted)
              Positioned(
                top: 10,
                right: 10,
                child: Tooltip(
                    message: 'Marcada como postada',
                    child: CircleAvatar(
                        radius: 13,
                        backgroundColor: Colors.green.shade600,
                        child: const Icon(Icons.check,
                            size: 17, color: Colors.white))),
              ),
          ],
        ),
      );
}
