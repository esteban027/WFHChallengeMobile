import 'dart:async';
import 'package:WFHchallenge/src/models/network_models.dart';
import 'package:WFHchallenge/src/models/review_page_model.dart';
import 'package:http/http.dart';
import 'network.dart';

class ReviewsRepository {
  final network = Network();

  Future<ReviewsPageModel> fetchReviewsByMovieId(int page, int movieId) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.limit, '100'),
      Parameter.forFilter(FilterType.exact, 'movie', movieId.toString()),
      Parameter.forSort(SortType.ascendant, 'timestamp')
    ];
    return network.fetchReviews(parameters);
  }

  Future<bool> postNewReview(ReviewModel review) {
    return network.postNewReview(review);
  }
}
