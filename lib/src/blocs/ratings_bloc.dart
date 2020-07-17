import '../resources/ratings_page_repository.dart';
import 'package:bloc/bloc.dart';
import '../Events/ratings_events.dart';
import '../Events/pages_events.dart';
import '../States/ratings_states.dart';

class LoadRatingsBloc extends Bloc<PageEvent, RatingsState> {
  RatingsRepository repository;

  @override
  RatingsState get initialState => RatingsLoading();

  @override
  Stream<RatingsState> mapEventToState(PageEvent event) async* {
    repository = RatingsRepository();
    if (event is FetchRatingsByMovieId) {
      yield* _mapLoadRatingsByMovieId(event.movieId);
    } else if (event is ReturnToInitialState) {
      yield initialState;
    }
  }

  Stream<RatingsState> _mapLoadRatingsByMovieId(int movieId) async* {
    try {
      final ratingList = await this.repository.fetchRatingsByMovieId(movieId);
      print(ratingList);
      yield GraphicRatingsLoaded(ratingList);
    } catch (_) {
      yield RatingsNotLoaded();
    }
  }
}