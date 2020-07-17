import '../models/user_model.dart';
class UserPageModel {
  int _page;
  int _totalPages;
  int _totalItems;
  int _itemsPerPage;
  bool _hasNext;
  bool _hasPrev;
  List<UserModel> _items = [];

  UserPageModel.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _totalPages = parsedJson['total_pages'];
    _totalItems = parsedJson['total_items'];
    _itemsPerPage = parsedJson['items_per_page'];
    _hasNext = parsedJson['has_next'];
    _hasPrev = parsedJson['has_prev'];
    List<UserModel> temp = [];
    for (int i = 0; i < parsedJson['items'].length; i++) {
      UserModel userModel = UserModel(parsedJson['items'][i]);
      temp.add(userModel);
    }
    _items = temp;
  }
  int get page => _page;

  int get totalPages => _totalPages;

  int get totalItems => _totalItems;

  int get itemsPerPage => _itemsPerPage;

  bool get hasNext => _hasNext;

  bool get hasPrev => _hasNext;

  List<UserModel> get items => _items;
}