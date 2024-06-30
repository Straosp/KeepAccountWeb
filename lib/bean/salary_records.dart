/// salary : 24185.0
/// monthQuantity : 2418.5
/// workDate : "2024"

class SalaryRecords {
  SalaryRecords({
      num? salary, 
      num? monthQuantity, 
      String? workDate,}){
    _salary = salary;
    _monthQuantity = monthQuantity;
    _workDate = workDate;
}

  SalaryRecords.fromJson(dynamic json) {
    _salary = json['salary'];
    _monthQuantity = json['monthQuantity'];
    _workDate = json['workDate'];
  }
  num? _salary;
  num? _monthQuantity;
  String? _workDate;
SalaryRecords copyWith({  num? salary,
  num? monthQuantity,
  String? workDate,
}) => SalaryRecords(  salary: salary ?? _salary,
  monthQuantity: monthQuantity ?? _monthQuantity,
  workDate: workDate ?? _workDate,
);
  num? get salary => _salary;
  num? get monthQuantity => _monthQuantity;
  String? get workDate => _workDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['salary'] = _salary;
    map['monthQuantity'] = _monthQuantity;
    map['workDate'] = _workDate;
    return map;
  }

}