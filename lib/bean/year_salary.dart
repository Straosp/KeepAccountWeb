/// salary : 24185.0

class YearSalary {
  YearSalary({
      num? salary,}){
    _salary = salary;
}

  YearSalary.fromJson(dynamic json) {
    _salary = json['salary'];
  }
  num? _salary;
YearSalary copyWith({  num? salary,
}) => YearSalary(  salary: salary ?? _salary,
);
  num? get salary => _salary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['salary'] = _salary;
    return map;
  }

}