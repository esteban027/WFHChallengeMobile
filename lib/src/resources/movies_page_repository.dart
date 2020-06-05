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

  Future<MoviesPageModel> fetchTopMovies(int page) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter.forSort(SortType.descendant, 'rating'),
      Parameter(ParamaterType.limit, '50'),
      Parameter.forFilter(FilterType.greaterThan, 'vote_count', '3')
    ];
    return netwok.fetchMovies(parameters);
  }

  Future<MoviesPageModel> fetchMoviesByGenres(int page, List<String> genres) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.limit, '50'),
      Parameter.forSupersetFilter('genres', genres)
    ];
    return netwok.fetchMovies(parameters);
  }

  Future<MoviesPageModel> fetchTopMoviesByGenres(
      int page, List<String> genres) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.limit, '10'),
      Parameter.forSort(SortType.descendant, 'rating'),
      Parameter.forSupersetFilter('genres', genres)
    ];
    return netwok.fetchMovies(parameters);
  }

  Future<MoviesPageModel> fetchMoviesByTitle(int page, String title) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.limit, '50'),
      Parameter.forFilter(FilterType.partial, 'title', title)
    ];
    return netwok.fetchMovies(parameters);
  }

  Future<MoviesPageModel> fetchTopMoviesByReleaseDate(int page) {
    var now = new DateTime.now();
    var year = now.year;
    var yearStart = new DateTime.utc(year, 1, 1);
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.limit, '50'),
      Parameter.forSort(SortType.descendant, 'rating'),
      Parameter.forFilter(
          FilterType.greaterOrEqual, 'release_date', yearStart.toString())
    ];
    return netwok.fetchMovies(parameters);
  }
}
