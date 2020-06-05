import '../resources/genres_page_repository.dart';
import 'package:bloc/bloc.dart';
import '../Events/genres_events.dart';
import '../Events/pages_events.dart';
import '../States/genres_states.dart';

class LoadGenresBloc extends Bloc<PageEvent, GenresState> {
  GenresPageRepository repository;

  @override
  GenresState get initialState => GenresLoading();

  @override
  Stream<GenresState> mapEventToState(PageEvent event) async* {
    repository = GenresPageRepository();
    if (event is FetchAllGenres) {
      yield* _mapLoadAllGenres(event.page);
    } else if (event is ReturnToInitialState) {
      yield initialState;
    }
  }

  Stream<GenresState> _mapLoadAllGenres(int page) async* {
    try {
      final genresPage = await this.repository.fetchAllGenres(page);
      yield GenresLoaded(genresPage);
    } catch (_) {
      yield GenresNotLoaded();
    }
  }
}
