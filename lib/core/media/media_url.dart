const _apiBaseUrl = String.fromEnvironment('API_BASE_URL',
    defaultValue: 'http://localhost:8000');

String? proxiedImageUrl(String? value) {
  final imageUrl = value?.trim();
  if (imageUrl == null || imageUrl.isEmpty) return null;

  final baseUrl = _apiBaseUrl.replaceFirst(RegExp(r'/$'), '');
  if (imageUrl.startsWith('$baseUrl/api/v1/media/image')) return imageUrl;
  return '$baseUrl/api/v1/media/image?url=${Uri.encodeComponent(imageUrl)}';
}
