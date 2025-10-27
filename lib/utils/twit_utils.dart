List<String> getHashtags(String content) {
  final hashtags = <String>[];
  final words = content.split(' ');

  for (final word in words) {
    if (word.startsWith('#')) {
      hashtags.add(word);
    }
  }
  return hashtags;
}

String? getLink(String content) {
  final words = content.split(' ');

  for (final word in words) {
    if (word.startsWith('https://') ||
        word.startsWith('http://') ||
        word.startsWith('www.')) {
      return word;
    }
  }
  return null;
}
