import 'package:WFHchallenge/src/Events/post_events.dart';

import '../Events/pages_events.dart';
import '../models/ratings_page_model.dart';

class FetchRatingsByMovieId extends BasicPageEvent {
  int movieId;
  FetchRatingsByMovieId(this.movieId, [int page = 1] ) : super(page);
}

class BasicRatingEvent extends BasicPageEvent with PostEvent {
  BasicRatingEvent(int page) : super(page);
}

class PublishNewRating extends BasicRatingEvent {
  RatingModel rating;
  PublishNewRating(this.rating) : super(0);
}

class FetchRatingByUserIdAndMovieId extends BasicRatingEvent {
    int userId;
    int movieId;
    FetchRatingByUserIdAndMovieId(this.userId, this.movieId, [int page = 1] ) : super(page);
}
