import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:mymoviesapp/src/blocs/home_page_bloc.dart';
import 'package:mymoviesapp/src/constants/colors.dart';
import 'package:mymoviesapp/src/constants/strings.dart';
import 'package:mymoviesapp/src/data/models/api_response.dart';
import 'package:mymoviesapp/src/data/models/movies/movies_response.dart';
import 'package:mymoviesapp/src/data/remote/constants/endpoints.dart';
import 'package:mymoviesapp/src/ui/screens/home/SecondPage.dart';
import 'package:mymoviesapp/src/ui/screens/movie_details/movie_details_page.dart';
import 'package:mymoviesapp/src/utils/device/device_utils.dart';
import 'package:mymoviesapp/src/utils/device/size_config.dart';
import 'package:mymoviesapp/src/utils/local/app_localization.dart';

class HomePage extends StatefulWidget {
  static const String home = '/';

  final HomePageBloc homePageBloc;

  @provide
  HomePage(this.homePageBloc);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.homePageBloc.fetchMovieList();
    super.initState();
  }

  @override
  void dispose() {
    widget.homePageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Text(DeviceUtils.getAppString(context, Strings.appName)),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: StreamBuilder<ApiResponse<MoviesResponse>>(
            stream: widget.homePageBloc.moviesLiveData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return LoadingWidget(loadingMessage: snapshot.data.message);
                    break;
                  case Status.COMPLETED:
                    return MovieList(
                      movieList: snapshot.data.data.results,
                      onClick: (movie){
                        _moveToMovieDetailsPage(movie);
                      },
                    );
                    break;
                  case Status.ERROR:
                    return Error(
                      errorMessage: snapshot.data.message,
                      onRetryPressed: () =>
                          widget.homePageBloc.fetchMovieList(),
                    );
                    break;
                }
              }
              return LoadingWidget(loadingMessage: "Loading..");
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    widget.homePageBloc.fetchMovieList();
  }

  _moveToMovieDetailsPage(Movie movie) {
    Navigator.pushNamed(context, MovieDetailsPage.movieDetails,
        arguments: movie);
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.black87,
            child: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final String loadingMessage;

  const LoadingWidget({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        ],
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movieList;
  final Function(Movie movie) onClick;

  const MovieList({Key key, this.movieList, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movieList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5 / 1.8,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap:()=>onClick(movieList[index]),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Card(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Hero(
                    tag: '${Endpoints.baseImageUrl}${movieList[index].poster_path}',
                    child: Image.network(
                      '${Endpoints.baseImageUrl}${movieList[index].poster_path}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
