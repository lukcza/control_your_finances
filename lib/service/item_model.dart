class ItemModel {
  final int? id;
  final String title;
  final DateTime startDate;
  final DateTime nextDate;
  final double amount;
  final String frequency;

  ItemModel({
    this.id,
    required this.title,
    required this.startDate,
    required this.nextDate,
    required this.amount,
    required this.frequency,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'startDate': startDate.toIso8601String(),
      'nextDate': nextDate.toIso8601String(),
      'amount': amount,
      'frequency': frequency,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      title: map['title'],
      startDate: DateTime.parse(map['startDate']),
      nextDate: DateTime.parse(map['nextDate']),
      amount: map['amount'],
      frequency: map['frequency'],
    );
  }

  ItemModel copy({
    int? id,
    String? title,
    DateTime? startDate,
    DateTime? nextDate,
    double? amount,
    String? frequency,
  }) {
    return ItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      nextDate: nextDate ?? this.nextDate,
      amount: amount ?? this.amount,
      frequency: frequency ?? this.frequency,
    );
  }
}