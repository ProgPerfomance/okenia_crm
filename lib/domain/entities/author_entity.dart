class AuthorEntity {
  final String? id;
  final String firstName;
  final String lastName;
  final String? avatarUrl;
  final String subTitle;
  AuthorEntity({
    required this.firstName,
    required this.lastName,
    this.id,
    this.avatarUrl,
    required this.subTitle,
  });

  factory AuthorEntity.fromApi(Map map) {
    return AuthorEntity(
      firstName: map['firstName'],
      lastName: map['lastName'],
      subTitle: map['subTitle'],
      avatarUrl: map['avatarUrl'],
      id: map['_id'],
    );
  }

  String get fullName => '$firstName $lastName';
}
