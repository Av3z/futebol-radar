import 'package:flutter/material.dart';

import '../../domain/entities/news_article.dart';

class PublicationDate extends StatelessWidget {
  const PublicationDate({super.key, required this.article});
  final NewsArticle article;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (!article.publishedAtVerified || article.publishedAt == null) {
      return Row(
          children: [const Icon(Icons.help_outline, size: 18), const SizedBox(width: 6), Text('Data não confirmada', style: textTheme.bodyMedium)]);
    }
    final date = article.publishedAt!.toLocal();
    final dateText = '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    final timeText = '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    return Row(
      children: [
        const Icon(Icons.schedule, size: 18),
        const SizedBox(width: 6),
        Text(dateText, style: textTheme.bodyMedium),
        const SizedBox(width: 5),
        Text('às', style: textTheme.bodyMedium),
        const SizedBox(width: 5),
        Text(timeText, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
