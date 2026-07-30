import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/social_post.dart';
import 'social_post_date.dart';

class SocialPostCard extends StatelessWidget {
  const SocialPostCard({super.key, required this.post});

  final SocialPost post;

  @override
  Widget build(BuildContext context) {
    final imageUrl = post.imageUrl;
    final hasImage = imageUrl != null && imageUrl.trim().isNotEmpty;
    final thumbnailWidth =
        MediaQuery.sizeOf(context).width < 700 ? 120.0 : 180.0;
    final platformIcon = switch (post.platform) {
      'Instagram' => Icons.camera_alt_outlined,
      'Facebook' => Icons.facebook,
      'X' => Icons.close,
      'Threads' => Icons.forum_outlined,
      _ => Icons.public,
    };

    return Card(
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(platformIcon,
                            size: 18,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 6),
                        Text(post.platform.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text('${post.engagementScore} pts',
                            style: Theme.of(context).textTheme.labelMedium),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(post.author,
                        style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 6),
                    Text(post.text.isEmpty ? 'Publicação sem texto' : post.text,
                        maxLines: 5, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 10),
                    Wrap(spacing: 8, runSpacing: 6, children: [
                      Chip(
                          avatar: const Icon(Icons.favorite_outline, size: 16),
                          label: Text('${post.likes}')),
                      Chip(
                          avatar:
                              const Icon(Icons.mode_comment_outlined, size: 16),
                          label: Text('${post.comments}')),
                      Chip(
                          avatar: const Icon(Icons.repeat, size: 16),
                          label: Text('${post.shares}')),
                    ]),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SocialPostDate(publishedAt: post.publishedAt),
                        const Spacer(),
                        TextButton.icon(
                            onPressed: () => launchUrl(Uri.parse(post.url),
                                webOnlyWindowName: '_blank'),
                            icon: const Icon(Icons.open_in_new),
                            label: const Text('Abrir post')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
