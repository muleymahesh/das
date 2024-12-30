import 'package:objectbox/objectbox.dart';

@Entity()
class Deposition {
  @Id()
  int id = 0;

  double amount;
  DateTime date;
  String raisedBy;
  String assignedTo;

  Deposition({
    required this.amount,
    required this.date,
    required this.raisedBy,
    required this.assignedTo,
  });
}