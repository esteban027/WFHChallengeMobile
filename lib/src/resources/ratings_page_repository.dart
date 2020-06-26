import 'dart:async';
import 'package:http/http.dart';

import 'network.dart';
import '../models/ratings_page_model.dart';
import '../models/network_models.dart';

class RatingsRepository {
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

  Future<RatingModel> fetchRatingsByUserId(int page, int userId,int movieId) {
    return netwok.fetchUserRatingByMovie(movieId.toString() + '_' + userId.toString());
  }

  Future<bool> postNewRating(RatingModel rating) {
    return netwok.postNewRating(rating);
  }
}
