import 'package:flutter/material.dart';

class SocialPostDate extends StatelessWidget {
  const SocialPostDate({super.key, required this.publishedAt});

  final DateTime? publishedAt;

  @override
  Widget build(BuildContext context) {
    if (publishedAt == null) {
      return Text('Data não confirmada',
          style: Theme.of(context).textTheme.bodySmall);
    }
    final date = publishedAt!.toLocal();
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return Text('$day/$month/${date.year} às $hour:$minute',
        style: Theme.of(context).textTheme.bodySmall);
  }
}
