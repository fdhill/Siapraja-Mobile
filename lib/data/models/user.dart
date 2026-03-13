class User {
  int id;
  String username;
  String name;

  User({required this.id, required this.name, required this.username});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['payload']['id'],
      name: json['payload']['name'],
      username: json['payload']['username'],
    );
  }
}