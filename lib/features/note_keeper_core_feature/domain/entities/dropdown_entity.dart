class DropDownEntity {
  final String _key;
  final String _value;

  DropDownEntity({required String key, required String value})
      : _key = key,
        _value = value;

  String get value => _value;

  String get key => _key;
}
