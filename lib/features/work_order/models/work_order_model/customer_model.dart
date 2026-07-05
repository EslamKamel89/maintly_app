class CustomerModel {
  int? id;
  String? companyName;

  CustomerModel({this.id, this.companyName});

  @override
  String toString() => 'Customer(id: $id, companyName: $companyName)';

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      CustomerModel(id: json['id'] as int?, companyName: json['company_name'] as String?);

  Map<String, dynamic> toJson() => {'id': id, 'company_name': companyName};

  CustomerModel copyWith({int? id, String? companyName}) {
    return CustomerModel(id: id ?? this.id, companyName: companyName ?? this.companyName);
  }
}
