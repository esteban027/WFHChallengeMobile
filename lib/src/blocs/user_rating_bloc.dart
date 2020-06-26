import 'package:WFHchallenge/src/Events/post_events.dart';
import 'package:WFHchallenge/src/models/ratings_page_model.dart';
import 'package:http/http.dart';

import '../resources/ratings_page_repository.dart';
import 'package:bloc/bloc.dart';
import '../Events/ratings_events.dart';
import '../Events/post_events.dart';
import '../States/ratings_states.dart';

class UserRatingBloc extends Bloc<BasicRatingEvent, RatingsState> {
  RatingsRepository repository;

  @override
  RatingsState get initialState => PublishingRating();

  @override
  Stream<RatingsState> mapEventToState(BasicRatingEvent event) async* {
    repository = RatingsRepository();
    if (event is PublishNewRating) {
      yield* _mapPublishNewRating(event.rating);
    } else if (event is FetchRatingByUserIdAndMovieId) {
      yield* _mapFetchRatingsByUserIdAndMovieId(event.page, event.userId, event.movieId);
    } else if (event is ReturnToInitialState) {
      yield initialState;
    }
  }

  Stream<RatingsState> _mapPublishNewRating(RatingModel rating) async* {
    try {
      final ratingsPostSuccess = await this.repository.postNewRating(rating);
      if (ratingsPostSuccess) {
        yield RatingPublished();
      } else {
        yield RatingNotPublished();
      }

    } catch (_) {
      yield RatingNotPublished();
    }
  }

  Stream<RatingsState> _mapFetchRatingsByUserIdAndMovieId( int page, int userId,int movieId) async* {
    try {
      final rating = await this.repository.fetchRatingsByUserId(page, userId, movieId);
      yield SingleRatingLoaded(rating);
    } catch (_) {
      yield RatingsNotLoaded();
    }
  }
}