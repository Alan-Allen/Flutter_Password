class MFList {
  int id;
  String key;

  MFList(this.id, this.key);

  static MFList fromMap(Map map) {
    return MFList(
      map['id'] as int,
      map['key'] as String
    );
  }
}