import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iism_2025/services/auth.dart';
import 'package:path_provider/path_provider.dart';

late final Dio dio;

late final PersistCookieJar cookieJar;

Future<void> configureAPIService() async {
  dio = Dio(
    BaseOptions(
      baseUrl: dotenv.get(
        "API_URL",
        fallback: "https://iism25.sports.iith.ac.in",
      ),
    ),
  );

  final cachePath = (await getApplicationCacheDirectory()).path;
  cookieJar = PersistCookieJar(storage: FileStorage(cachePath));

  dio.interceptors.add(CookieManager(cookieJar));

  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          auth.on401Error();
          return handler.resolve(
            Response(requestOptions: e.requestOptions, statusCode: 401),
          );
        }
        return handler.next(e);
      },
    ),
  );
}
