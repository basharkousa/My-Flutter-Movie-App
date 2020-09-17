import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymoviesapp/src/data/models/movies/movies_response.dart';
import 'package:mymoviesapp/src/data/remote/constants/endpoints.dart';

class MovieDetailsPage extends StatefulWidget {
  static const String movieDetails = "/movie_deatails";
  final Movie _movie;

  MovieDetailsPage(this._movie);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState(movie: _movie);
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movie movie;

  _MovieDetailsPageState({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Hero(
            tag: Endpoints.baseImageUrl+movie.poster_path,
            child: Image.network(Endpoints.baseImageUrl+movie.poster_path),
          ),
        ),
      ),
    );
  }
}
