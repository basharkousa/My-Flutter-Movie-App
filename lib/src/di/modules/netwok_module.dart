import 'package:mymoviesapp/src/blocs/base.dart';
import 'package:mymoviesapp/src/blocs/home_page_bloc.dart';
import 'package:mymoviesapp/src/data/remote/apis/movie_api.dart';
import 'package:mymoviesapp/src/data/remote/constants/endpoints.dart';
import 'package:mymoviesapp/src/data/remote/dio_client.dart';
import 'package:mymoviesapp/src/data/remote/rest_client.dart';
import 'package:mymoviesapp/src/data/repository.dart';
import 'package:mymoviesapp/src/data/sharedpref/constants/preferences.dart';
import 'package:mymoviesapp/src/data/sharedpref/shared_preference_helper.dart';
import 'package:mymoviesapp/src/di/modules/preference_module.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
class NetworkModule extends PreferenceModule {
  // ignore: non_constant_identifier_names
  final String TAG = "NetworkModule";

  // DI Providers:--------------------------------------------------------------
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();
    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (Options options) async {
            // getting shared pref instance
            var prefs = await SharedPreferences.getInstance();

            // getting token
            var token = prefs.getString(Preferences.auth_token);

            if (token != null) {
              options.headers.putIfAbsent('Authorization', () => token);
            } else {
              print('Auth token is null');
            }
          },
        ),
      );

    return dio;
  }

  /// A singleton dio_client provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  DioClient provideDioClient(Dio dio) => DioClient(dio);

  /// A singleton dio_client provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  RestClient provideRestClient() => RestClient();

  // Api Providers:-------------------------------------------------------------
  // Define all your api providers here
  /// A singleton post_api provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  MovieApi providePostApi(DioClient dioClient, RestClient restClient) =>
      MovieApi(dioClient, restClient);
// Api Providers End:---------------------------------------------------------


  @provide
  BaseBloc homePageBloc(Repository repository) => HomePageBloc(repository);
}
