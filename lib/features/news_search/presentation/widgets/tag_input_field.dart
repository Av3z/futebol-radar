import 'package:flutter/material.dart';

import '../controllers/news_search_controller.dart';

class TagInputField extends StatelessWidget {
  const TagInputField(
      {super.key,
      required this.controller,
      required this.field,
      required this.values,
      required this.label,
      required this.hint,
      required this.icon,
      required this.onChanged,
      this.suggestions = const []});
  final NewsSearchController controller;
  final TextEditingController field;
  final List<String> values;
  final String label;
  final String hint;
  final IconData icon;
  final VoidCallback onChanged;
  final List<String> suggestions;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: field,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) {
              controller.add(field, values);
              onChanged();
            },
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              prefixIcon: Icon(icon),
              suffixIcon: IconButton(
                onPressed: () {
                  controller.add(field, values);
                  onChanged();
                },
                icon: const Icon(Icons.add),
                tooltip: 'Adicionar',
              ),
              border: const OutlineInputBorder(),
            ),
          ),
          if (suggestions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Wrap(
                spacing: 6,
                children: [
                  for (final suggestion in suggestions)
                    if (!values.any((value) => value.toLowerCase() == suggestion.toLowerCase()))
                      ActionChip(
                        label: Text(suggestion),
                        onPressed: () {
                          values.add(suggestion);
                          onChanged();
                        },
                      ),
                ],
              ),
            ),
          if (values.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  for (final value in List<String>.from(values))
                    InputChip(
                      label: Text(value),
                      onDeleted: () {
                        values.remove(value);
                        onChanged();
                      },
                    ),
                ],
              ),
            ),
        ],
      );
}
