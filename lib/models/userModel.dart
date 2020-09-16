class UserModel {
  final String username;
  final String password;

  UserModel({this.username, this.password})
      : assert(username != null),
        assert(password != null);

  factory UserModel.fromJson(Map<String, String> map) => UserModel(
      username: map["username"] ?? "", password: map["password"] ?? "");

  Map<String, String> toJson() =>
      {"username": this.username, "password": this.password};
}
