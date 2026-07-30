import 'package:flutter/material.dart';

import '../../../engagements/presentation/pages/engagements_tab.dart';
import '../widgets/app_header.dart';
import 'news_search_tab.dart';

class NewsSearchPage extends StatelessWidget {
  const NewsSearchPage({super.key});

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              const AppHeader(),
              Material(
                color: Theme.of(context).colorScheme.surface,
                child: const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.article_outlined), text: 'Notícias'),
                    Tab(
                        icon: Icon(Icons.insights_outlined),
                        text: 'Engajamentos'),
                  ],
                ),
              ),
              const Expanded(
                  child: TabBarView(
                      children: [NewsSearchTab(), EngagementsTab()])),
            ],
          ),
        ),
      );
}
