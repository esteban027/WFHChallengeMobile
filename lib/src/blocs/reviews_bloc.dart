import 'package:WFHchallenge/src/Events/reviews_events.dart';
import 'package:WFHchallenge/src/States/reviews_states.dart';
import 'package:WFHchallenge/src/models/review_page_model.dart';
import '../resources/reviews_repository.dart';
import 'package:bloc/bloc.dart';
import '../Events/pages_events.dart';

class LoadReviewsBloc extends Bloc<PageEvent, ReviewsState> {
  ReviewsRepository repository;

  @override
  ReviewsState get initialState => ReviewsLoading();

  @override
  Stream<ReviewsState> mapEventToState(PageEvent event) async* {
    repository = ReviewsRepository();
    if (event is FetchReviewsByMovieId) {
      yield* _mapLoadReviewsByMovieId(event.page,event.movieId);
    } else if (event is PublishNewReview) {
      yield* _mapPublishNewReview(event.review);
    } else if (event is ReturnToInitialState) {
      yield initialState;
    }
  }

  Stream<ReviewsState> _mapLoadReviewsByMovieId(int page, int movieId) async* {
    try {
      final reviewList = await this.repository.fetchReviewsByMovieId(page, movieId);
      yield ReviewsLoaded(reviewList);
    } catch (_) {
      yield ReviewsNotLoaded();
    }
  }

  Stream<ReviewsState> _mapPublishNewReview(ReviewModel review) async* {
    try {
      final reviewPublished = await this.repository.postNewReview(review);
      if (reviewPublished) {
        yield ReviewPublished();
      } else {
        yield ReviewNotPublished();
      }
    } catch (_) {
      yield ReviewNotPublished();
    }
  }
}

