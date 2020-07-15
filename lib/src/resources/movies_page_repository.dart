import 'dart:async';
import 'network.dart';
import '../models/page_model.dart';
import '../models/network_models.dart';

class MoviesPageRepository {
  final netwok = Network();

  Future<MoviesPageModel> fetchAllMovies(int page) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString())
    ];
    return netwok.fetchMovies(parameters);
  }

  Future<MoviesPageModel> fetchTopMovies(int page, int userId) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter.forSort(SortType.descendant, 'rating'),
      Parameter(ParamaterType.limit, '100'),
      Parameter.forFilter(FilterType.greaterThan, 'vote_count', '10')
    ];

    List<Parameter> headers = [
      Parameter(ParamaterType.userId,userId.toString()),
    ];

    return netwok.fetchMovies(headers, parameters);
  }

  Future<MoviesPageModel> fetchMoviesByGenres(int page, List<String> genres, int userId) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.userId,userId.toString()),
      Parameter(ParamaterType.limit, '100'),
      Parameter.forListFilter('genres', genres)
    ];

    List<Parameter> headers = [
      Parameter(ParamaterType.userId,userId.toString()),
    ];

    return netwok.fetchMovies(headers,parameters);
  }

  Future<MoviesPageModel> fetchTopMoviesByGenres(
      int page, List<String> genres, int userId) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.userId,userId.toString()),
      Parameter(ParamaterType.limit, '100'),
      Parameter.forSort(SortType.descendant, 'rating'),
      Parameter.forListFilter('genres', genres)
    ];

    List<Parameter> headers = [
      Parameter(ParamaterType.userId,userId.toString()),
    ];

    return netwok.fetchMovies(headers,parameters);
  }

  Future<MoviesPageModel> fetchMoviesByTitle(int page, String title, int userId) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.userId,userId.toString()),
      Parameter(ParamaterType.limit, '100'),
      Parameter.forFilter(FilterType.partial, 'title', title)
    ];

    List<Parameter> headers = [
      Parameter(ParamaterType.userId,userId.toString()),
    ];

    return netwok.fetchMovies(headers,parameters);
  }

  Future<MoviesPageModel> fetchTopMoviesByReleaseDate(int page, userId) {
    var now = new DateTime.now();
    var year = now.year;
    var yearStart = new DateTime.utc(year, 1, 1);
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.userId,userId.toString()),
      Parameter(ParamaterType.limit, '100'),
      Parameter.forSort(SortType.descendant, 'rating'),
      Parameter.forFilter(
          FilterType.greaterOrEqual, 'release_date', yearStart.toString())
    ];

    List<Parameter> headers = [
      Parameter(ParamaterType.userId,userId.toString()),
    ];

    return netwok.fetchMovies(headers,parameters);
  }

  Future<MoviesPageModel>  fetchMoviesRecommendationTo(int userId, int page ) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.userId,userId.toString()),
    ];

    List<Parameter> headers = [
      Parameter(ParamaterType.userId,userId.toString()),
    ];

    var fetchFromUser = true ;
    return netwok.fetchRecommendations(userId,fetchFromUser,headers,parameters);
  }

  Future<MoviesPageModel> fetchMoviesRecommendationFrom(int movieId, int page, int userId ) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.userId,userId.toString()),
    ];

    List<Parameter> headers = [
      Parameter(ParamaterType.userId,userId.toString()),
    ];

    var fetchFromUser = false;
    return netwok.fetchRecommendations(movieId,fetchFromUser,headers,parameters);
  }
}
