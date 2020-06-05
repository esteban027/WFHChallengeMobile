import 'dart:async';
import 'network.dart';
import '../models/genres_page_model.dart';
import '../models/network_models.dart';

class GenresPageRepository {
  final netwok = Network();

  Future<GenresPageModel> fetchAllGneres(int page) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.limit, '50')
    ];
    return netwok.fetchGenres(parameters);
  }
}
