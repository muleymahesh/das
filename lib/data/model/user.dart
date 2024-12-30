import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id = 0;

  String name;
  String username;
  String mobile;
  String type;

  User({
    required this.name,
    required this.username,
    required this.mobile,
    required this.type,
  });
}