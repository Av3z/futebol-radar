import 'package:flutter/material.dart';

import '../../domain/entities/team_news.dart';
import 'news_card.dart';

class DynamicTeamTabs extends StatelessWidget {
  const DynamicTeamTabs({super.key, required this.teams, required this.onPostStatusChanged});
  final List<TeamNews> teams;
  final ValueChanged<String> onPostStatusChanged;

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: teams.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(isScrollable: true, tabs: [for (final team in teams) Tab(text: '${team.team} (${team.articles.length})')]),
            const SizedBox(height: 18),
            SizedBox(
              height: 540,
              child: TabBarView(
                children: [
                  for (final team in teams)
                    team.articles.isEmpty
                        ? const Center(child: Text('Nenhuma notícia neste time.'))
                        : ListView.separated(
                            itemCount: team.articles.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (_, index) => NewsCard(article: team.articles[index], onPostStatusChanged: onPostStatusChanged),
                          ),
                ],
              ),
            ),
          ],
        ),
      );
}
