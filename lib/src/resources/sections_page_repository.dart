import 'dart:async';
import 'network.dart';
import '../models/sections_page_model.dart';
import '../models/network_models.dart';

class SectionsPageRepository {
  final netwok = Network();

  Future<SectionsPageModel> fetchAllGenresSections(int page) {
    List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.limit, '50')
    ];
    return netwok.fetchGenresSections(parameters);
  }

  Future<SectionsPageModel> fetchAllHomeSections(int page) {
    List<Parameter> parameters = [
      Parameter.forSort(SortType.ascendant, 'section_ordering'),
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.limit, '50'),

    ];
    return netwok.fetchHomeSections(parameters);
  }

}
