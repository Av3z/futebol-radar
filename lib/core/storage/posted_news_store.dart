import 'package:shared_preferences/shared_preferences.dart';

class PostedNewsStore {
  static const _key = 'posted_news_urls';

  Future<Set<String>> getPostedUrls() async {
    final preferences = await SharedPreferences.getInstance();
    return (preferences.getStringList(_key) ?? <String>[]).toSet();
  }

  Future<bool> toggle(String url) async {
    final preferences = await SharedPreferences.getInstance();
    final urls = (preferences.getStringList(_key) ?? <String>[]).toSet();
    final isPosted = !urls.contains(url);
    if (isPosted) {
      urls.add(url);
    } else {
      urls.remove(url);
    }
    await preferences.setStringList(_key, urls.toList());
    return isPosted;
  }
}
