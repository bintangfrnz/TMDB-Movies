import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationInterceptor extends Interceptor {
  final SharedPreferences pref;
  AuthorizationInterceptor(this.pref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = pref.getString('access_token');
    if (token != null) {
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    super.onRequest(options, handler);
  }
}
