
import '../data/db/objectbox.dart';
import '../data/model/user.dart';

class StorageUtils {
  static Future<User> getUser() async {
    ObjectBox db  = await ObjectBox.create();
    final box = db.store.box<User>();
    User user = box.getAll().first;
    db.store.close();
    return user;
  }
}