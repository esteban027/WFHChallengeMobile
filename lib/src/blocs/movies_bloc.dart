import 'package:flutter/foundation.dart';
import '../resources/Repository.dart';
import '../models/item_model.dart';
import 'package:bloc/bloc.dart';
import '../Events/movies_events.dart';
import '../States/movies_states.dart';




 class LoadMoviesBloc extends Bloc<MoviesEvent, MoviesState> {
   final Repository repository;

   LoadMoviesBloc({@required this.repository});

  @override
 
  MoviesState get initialState => MoviesLoading();

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    
    if (event is LoadAllMovies) {
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