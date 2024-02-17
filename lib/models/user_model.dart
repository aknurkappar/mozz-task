class User {
  final int id;
  final String name;
  final String surname;
  final bool online;

  const User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.online});


  static User fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    surname: json['surname'],
    online: json['online'],
  );
}
