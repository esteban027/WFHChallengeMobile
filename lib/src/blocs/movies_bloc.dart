import 'package:WFHchallenge/src/resources/sign_in_repository.dart';

import '../resources/movies_page_repository.dart';
import 'package:bloc/bloc.dart';
import '../Events/movies_events.dart';
import '../Events/pages_events.dart';
import '../States/movies_states.dart';

class LoadMoviesBloc extends Bloc<PageEvent, MoviesState> {
  MoviesPageRepository repository;
  SignInRepository signInRepository;
  int userId;

  @override
  MoviesState get initialState => MoviesLoading();

  @override
  Stream<MoviesState> mapEventToState(PageEvent event) async* {
    repository = MoviesPageRepository();
    signInRepository = SignInRepository(false); 
    userId = await signInRepository.getUserId();

    if (event is FetchAllMovies) {
      yield* _mapLoadAllMovies(event.page);
    } else if (event is FetchTopMovies) {
      yield* _mapLoadTopMovies(event.page);
    } else if (event is FetchMoviesByGenres) {
      yield* _mapLoadMoviesByGenres(event.page, event.genres);
    } else if (event is FetchTopMoviesByGenres) {
      yield* _mapLoadTopMoviesByGenres(event.page, event.genres);
    } else if (event is FetchMoviesByTitle) {
      yield* _mapLoadMoviesByTitle(event.page, event.title);
    } else if (event is FetchTopMoviesByLatestRelease) {
      yield* _mapLoadTopMoviesByReleaseDate(event.page);
    } else if (event is ReturnToInitialState) {
      yield initialState;
    } else if (event is FetchMoviesRecommendationToUser) {
      yield*  _mapRecommendMoviesTo(event.userId, event.page);
    } else if (event is FetchMoviesRecommendationFromMovie) {
      yield* _mapRecommendMoviesFrom(event.movieId,event.page);
    } else if (event is PaginateMovies){
      yield  MoviesPaginationLoading();
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
      final movies = await this.repository.fetchTopMovies(page,userId);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }

  Stream<MoviesState> _mapLoadMoviesByGenres(
      int page, List<String> genres) async* {
    try {
      final movies = await this.repository.fetchMoviesByGenres(page, genres,userId);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }

  Stream<MoviesState> _mapLoadTopMoviesByGenres(
      int page, List<String> genres) async* {
    try {
      final movies = await this.repository.fetchTopMoviesByGenres(page, genres,userId);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }

  Stream<MoviesState> _mapLoadMoviesByTitle(int page, String title) async* {
    try {
      final movies = await this.repository.fetchMoviesByTitle(page, title,userId);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }

  Stream<MoviesState> _mapLoadTopMoviesByReleaseDate(int page) async* {
    try {
      final movies = await this.repository.fetchTopMoviesByReleaseDate(page,userId);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }

  Stream<MoviesState> _mapRecommendMoviesTo(int page)  async* {
    try {
      final movies = await this.repository.fetchMoviesRecommendationTo(userId, page);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }

  Stream<MoviesState> _mapRecommendMoviesFrom(int movieId, int page)  async* {
    try {
      final movies = await this.repository.fetchMoviesRecommendationFrom(movieId,page,userId);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }
}
