import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';
import '../models/page_model.dart';

class Network {
  Client client = Client();
  String _url = 'wfh-movies.herokuapp.com';
  String _endPoint = 'movie';

  Future<PageModel> fetchMovies([List<Parameter> parameterList]) async {
    Uri uri = Uri.http(_url, _endPoint);

    if (parameterList != null) {
      uri = uri.replace(queryParameters: convert(parameterList));
    }

    Response response = await get(uri,headers: {'API_KEY':'y1N478S5GfjcSlaiyUp7oaztpRNUii7lhwl7cvbNinIjPu2AWzRf7T9qH7dFuPcC'});
    if (response.statusCode == 200) {
      PageModel items = PageModel.fromJson(json.decode(response.body));
      return items;
    } else {
      throw Exception(response.statusCode);
    }
  }

  convert(List<Parameter> parameters) {
    Map<String, String> convertedParameters = {};
    print(parameters.length);
    for (int i = 0; i < parameters.length; i++) {
      convertedParameters[parameters[i].type.name] = parameters[i].value;
    }
    return convertedParameters;
  }
}

enum ParamaterType { limit, page, sort, filter }

extension ParameterTypeExtension on ParamaterType {
  String get name {
    switch (this) {
      case ParamaterType.limit:
        return 'limit';
      case ParamaterType.page:
        return 'page';
      case ParamaterType.sort:
        return 'sort';
      case ParamaterType.filter:
        return 'filter';
      default:
        return null;
    }
  }
}

enum FilterType {
  exact,
  partial,
  start,
  end,
  wordStart,
  anyOf,
  lessThan,
  lessOrEqual,
  greaterThan,
  greaterOrEqual,
  superset
}

extension FilterTypeExtension on FilterType {
  String get name {
    switch (this) {
      case FilterType.exact:
        return 'exact';
      case FilterType.partial:
        return 'partial';
      case FilterType.start:
        return 'start';
      case FilterType.end:
        return 'end';
      case FilterType.wordStart:
        return 'word_start';
      case FilterType.anyOf:
        return 'anyOf';
      case FilterType.superset:
        return 'superset';
      case FilterType.lessThan:
        return 'lt';
      case FilterType.lessOrEqual:
        return 'le';
      case FilterType.greaterThan:
        return 'gt';
      case FilterType.greaterOrEqual:
        return 'ge';
      default:
        return null;
    }
  }
}

enum SortType { ascendant, descendant }

extension SortTypeExtension on SortType {
  String get name {
    switch (this) {
      case SortType.ascendant:
        return 'asc';
      case SortType.descendant:
        return 'desc';
    }
  }
}

class Parameter {
  ParamaterType type;

  String value;

  Parameter(this.type, this.value);

  Parameter.forFilter(FilterType filterType, String field, String value) {
    type = ParamaterType.filter;
    this.value = _buildFilterValue(filterType, field, value);
  }

  Parameter.forSupersetFilter(String field, List<String> values) {
    type = ParamaterType.filter;
    String valuesListFormattedString = _buildValuesListString(values);
    this.value = _buildFilterValue(
        FilterType.superset, field, valuesListFormattedString);
  }

  Parameter.forSort(SortType sortType, String field) {
    type = ParamaterType.sort;
    value = field + '.' + sortType.name;
  }

  String _buildFilterValue(FilterType filterType, String field, String value) {
    return filterType.name + '($field, $value)';
  }

  String _buildValuesListString(List<String> genres) {
    String formattedValue = '';
    int lastGenreListPosition = genres.length - 1;
    for (int i = 0; i < genres.length; i++) {
      if (i != lastGenreListPosition) {
        formattedValue += genres[i] + '|';
      } else {
        formattedValue += genres[i];
      }
    }
    return formattedValue;
  }
}
