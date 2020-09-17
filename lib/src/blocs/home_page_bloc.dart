import 'package:inject/inject.dart';
import 'package:mymoviesapp/src/blocs/base.dart';
import 'package:mymoviesapp/src/data/models/api_response.dart';
import 'package:mymoviesapp/src/utils/dio/dio_error_util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mymoviesapp/src/data/repository.dart';
import 'package:mymoviesapp/src/data/models/movies/movies_response.dart';


class HomePageBloc extends BaseBloc {

  final fetcher = PublishSubject<ApiResponse<MoviesResponse>>();
  final Repository _repository;

  @provide
  HomePageBloc(this._repository);

  Stream<ApiResponse<MoviesResponse>> get moviesLiveData => fetcher.stream;

  fetchMovieList() async {
    fetcher.sink.add(ApiResponse.loading('Fetching Popular Movies'));
    try {
      MoviesResponse movies = await _repository.getPopularMovies();
      fetcher.sink.add(ApiResponse.completed(movies));
    } catch (error, stacktrace) {
      fetcher.sink.add(ApiResponse.error(DioErrorUtil.handleError(error)));
      print(stacktrace);
    }
  }


  @override
  dispose() {
    fetcher.close();
  }


}

//final homePageBloc = HomePageBloc();