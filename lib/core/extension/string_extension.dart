extension StringExtension on String? {
  String get capitalize {
    if (this == null || this!.isEmpty) return 'N/A';
    return this!
        .split(' ')
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }
}
