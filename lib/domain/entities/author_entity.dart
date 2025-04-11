
class AuthorEntity {
  final String? id;
  final String firstName;
  final String lastName;
  final String? avatar;

  AuthorEntity({
    required this.firstName,
    required this.lastName,
    this.id,
    this.avatar,
  });
}