
/// id : 1
/// username : "小明"
/// phone : "123456789"

class User {
  User({
    int? id,
    String? username,
    String? phone,}){
    _id = id;
    _username = username;
    _phone = phone;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _phone = json['phone'];
  }
  int? _id;
  String? _username;
  String? _phone;
  User copyWith({  int? id,
    String? username,
    String? phone,
  }) => User(  id: id ?? _id,
    username: username ?? _username,
    phone: phone ?? _phone,
  );
  int? get id => _id;
  String? get username => _username;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['phone'] = _phone;
    return map;
  }

}