import 'package:flutter/material.dart';
import 'package:mymoviesapp/src/blocs/home_page_bloc.dart';
import 'package:mymoviesapp/src/data/models/movies/movies_response.dart';
import 'package:mymoviesapp/src/ui/screens/home/home_page.dart';
import 'package:mymoviesapp/src/ui/screens/movie_details/movie_details_page.dart';

class Routes {
  Routes._();

  //static variables
//  static const String splash = '/splash';
//  static const String login = '/login';
//  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    //  HomePage.home: (BuildContext context) => HomePage(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MovieDetailsPage.movieDetails:
        final Movie movie = settings.arguments;
        return MaterialPageRoute(builder: (_) {
          return MovieDetailsPage(movie);
        });
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
