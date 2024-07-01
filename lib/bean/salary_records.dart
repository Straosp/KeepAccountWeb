/// salary : 2900.0
/// monthQuantity : 570.0
/// singleWorkProductQuantity : 10.0
/// workDate : "2024-06"

class SalaryRecords {
  SalaryRecords({
      num? salary, 
      num? monthQuantity, 
      num? singleWorkProductQuantity, 
      String? workDate,}){
    _salary = salary;
    _monthQuantity = monthQuantity;
    _singleWorkProductQuantity = singleWorkProductQuantity;
    _workDate = workDate;
}

  SalaryRecords.fromJson(dynamic json) {
    _salary = json['salary'];
    _monthQuantity = json['monthQuantity'];
    _singleWorkProductQuantity = json['singleWorkProductQuantity'];
    _workDate = json['workDate'];
  }
  num? _salary;
  num? _monthQuantity;
  num? _singleWorkProductQuantity;
  String? _workDate;
SalaryRecords copyWith({  num? salary,
  num? monthQuantity,
  num? singleWorkProductQuantity,
  String? workDate,
}) => SalaryRecords(  salary: salary ?? _salary,
  monthQuantity: monthQuantity ?? _monthQuantity,
  singleWorkProductQuantity: singleWorkProductQuantity ?? _singleWorkProductQuantity,
  workDate: workDate ?? _workDate,
);
  num? get salary => _salary;
  num? get monthQuantity => _monthQuantity;
  num? get singleWorkProductQuantity => _singleWorkProductQuantity;
  String? get workDate => _workDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['salary'] = _salary;
    map['monthQuantity'] = _monthQuantity;
    map['singleWorkProductQuantity'] = _singleWorkProductQuantity;
    map['workDate'] = _workDate;
    return map;
  }

}