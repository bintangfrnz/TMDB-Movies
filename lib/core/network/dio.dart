import 'package:dio/dio.dart';

import '../constants/constants.dart';
import 'interceptor/authorization_interceptor.dart';

class MyDio extends Interceptor {
  final AuthorizationInterceptor authorizationInterceptor;
  MyDio(this.authorizationInterceptor);

  Dio get dio {
    return Dio(BaseOptions(baseUrl: baseUrl))
      ..interceptors.addAll([
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
        authorizationInterceptor,
      ]);
  }
}
