import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) => Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.fromLTRB(20, 44, 20, 38),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.sports_soccer, size: 44, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Futebol Radar', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text('Encontre as notícias mais relevantes por time, fonte e assunto.', style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
                const Chip(avatar: Icon(Icons.circle, size: 10, color: Colors.green), label: Text('API online')),
              ],
            ),
          ),
        ),
      );
}
