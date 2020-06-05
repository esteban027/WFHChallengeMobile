import 'dart:async';
import 'network.dart';
import '../models/ratings_page_model.dart';
import '../models/network_models.dart';

class RatingsPageRepository {
  final netwok = Network();

  Future<RatingsPageModel> fetchRatingsByMovieId(int page, int movieId) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.limit, '50'),
      Parameter.forFilter(FilterType.exact, 'movie', movieId.toString()),
      Parameter.forSort(SortType.ascendant, 'timestamp')
    ];
    return netwok.fetchRatings(parameters);
  }
}
