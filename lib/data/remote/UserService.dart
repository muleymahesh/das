import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'UserService.g.dart';

@RestApi(baseUrl: "https://api.example.com")
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  @POST("/login")
  Future<bool> login(@Field("username") String username, @Field("password") String password);
}