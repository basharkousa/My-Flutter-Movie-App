class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://api.themoviedb.org/3/movie";
  static const apiKey = '?api_key=4c62715312a67408440a50eede0d28cc';
  static const baseImageUrl = "https://image.tmdb.org/t/p/w342";

  // receiveTimeout
  static const int receiveTimeout = 5000;

  // connectTimeout
  static const int connectionTimeout = 3000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";

  static const String getPopular = baseUrl+"/popular"+apiKey;
}