import 'dart:async';

import 'package:mymoviesapp/src/data/models/movies/movies_response.dart';
import 'package:mymoviesapp/src/data/models/state.dart';
import 'package:mymoviesapp/src/data/remote/constants/endpoints.dart';
import 'package:mymoviesapp/src/data/remote/dio_client.dart';
import 'package:mymoviesapp/src/data/remote/rest_client.dart';

class MovieApi{

  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  MovieApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<MoviesResponse> getPopular() async {
      final res = await _dioClient.get(Endpoints.getPopular);
      return MoviesResponse.fromJson(res);
  }

}

