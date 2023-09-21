class User {
  final String uid;
  final String fullName;
  final String email;
  final String password;

  User(this.fullName, this.email, this.password, {required this.uid});
}
