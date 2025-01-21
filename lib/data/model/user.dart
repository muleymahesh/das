import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id = 0;
  String name;
  String username;
  String mobile;
  String type;
  double commission;
  double collection;
  int supervisor_id;

  User({
    required this.name,
    required this.username,
    required this.mobile,
    required this.type,
    required this.commission,
    required this.collection,
    required this.supervisor_id,
  });
}