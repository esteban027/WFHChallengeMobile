import 'dart:async';
import 'network.dart';
import '../models/page_model.dart';

class Repository {
  
  final netwok = Network();
  static List<String> genres =  ['Romance','Animation'];

  List<Parameter> parameters= [Parameter(ParamaterType.limit,'100'), Parameter.forSupersetFilter('genres',genres)];

  Future<PageModel> fetchAllMovies() => netwok.fetchMovies(parameters);
}