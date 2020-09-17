import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inject/inject.dart';
import 'package:mymoviesapp/src/blocs/home_page_bloc.dart';
import 'package:mymoviesapp/src/constants/app_theme.dart';
import 'package:mymoviesapp/src/constants/routes.dart';
import 'package:mymoviesapp/src/data/models/movies/movies_response.dart';
import 'package:mymoviesapp/src/ui/screens/home/home_page.dart';
import 'package:mymoviesapp/src/ui/screens/movie_details/movie_details_page.dart';
import 'package:mymoviesapp/src/utils/device/size_config.dart';
import 'package:mymoviesapp/src/utils/local/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@provide
class App extends StatelessWidget {
  final HomePageBloc homePageBloc;


   App(this.homePageBloc) : super();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
      Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowMaterialGrid: false,
        title: "My Movies App",
        theme: AppTheme.lightTheme,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', ''),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        initialRoute: HomePage.home,
        onGenerateRoute:Routes.generateRoute,
        routes: {
          HomePage.home: (BuildContext context) => HomePage(homePageBloc),
        });
  }
}
