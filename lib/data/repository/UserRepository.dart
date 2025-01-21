import 'package:dio/dio.dart';

import '../remote/UserService.dart';

class UserRepository {
  Future<bool> login(String username, String password) async {


    final dio = Dio();
    final userService = UserService(dio);

    return await userService.login(username, password); // Simulate a login process (replace with your actual login logic)
    await Future.delayed(const Duration(seconds: 2));
    return username == 'test' && password == 'test';
  }
}