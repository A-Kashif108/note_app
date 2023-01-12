class User {
  final String? username;
  final String? password;

  const User({
    this.username,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

  @override
  String toString() {
    return 'User{username: $username, password: $password}';
  }
}
