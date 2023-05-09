import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:inventku/model/item_model.dart';
import 'package:mockito/mockito.dart';

import 'item_test.mocks.dart';

class DbManager extends Mock implements MockDbManager {}

void main() {
  group('Test Item', () {
    late MockDbManager mockDbManager;
    late ItemModel item;

    setUp(() {
      mockDbManager = MockDbManager();
      item = ItemModel(
        id: 1,
        nama: 'Test Item',
        harga: 10000,
        stok: 10,
        gambar: Uint8List.fromList([1, 2, 3]),
        tanggal: '01/01/2022',
        createdBy: 'Test User',
      );
    });

    test('should return a valid map from toMap', () {
      final expectedMap = {
        'id': 1,
        'nama': 'Test Item',
        'harga': 10000,
        'stok': 10,
        'tanggal': '01/01/2022',
        'gambar': Uint8List.fromList([1, 2, 3]),
        'createdBy': 'Test User',
      };
      final map = item.toMap();
      expect(map, equals(expectedMap));
    });

    test('should create a valid ItemModel from a map', () {
      final map = {
        'id': 1,
        'nama': 'Test Item',
        'harga': 10000,
        'stok': 10,
        'tanggal': '01/01/2022',
        'gambar': Uint8List.fromList([1, 2, 3]),
        'createdBy': 'Test User',
      };
      final expectedItem = ItemModel(
        id: 1,
        nama: 'Test Item',
        harga: 10000,
        stok: 10,
        gambar: Uint8List.fromList([1, 2, 3]),
        tanggal: '01/01/2022',
        createdBy: 'Test User',
      );
      final itemFromMap = ItemModel.fromMap(map);
      expect(itemFromMap.toMap(), equals(expectedItem.toMap()));
    });

    test('should add item to database', () async {
      const nama = 'Test Item';
      const harga = '10000';
      const stok = '10';
      final imageBytes = [1, 2, 3];
      const date = '09/05/2023';
      const createdBy = 'Test User';

      final addItem = ItemModel(
        nama: nama,
        harga: int.parse(harga),
        stok: int.parse(stok),
        gambar: Uint8List.fromList(imageBytes),
        tanggal: date,
        createdBy: createdBy,
      );

      when(mockDbManager.addItem(addItem))
          .thenAnswer((_) => Future<void>.value());

      await mockDbManager.addItem(addItem);

      verify(mockDbManager.addItem(addItem)).called(1);
    });

    test('should update item in database', () async {
      const id = 1;
      const updatedNama = 'Updated Test Item';
      const updatedHarga = 15000;
      const updatedStok = 5;
      const updatedDate = '09/05/2023';
      const updatedCreatedBy = 'Updated Test User';

      final updatedItem = ItemModel(
        id: id,
        nama: updatedNama,
        harga: updatedHarga,
        stok: updatedStok,
        tanggal: updatedDate,
        createdBy: updatedCreatedBy,
      );

      when(mockDbManager.updateItem(id, updatedItem))
          .thenAnswer((_) => Future.value());

      mockDbManager.updateItem(id, updatedItem);

      verify(mockDbManager.updateItem(id, updatedItem)).called(1);
    });

    test('should delete item in database', () async {
      const id = 1;

      when(mockDbManager.deleteItem(id)).thenAnswer((_) => Future.value());

      mockDbManager.deleteItem(id);

      verify(mockDbManager.deleteItem(id)).called(1);
    });
  });
}
