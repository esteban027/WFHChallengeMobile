import '../resources/ratings_page_repository.dart';
import 'package:bloc/bloc.dart';
import '../Events/ratings_events.dart';
import '../Events/pages_events.dart';
import '../States/ratings_states.dart';

class LoadRatingsBloc extends Bloc<PageEvent, RatingsState> {
  RatingsPageRepository repository;

  @override
  RatingsState get initialState => RatingsLoading();

  @override
  Stream<RatingsState> mapEventToState(PageEvent event) async* {
    repository = RatingsPageRepository();
    if (event is FetchRatingsByMovieId) {
      yield* _mapLoadRatingsByMovieId(event.page, event.movieId);
    } else if (event is ReturnToInitialState) {
      yield initialState;
    }
  }

  Stream<RatingsState> _mapLoadRatingsByMovieId(int page, int movieId) async* {
    try {
      final ratingsPage = await this.repository.fetchRatingsByMovieId(page, movieId);
      yield RatingsLoaded(ratingsPage);
    } catch (_) {
      yield RatingsNotLoaded();
    }
  }
}