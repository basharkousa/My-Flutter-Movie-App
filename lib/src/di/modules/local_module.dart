import 'dart:async';

import 'package:mymoviesapp/src/blocs/base.dart';
import 'package:mymoviesapp/src/blocs/home_page_bloc.dart';
import 'package:mymoviesapp/src/data/loacal/constants/db_constants.dart';
import 'package:mymoviesapp/src/data/loacal/datasources/movie_datasource.dart';
import 'package:mymoviesapp/src/data/repository.dart';
import 'package:mymoviesapp/src/data/remote/apis/movie_api.dart';
import 'package:mymoviesapp/src/data/sharedpref/shared_preference_helper.dart';
import 'package:inject/inject.dart';
import 'package:path/path.dart';
import 'package:mymoviesapp/src/di/modules/netwok_module.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:xxtea/xxtea.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mymoviesapp/src/utils/encryption/xxtea.dart';


@module
class LocalModule extends NetworkModule {
  // DI variables:--------------------------------------------------------------
  Future<Database> database;

  // constructor
  // Note: Do not change the order in which providers are called, it might cause
  // some issues
  LocalModule() {
    database = provideDatabase();
  }

  // DI Providers:--------------------------------------------------------------
  /// A singleton database provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  @asynchronous
  Future<Database> provideDatabase() async {
    // Key for encryption
    var encryptionKey = "";

    // Get a platform-specific directory where persistent app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();

    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = join(appDocumentDir.path, DBConstants.DB_NAME);

    // Check to see if encryption is set, then provide codec
    // else init normal db with path
    var database;
    if (encryptionKey.isNotEmpty) {
      // Initialize the encryption codec with a user password
      var codec = getXXTeaCodec(password: encryptionKey);
      database = await databaseFactoryIo.openDatabase(dbPath, codec: codec);
    } else {
      database = await databaseFactoryIo.openDatabase(dbPath);
    }

    // Return database instance
    return database;
  }

  // DataSources:---------------------------------------------------------------
  // Define all your data sources here
  /// A singleton post dataSource provider.
  ///
  /// Calling it multiple times will return the same instance.

  @provide
  @singleton
  MovieDataSource provideMovieDataSource() => MovieDataSource(database);

  // DataSources End:-----------------------------------------------------------

  /// A singleton repository provider.
  ///
  /// Calling it multiple times will return the same instance.


  @provide
  @singleton
  Repository provideRepository(
    MovieApi movieApi,
    SharedPreferenceHelper preferenceHelper,
    MovieDataSource postDataSource,
  ) => Repository(movieApi, preferenceHelper, postDataSource);

  @provide
  @singleton
  BaseBloc provideHomeBloc(Repository repository) => HomePageBloc(repository);
}
