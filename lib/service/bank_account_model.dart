class BankAccountModel {
  final int? id;
  final String name;
  final String accountNumber;
  BankAccountModel({
    this.id,
    required this.name,
    required this.accountNumber,
  });
  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'name': name,
      'accountNumber': accountNumber,
    };
  }
  factory BankAccountModel.fromMap(Map<String, dynamic> map){
    return BankAccountModel(
      id: map['id'],
      name: map['name'],
      accountNumber: map['accountNumber']
      );
  }
  BankAccountModel copy({
    int? id,
    String? name,
    String? accountNumber,
  }) {
    return BankAccountModel(
      id: id ?? this.id,
      name: name ?? this.name,
      accountNumber: accountNumber ?? this.accountNumber,
    );
  }
}
