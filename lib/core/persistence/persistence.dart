abstract interface class Persistence {
  Future<void> writeString(String key, String value);

  String? readString(String key);

  Future<void> writeBool(String key, bool value);

  bool? readBool(String key);

  Future<void> writeInt(String key, int value);

  int? readInt(String key);

  Future<void> writeJson(String key, Map<String, dynamic> value);

  Map<String, dynamic>? readJson(String key);

  Future<void> remove(String key);
}
