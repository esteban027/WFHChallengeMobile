import 'package:WFHchallenge/src/Events/post_events.dart';
import 'package:WFHchallenge/src/models/review_page_model.dart';
import '../Events/pages_events.dart';

class BasicReviewEvent extends BasicPageEvent with PostEvent {
  BasicReviewEvent(int page) : super(page);
}

class PublishNewReview extends BasicReviewEvent {
  ReviewModelThin review;
  PublishNewReview(this.review) : super(0);
}

class FetchReviewsByMovieId extends BasicReviewEvent {
  int movieId;
  FetchReviewsByMovieId(this.movieId, [int page = 1]) : super(page);
}

class ReviewBlocReturnToInitialState extends BasicReviewEvent {
  ReviewBlocReturnToInitialState() : super(1);
}
