import '../resources/sections_page_repository.dart';
import 'package:bloc/bloc.dart';
import '../Events/sections_events.dart';
import '../Events/pages_events.dart';
import '../States/sections_states.dart';

class LoadSectionsBloc extends Bloc<PageEvent, SectionsState> {
  GenresPageRepository repository;

  @override
  SectionsState get initialState => SectionsLoading();

  @override
  Stream<SectionsState> mapEventToState(PageEvent event) async* {
    repository = GenresPageRepository();
    if (event is FetchAllGenresSections) {
      yield* _mapLoadAllGenres(event.page);
    } else if (event is FetchAllHomeSections) {
      yield* _mapLoadAllHomeSections(event.page);
    } else if (event is ReturnToInitialState) {
      yield initialState;
    }
  }

  Stream<SectionsState> _mapLoadAllGenres(int page) async* {
    try {
      final genresSectionsPage = await this.repository.fetchAllGenresSections(page);
      yield SectionLoaded(genresSectionsPage);
    } catch (_) {
      yield SectionsNotLoaded();
    }
  }

  Stream<SectionsState> _mapLoadAllHomeSections(int page) async* {
    try {
      final homeSectionsPage = await this.repository.fetchAllHomeSections(page);
      yield SectionLoaded(homeSectionsPage);
    } catch (_) {
      yield SectionsNotLoaded();
    }
  }
}
