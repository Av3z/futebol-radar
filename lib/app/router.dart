import 'package:go_router/go_router.dart';

import '../features/news_search/presentation/pages/news_search_page.dart';

final GoRouter router = GoRouter(
    routes: [GoRoute(path: '/', builder: (_, __) => const NewsSearchPage())]);
