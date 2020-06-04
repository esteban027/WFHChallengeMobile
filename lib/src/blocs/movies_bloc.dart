import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/resources/repository.dart';
import 'package:bloc/bloc.dart';
import '../Events/movies_events.dart';
import '../States/movies_states.dart';

class LoadMoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  Repository repository;

  @override
  MoviesState get initialState => MoviesLoading();

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event == MoviesEvent.loadAllMovies) {
      repository = Repository();
      yield* _mapLoadAllMovies();
    }
  }

  Stream<MoviesState> _mapLoadAllMovies() async* {
    try {
      final movies = await this.repository.fetchAllMovies();
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }
}
