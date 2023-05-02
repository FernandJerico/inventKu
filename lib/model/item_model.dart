import 'dart:typed_data';

class ItemModel {
  late int? id;
  late String nama;
  late int harga;
  late int stok;
  late String tanggal;
  late Uint8List? gambar;
  late String createdBy;

  ItemModel(
      {this.id,
      required this.nama,
      required this.harga,
      required this.stok,
      required this.tanggal,
      this.gambar,
      required this.createdBy});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'stok': stok,
      'tanggal': tanggal,
      'gambar': gambar,
      'createdBy': createdBy,
    };
  }

  ItemModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nama = map['nama'];
    harga = map['harga'];
    stok = map['stok'];
    tanggal = map['tanggal'];
    gambar = map['gambar'];
    createdBy = map['createdBy'];
  }
}
