import 'package:flutter/material.dart';

class NewsSearchController {
  final team = TextEditingController();
  final profile = TextEditingController();
  final source = TextEditingController();
  final keyword = TextEditingController();
  final teams = <String>[];
  final profiles = <String>[];
  final sources = <String>[];
  final keywords = <String>[];

  void dispose() {
    team.dispose();
    profile.dispose();
    source.dispose();
    keyword.dispose();
  }

  void add(TextEditingController field, List<String> target) {
    final value = field.text.trim();
    if (value.isNotEmpty &&
        !target.any((item) => item.toLowerCase() == value.toLowerCase())) {
      target.add(value);
    }
    field.clear();
  }
}
