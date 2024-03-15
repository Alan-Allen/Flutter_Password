class UserList {
  int id;
  String name;
  String user;
  String password;

  UserList(this.id, this.name, this.user, this.password);

  static UserList fromMap(Map map) {
    return UserList(
      map['id'] as int,
      map['name'] as String,
      map['user'] as String,
      map['password'] as String,
    );
  }
}