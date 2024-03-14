import 'package:flutter/cupertino.dart';

class KeyList {
  int id;
  String key;

  KeyList(this.id, this.key);

  static KeyList fromMap(Map map) {
    return KeyList(
      map['id'] as int,
      map['key'] as String,
    );
  }
}