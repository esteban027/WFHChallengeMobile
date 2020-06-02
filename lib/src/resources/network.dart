import 'dart:async';
import 'package:http/http.dart' ;
import 'dart:convert';
import '../models/page_model.dart';

class Network {
  Client client = Client();
String _url = 'wfh-movies.herokuapp.com';
String _endPoint = 'movie';

Future<PageModel> fetchMovies([List <Parameter> parameterList]) async {
  

  final uri = Uri.http(_url, _endPoint);

  print(uri);

  if (parameterList != null){
    uri.replace(queryParameters: convert(parameterList));
  }

  Response response = await get(uri);
  if(response.statusCode == 200){
    final decodedData = json.decode(response.body);

    PageModel items = PageModel.fromJson(decodedData);
    print(items);
    return items;
    
  } else {
    throw Exception('Failed to load post');
    print(response.statusCode);
  }


}

  convert(List<Parameter> parameters) {
    Map<String, String> convertedParameters;
    for (int i = 0; i > parameters.length; i++) {
      convertedParameters.putIfAbsent(
          parameters[i].type.toString(), () => parameters[i].value);
    }
    return convertedParameters;
  }
}

enum ParamaterType {
  limit,
  page,
  sort,
  filter
}

enum FilterType {
  exact,
  partial,
  start,
  end,
  word_start,
  any_of,
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
      case FilterType.word_start:
        return 'word_start';
      case FilterType.any_of:
        return 'anyOf';
      case FilterType.superset:
        return 'superset';
      default:
        return null;
    }
  }
}



class Parameter {
  ParamaterType type ;
  String value;
  Parameter(this.type,this.value);

  Parameter.forFilter(FilterType filterType, String field, String value) {
    type = ParamaterType.filter;
    value = buidFilterValue(filterType, field, value);
}

buidFilterValue(FilterType filterType, String field, String value) {
return filterType.name + '(' + field + ',' + value + ')';
}
}