import 'user.dart';

/// id : 1
/// teamSize : 2
/// productPrice : 1.0
/// productQuantity : 100
/// workDate : "2024-6-7"
/// users : [{"id":1,"username":"小明","phone":"123456789"},{"id":2,"username":"小王","phone":"1234567"}]

class WorkRecords {
  WorkRecords({
      int? id,
      int? teamSize,
      double? productPrice,
      int? productQuantity,
      String? workDate, 
      List<User>? users,}){
    _id = id;
    _teamSize = teamSize;
    _productPrice = productPrice;
    _productQuantity = productQuantity;
    _workDate = workDate;
    _users = users;
}

  WorkRecords.fromJson(dynamic json) {
    _id = json['id'];
    _teamSize = json['teamSize'];
    _productPrice = json['productPrice'];
    _productQuantity = json['productQuantity'];
    _workDate = json['workDate'];
    if (json['users'] != null) {
      _users = [];
      json['users'].forEach((v) {
        _users?.add(User.fromJson(v));
      });
    }
  }
  int? _id;
  int? _teamSize;
  double? _productPrice;
  int? _productQuantity;
  String? _workDate;
  List<User>? _users;
WorkRecords copyWith({  int? id,
  int? teamSize,
  double? productPrice,
  int? productQuantity,
  String? workDate,
  List<User>? users,
}) => WorkRecords(  id: id ?? _id,
  teamSize: teamSize ?? _teamSize,
  productPrice: productPrice ?? _productPrice,
  productQuantity: productQuantity ?? _productQuantity,
  workDate: workDate ?? _workDate,
  users: users ?? _users,
);
  int? get id => _id;
  int? get teamSize => _teamSize;
  double? get productPrice => _productPrice;
  int? get productQuantity => _productQuantity;
  String? get workDate => _workDate;
  List<User>? get users => _users;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['teamSize'] = _teamSize;
    map['productPrice'] = _productPrice;
    map['productQuantity'] = _productQuantity;
    map['workDate'] = _workDate;
    if (_users != null) {
      map['users'] = _users?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
