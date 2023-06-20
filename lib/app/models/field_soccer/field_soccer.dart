// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'price.dart';

class FieldSoccer {
  String? id;
  String? nama;
  String? kategori;
  String? picturePath;
  String? description;
  String? alamat;
  Price? price;

  FieldSoccer({
    this.id,
    this.nama,
    this.kategori,
    this.picturePath,
    this.description,
    this.alamat,
    this.price,
  });

  @override
  String toString() {
    return 'FieldSoccer(id: $id, nama: $nama, kategori: $kategori, picturePath: $picturePath, description: $description, alamat: $alamat, price: $price)';
  }

  factory FieldSoccer.fromJson(Map<String, dynamic> json) => FieldSoccer(
        id: json['id'] as String?,
        nama: json['nama'] as String?,
        kategori: json['kategori'] as String?,
        picturePath: json['picture_path'] as String?,
        description: json['description'] as String?,
        alamat: json['alamat'] as String?,
        price: json['price'] == null
            ? null
            : Price.fromJson(json['price'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'kategori': kategori,
        'picture_path': picturePath,
        'description': description,
        'alamat': alamat,
        'price': price?.toJson(),
      };

  FieldSoccer copyWith({
    String? id,
    String? nama,
    String? kategori,
    String? picturePath,
    String? description,
    String? alamat,
    Price? price,
  }) {
    return FieldSoccer(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      kategori: kategori ?? this.kategori,
      picturePath: picturePath ?? this.picturePath,
      description: description ?? this.description,
      alamat: alamat ?? this.alamat,
      price: price ?? this.price,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! FieldSoccer) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      nama.hashCode ^
      kategori.hashCode ^
      picturePath.hashCode ^
      description.hashCode ^
      alamat.hashCode ^
      price.hashCode;
}
