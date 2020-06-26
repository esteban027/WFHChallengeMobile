class SectionsPageModel {
  int _page;
  int _totalPages;
  int _totalItems;
  int _itemsPerPage;
  bool _hasNext;
  bool _hasPrev;
  List<SectionModel> _items = [];

  SectionsPageModel.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _totalPages = parsedJson['total_pages'];
    _totalItems = parsedJson['total_items'];
    _itemsPerPage = parsedJson['items_per_page'];
    _hasNext = parsedJson['has_next'];
    _hasPrev = parsedJson['has_prev'];
    List<SectionModel> temp = [];
    for (int i = 0; i < parsedJson['items'].length; i++) {
      SectionModel genreModel = SectionModel(parsedJson['items'][i]);
      temp.add(genreModel);
    }
    _items = temp;
  }
  int get page => _page;

  int get totalPages => _totalPages;

  int get totalItems => _totalItems;

  int get itemsPerPage => _itemsPerPage;

  bool get hasNext => _hasNext;

  bool get hasPrev => _hasNext;

  List<SectionModel> get items => _items;
}

class SectionModel {
  String _id;
  String _posterPath;

  SectionModel(sectionModel) {
    _posterPath = sectionModel['poster_path'];
    _id = sectionModel['id'];
  }

  String get posterPath {
    return _posterPath == null
        ? 'https://i0.wp.com/oij.org/wp-content/uploads/2016/05/placeholder.png?ssl=1'
        : _posterPath;
  }

  String get id => _id;
}
