// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class Price {
  int? weekday14sd18;
  int? weekday18sd00;
  int? weekday7sd13;
  int? weekend14sd18;
  int? weekend18sd00;
  int? weekend7sd13;

  Price({
    this.weekday14sd18,
    this.weekday18sd00,
    this.weekday7sd13,
    this.weekend14sd18,
    this.weekend18sd00,
    this.weekend7sd13,
  });

  @override
  String toString() {
    return 'Price(weekday14sd18: $weekday14sd18, weekday18sd00: $weekday18sd00, weekday7sd13: $weekday7sd13, weekend14sd18: $weekend14sd18, weekend18sd00: $weekend18sd00, weekend7sd13: $weekend7sd13)';
  }

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        weekday14sd18: json['weekday14sd18'] as int?,
        weekday18sd00: json['weekday18sd00'] as int?,
        weekday7sd13: json['weekday7sd13'] as int?,
        weekend14sd18: json['weekend14sd18'] as int?,
        weekend18sd00: json['weekend18sd00'] as int?,
        weekend7sd13: json['weekend7sd13'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'weekday14sd18': weekday14sd18,
        'weekday18sd00': weekday18sd00,
        'weekday7sd13': weekday7sd13,
        'weekend14sd18': weekend14sd18,
        'weekend18sd00': weekend18sd00,
        'weekend7sd13': weekend7sd13,
      };

  Price copyWith({
    int? weekday14sd18,
    int? weekday18sd00,
    int? weekday7sd13,
    int? weekend14sd18,
    int? weekend18sd00,
    int? weekend7sd13,
  }) {
    return Price(
      weekday14sd18: weekday14sd18 ?? this.weekday14sd18,
      weekday18sd00: weekday18sd00 ?? this.weekday18sd00,
      weekday7sd13: weekday7sd13 ?? this.weekday7sd13,
      weekend14sd18: weekend14sd18 ?? this.weekend14sd18,
      weekend18sd00: weekend18sd00 ?? this.weekend18sd00,
      weekend7sd13: weekend7sd13 ?? this.weekend7sd13,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Price) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      weekday14sd18.hashCode ^
      weekday18sd00.hashCode ^
      weekday7sd13.hashCode ^
      weekend14sd18.hashCode ^
      weekend18sd00.hashCode ^
      weekend7sd13.hashCode;
}
