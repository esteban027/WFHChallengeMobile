class UserModel {
  String _firebaseId;
  int _id;
  String _name;
  String _email;
  String _genres;

  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    _firebaseId = parsedJson['external_token'];
    _id = int.parse(parsedJson['id']);
    _name = parsedJson['name'];
    _email = parsedJson['email'];
    _genres = parsedJson['genres'];
  }

  UserModel(userModel) {
    _firebaseId = userModel['external_token'];
    _id = int.parse(userModel['id']);
    _name = userModel['name'];
    _email = userModel['email'];
    _genres = userModel['genres'];
  }

  UserModel.buildLocal(this._firebaseId, this._name, this._email, this._genres);

  Map toJson() => {
        "external_token": this._firebaseId,
        "name": this._name,
        "email": this._email,
        "genres": this._genres
      };

  String get firebaseId => _firebaseId;

  int get id => _id;

  String get name => _name;

  String get email => _email;

  String get genres => _genres;

  void set genres(String genres) {
    _genres = genres;
  }
}
