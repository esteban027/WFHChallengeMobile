import 'package:WFHchallenge/src/Events/post_events.dart';
import 'package:WFHchallenge/src/models/ratings_page_model.dart';
import 'package:http/http.dart';

import '../resources/ratings_page_repository.dart';
import 'package:bloc/bloc.dart';
import '../Events/ratings_events.dart';
import '../Events/post_events.dart';
import '../States/ratings_states.dart';

class PostRatingBloc extends Bloc<PostEvent, RatingsState> {
  RatingsRepository repository;

  @override
  RatingsState get initialState => PublishingRating();

  @override
  Stream<RatingsState> mapEventToState(PostEvent event) async* {
    repository = RatingsRepository();
    if (event is PublishNewRating) {
      yield* _mapPublishNewRating(event.rating);
    } else if (event is ReturnToInitialState) {
      yield initialState;
    }
  }

  Stream<RatingsState> _mapPublishNewRating(RatingModel rating) async* {
    try {
      final ratingsPostResponse = await this.repository.postNewRating(rating);
      if (ratingsPostResponse == )
      yield RatingsLoaded(ratingsPostResponse);
    } catch (_) {
      yield RatingsNotLoaded();
    }
  }
}