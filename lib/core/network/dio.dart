import 'package:dio/dio.dart';
import 'package:tmdb_movies/core/constants/constants.dart';
import 'package:tmdb_movies/core/network/interceptor/authorization_interceptor.dart';

class MyDio extends Interceptor {
  final AuthorizationInterceptor authorizationInterceptor;
  MyDio(this.authorizationInterceptor);

  Dio get dio {
    return Dio(BaseOptions(baseUrl: baseUrl))
      ..interceptors.add(authorizationInterceptor);
  }
}
