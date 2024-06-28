/// salary : 100.0
/// workDate : "2023-06"

class SalaryRecords {
  SalaryRecords({
      num? salary, 
      String? workDate,}){
    _salary = salary;
    _workDate = workDate;
}

  SalaryRecords.fromJson(dynamic json) {
    _salary = json['salary'];
    _workDate = json['workDate'];
  }
  num? _salary;
  String? _workDate;
SalaryRecords copyWith({  num? salary,
  String? workDate,
}) => SalaryRecords(  salary: salary ?? _salary,
  workDate: workDate ?? _workDate,
);
  num? get salary => _salary;
  String? get workDate => _workDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['salary'] = _salary;
    map['workDate'] = _workDate;
    return map;
  }

}