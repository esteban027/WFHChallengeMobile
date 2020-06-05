import 'dart:async';
import 'network.dart';
import '../models/page_model.dart';

class Repository {
  final netwok = Network();

  Future<PageModel> fetchAllMovies(int page) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString())
    ];
    return netwok.fetchMovies(parameters);
  }

  Future<PageModel> fetchTopMovies(int page) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter.forSort(SortType.descendant, 'rating'),
      Parameter(ParamaterType.limit, '50'),
      Parameter.forFilter(FilterType.greaterThan, 'vote_count', '3')
    ];
    return netwok.fetchMovies(parameters);
  }

  Future<PageModel> fetchMoviesByGenres(int page, List<String> genres) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.limit, '50'),
      Parameter.forSupersetFilter('genres', genres)
    ];
    return netwok.fetchMovies(parameters);
  }
}
