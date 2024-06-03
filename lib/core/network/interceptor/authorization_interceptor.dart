import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationInterceptor extends Interceptor {
  final SharedPreferences pref;
  AuthorizationInterceptor(this.pref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = pref.getString('access_token') ??
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMDAwZTQwMzVkOTcxMjg2YWMzODQyZGQ2OTdkMDU5ZiIsInN1YiI6IjY2NWFjNWZjMjYzNDg0MjE3NDUyZGU5YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hCfN6v3HOuEJVgezoBzD8MBhuX_FD3hsTm9WiOxe2cg';
    if (token != null) {
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    super.onRequest(options, handler);
  }
}
