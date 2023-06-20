// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'dart:convert';

class Transaction {
  String? id;
  String? date;
  int? duration;
  String? time;
  String? email;
  String? fieldId;
  String? fieldName;
  String? invoice;
  String? name;
  int? price;
  bool? status;

  Transaction({
    this.id,
    this.date,
    this.duration,
    this.time,
    this.email,
    this.fieldId,
    this.fieldName,
    this.invoice,
    this.name,
    this.price,
    this.status,
  });

  @override
  String toString() {
    return 'Transaction(id:$id, date: $date, duration: $duration,time: $time, email: $email, fieldId: $fieldId, fieldName: $fieldName, invoice: $invoice, name: $name, price: $price, status: $status)';
  }

  factory Transaction.fromMap(Map<String, dynamic> data) => Transaction(
        id: data['id'] as String?,
        date: data['date'] as String?,
        duration: data['duration'] as int?,
        time: data['time'] as String?,
        email: data['email'] as String?,
        fieldId: data['field_id'] as String?,
        fieldName: data['field_name'] as String?,
        invoice: data['invoice'] as String?,
        name: data['name'] as String?,
        price: data['price'] as int?,
        status: data['status'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date,
        'duration': duration,
        'time': time,
        'email': email,
        'field_id': fieldId,
        'field_name': fieldName,
        'invoice': invoice,
        'name': name,
        'price': price,
        'status': status,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Transaction].
  factory Transaction.fromJson(String data) {
    return Transaction.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Transaction] to a JSON string.
  String toJson() => json.encode(toMap());

  Transaction copyWith({
    String? id,
    String? date,
    int? duration,
    String? time,
    String? email,
    String? fieldId,
    String? fieldName,
    String? invoice,
    String? name,
    int? price,
    bool? status,
  }) {
    return Transaction(
      id: id ?? this.id,
      date: date ?? this.date,
      duration: duration ?? this.duration,
      time: time ?? this.time,
      email: email ?? this.email,
      fieldId: fieldId ?? this.fieldId,
      fieldName: fieldName ?? this.fieldName,
      invoice: invoice ?? this.invoice,
      name: name ?? this.name,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Transaction) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      date.hashCode ^
      duration.hashCode ^
      time.hashCode ^
      email.hashCode ^
      fieldId.hashCode ^
      fieldName.hashCode ^
      invoice.hashCode ^
      name.hashCode ^
      price.hashCode ^
      status.hashCode;
}
