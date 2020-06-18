import 'package:WFHchallenge/src/Events/post_events.dart';

import '../Events/pages_events.dart';
import '../models/ratings_page_model.dart';

class FetchRatingsByMovieId extends BasicPageEvent {
  int movieId;
  FetchRatingsByMovieId(this.movieId, [int page = 1] ) : super(page);
}

class PublishNewRating extends PostEvent {
  RatingModel rating;
  PublishNewRating(this.rating);
}
