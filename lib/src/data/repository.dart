import 'dart:async';

import 'package:inject/inject.dart';
import 'package:mymoviesapp/src/data/loacal/datasources/movie_datasource.dart';
import 'package:mymoviesapp/src/data/models/movies/movies_response.dart';
import 'package:mymoviesapp/src/data/remote/apis/movie_api.dart';
import 'package:mymoviesapp/src/data/sharedpref/shared_preference_helper.dart';


class Repository {
  // data source object
  final MovieDataSource _movieDataSource;

  // api objects
  final MovieApi _movieApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  @provide
  Repository(this._movieApi, this._sharedPrefsHelper, this._movieDataSource);

  // Movies: ---------------------------------------------------------------------

  Future<MoviesResponse> getPopularMovies() => _movieApi.getPopular();


//  Future<List<Post>> findPostById(int id) {
//    //creating filter
//    List<Filter> filters = List();
//
//    //check to see if dataLogsType is not null
//    if (id != null) {
//      Filter dataLogTypeFilter = Filter.equal(DBConstants.FIELD_ID, id);
//      filters.add(dataLogTypeFilter);
//    }
//
//    //making db call
//    return _postDataSource
//        .getAllSortedByFilter(filters: filters)
//        .then((posts) => posts)
//        .catchError((error) => throw error);
//  }
//
  Future<int> insert(Movie post) => _movieDataSource
      .insert(post)
      .then((id) => id)
      .catchError((error) => throw error);
//
//  Future<int> update(Post post) => _postDataSource
//      .update(post)
//      .then((id) => id)
//      .catchError((error) => throw error);
//
//  Future<int> delete(Post post) => _postDataSource
//      .update(post)
//      .then((id) => id)
//      .catchError((error) => throw error);

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  Future<bool> get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  Future<String> get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
