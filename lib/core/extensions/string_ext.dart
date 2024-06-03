extension StringNullExt on String? {
  String or([String value = '']) => this ?? value;
}
