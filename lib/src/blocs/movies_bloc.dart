import 'package:WFHchallenge/src/Events/movies_events.dart';
import '../resources/repository.dart';
import 'package:bloc/bloc.dart';
import '../Events/movies_events.dart';
import '../States/movies_states.dart';

class LoadMoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  Repository repository;

  @override
  MoviesState get initialState => MoviesLoading();

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    repository = Repository();
    if (event is  FetchAllMovies) {
      yield* _mapLoadAllMovies(event.page);
    } else if (event is FetchTopMovies) {
      yield* _mapLoadTopMovies(event.page);
    } 
  }

  Stream<MoviesState> _mapLoadAllMovies(int page) async* {
    try {
      final movies = await this.repository.fetchAllMovies(page);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }

  Stream<MoviesState> _mapLoadTopMovies(int page) async* {
    try {
      final movies = await this.repository.fetchTopMovies(page);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }
}
